import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insta_clone/const.dart';
import 'package:insta_clone/user_feature/core/failure.dart';
import 'package:insta_clone/user_feature/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:insta_clone/user_feature/data/model/post_model.dart';
import 'package:insta_clone/user_feature/data/model/user_model.dart';
import 'package:insta_clone/user_feature/domain/entity/post_entity.dart';
import 'package:insta_clone/user_feature/domain/entity/user_entity.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  FirebaseFirestore? store;
  FirebaseAuth? auth;
  FirebaseStorage? storage;

  RemoteDataSourceImpl(
      {required this.store, required this.auth, required this.storage});

  @override
  Future createUser(UserEntity userEntity) async {
    final uid = await getCurrentUid();
    final json = UserModel(
            uid: uid,
            userName: userEntity.name,
            profileUrl: userEntity.profileUrl,
            email: userEntity.email,
            career: userEntity.career,
            bio: userEntity.bio,
            name: userEntity.name)
        .toJson();
    try {
      CollectionReference ref = store!.collection(FirebaseConst.userCollection);
      await ref.doc(uid).set(json);
    } catch (e) {
      throw (Failure(errorMessage: e.toString()));
    }
  }

  @override
  Future<String> getCurrentUid() async {
    return auth!.currentUser!.uid;
  }
  User getCurrentUser(){
    return auth!.currentUser!;
  }

  @override
  Future<List<UserEntity>> getSingleUser(String uid) async {
    try {
      final ref = store!
          .collection(FirebaseConst.userCollection)
          .where(FirebaseConst.uid, isEqualTo: uid);
      final user = ref.get().then((value) =>
          value.docs.map((doc) => UserModel.fromDocSnapShot(doc)).toList());
      return user;
    } catch (e) {
      throw Failure(errorMessage: e.toString());
    }
  }

  @override
  Future<List<UserEntity>> getUsers() async {
    final ref = store!.collection(FirebaseConst.userCollection);
    final users = ref.get().then((value) =>
        value.docs.map((doc) => UserModel.fromDocSnapShot(doc)).toList());
    return users;
  }

  @override
  Future<bool> isLoggedIn() async {
    return auth!.currentUser?.uid != null;
  }

  @override
  Future signIn(UserEntity userEntity) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userEntity.email!, password: userEntity.password!);
      return credential;
    } on FirebaseAuthException catch (e) {
      throw Failure(errorMessage: e.code);
    } catch (e) {
      throw Failure(errorMessage: "un known error");
    }
  }

  @override
  Future<void> signOut() async {
    await auth!.signOut();
  }

  @override
  Future signUp(UserEntity userEntity) async {
    final credential = await auth!.createUserWithEmailAndPassword(
      email: userEntity.email!,
      password: userEntity.password!,
    );
    return credential;
  }

  @override
  Future updateUser() {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future addImageToFireStorage(File image,bool isPost) {
    try {
      final imageName = DateTime.now().millisecondsSinceEpoch.toString();
      if(isPost){
        final ref = storage!.ref().child("post_images/$imageName.jpg");
      var imageUrl = ref.putFile(image).then((p0) => p0.ref.getDownloadURL());
      return imageUrl;
      }else{
    final ref = storage!.ref().child("profile_images/$imageName.jpg");
    var imageUrl = ref.putFile(image).then((p0) => p0.ref.getDownloadURL());
    return imageUrl;}
    } catch (e) {
      throw {Failure(errorMessage: e.toString())};
    }
  }

//posts
  @override
  Future createPost(PostEntity postEntity) async {
    DocumentReference ref =
        store!.collection(FirebaseConst.postCollection).doc(postEntity.postId);
    final docSnapShot = await ref.get();
    final newPost = PostModel(
            profileImage: postEntity.profileImage,
            postImageUrl: postEntity.postImageUrl,
            postId: postEntity.postId,
            likes: [],
            likeNumber: 0,
            description: postEntity.description,
            creatorId: postEntity.creatorId,
            createdAt: postEntity.createdAt,
            commentNumber: "0",
            userName: postEntity.userName,
            name: postEntity.name)
        .toJson();
    if (!docSnapShot.exists) {
      await ref.set(newPost);
    } else {
      await ref.update(newPost);
    }
  }

  @override
  Future deletePost(PostEntity postEntity)async {
   await store!.collection(FirebaseConst.userCollection).doc(postEntity.postId).delete();
  }

  @override
  Stream<List<PostEntity>> getPost(){
  final colRef=store!.collection(FirebaseConst.postCollection).orderBy(FirebaseConst.createdAt,descending: true);
  final snapShots=colRef.snapshots();
  final data=snapShots.map((event) => event.docs.map((e) => PostModel.fromDocSnapShot(e.data())).toList());
 return data;
  }

  @override
  Future updatePost(PostEntity postEntity){
    throw"";
  }

  @override
  Future<bool> likePost(PostEntity postEntity)async{
  DocumentReference ref= store!.collection(FirebaseConst.postCollection).doc(postEntity.postId);
 final uid= await getCurrentUid();
 final postRef=await ref.get();
  List likes= await postRef.get(FirebaseConst.likes);
 final likeNumber=await postRef.get(FirebaseConst.likeNumber);
 if(postRef.exists){
   if(likes.contains(uid)){
     likes.removeWhere((element) => element==uid);
     ref.update({
       FirebaseConst.likes:likes,
       FirebaseConst.likeNumber:likeNumber-1

     });
     return false;
   }
  else {
    likes.add(uid);
    ref.update(
      {
        FirebaseConst.likes:likes,
        FirebaseConst.likeNumber:likeNumber+1
      }
    );
    return true;
   }
 }
 else{
throw Failure(errorMessage: "this post has been remove or not found");
 }


  }
}


