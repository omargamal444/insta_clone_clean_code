import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insta_clone/const.dart';
import 'package:insta_clone/user_feature/core/failure.dart';
import 'package:insta_clone/user_feature/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:insta_clone/user_feature/data/model/comment_model.dart';
import 'package:insta_clone/user_feature/data/model/post_model.dart';
import 'package:insta_clone/user_feature/data/model/user_model.dart';
import 'package:insta_clone/user_feature/domain/entity/comment_entity.dart';
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
      followerNumber: 1,
      followingNumber: 0,
      followers: [uid],
      following: [],
      uid: uid,
      postNumber: 0,
      userName: userEntity.name,
      profileUrl: userEntity.profileUrl,
      email: userEntity.email,
      career: userEntity.career,
      bio: userEntity.bio,
      name: userEntity.name,
    ).toJson();
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

  User getCurrentUser() {
    return auth!.currentUser!;
  }

  @override
 Stream<UserEntity> getSingleUser(String uid){
    final collectionRef = store!.collection(FirebaseConst.userCollection);
    final docRef= collectionRef.doc(uid);
    final data=docRef.snapshots().map((docSnapShot) =>UserModel.fromDocSnapShot(docSnapShot.data()!));
    return data;
  }

  @override
  Future<List<UserEntity>> getUsers() async {
    final ref = store!.collection(FirebaseConst.userCollection);
    final users = ref.get().then((value) =>
        value.docs.map((doc) => UserModel.fromDocSnapShot(doc.data())).toList());
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
  Future updateUser(UserEntity currentUser)async{
    final Map<String,dynamic> data;
  DocumentReference docRef=store!.collection(FirebaseConst.userCollection).doc(currentUser.uid);
    if(currentUser.name!=null&&currentUser.name!=""){
      data={FirebaseConst.name:currentUser.name};
      await docRef.update(data);
    }
    if(currentUser.userName!=null&&currentUser.userName!=""){
      final Map<String,dynamic> data;
      data={FirebaseConst.userName:currentUser.userName};
      await docRef.update(data);
    }
    if(currentUser.career!=null&&currentUser.career!=""){
      final Map<String,dynamic> data;
      data={FirebaseConst.career:currentUser.career};
      await docRef.update(data);
    }
    if(currentUser.profileUrl!=null&&currentUser.profileUrl!=""){
      final Map<String,dynamic> data;
      data={FirebaseConst.profileUrl:currentUser.profileUrl};
      await docRef.update(data);
    }
    if(currentUser.postNumber!=null){
      final Map<String,dynamic> data;
      data={FirebaseConst.postNumber:currentUser.postNumber};
      await docRef.update(data);
    }
  }

  @override
  Future addImageToFireStorage(File image, bool isPost) async {
    try {
      final imageName = DateTime.now().millisecondsSinceEpoch.toString();
      if (isPost) {
        final ref = storage!.ref().child("post_images/$imageName.jpg");
        final imageUrl =
            await ref.putFile(image).then((p0) => p0.ref.getDownloadURL());
        return imageUrl;
      } else {
        final ref = storage!.ref().child("profile_images/$imageName.jpg");
        var imageUrl = ref.putFile(image).then((p0) => p0.ref.getDownloadURL());
        return imageUrl;
      }
    } on FirebaseException catch (e) {
      throw {Failure(errorMessage: e.code)};
    } catch (e) {
      throw {Failure(errorMessage: e.toString())};
    }
  }

//posts
  @override
  Future createPost(PostEntity postEntity,UserEntity currentUser) async {
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
            commentNumber: 0,
            userName: postEntity.userName,
            name: postEntity.name)
        .toJson();
    if (!docSnapShot.exists) {
      await ref.set(newPost);
    await updateUser(currentUser);
    } else {
      await ref.update(newPost);
      await updateUser(currentUser);
    }
  }

  @override
  Future deletePost(PostEntity postEntity) async {
    final currentUser=await store!.collection(FirebaseConst.userCollection).doc(postEntity.creatorId)
    .get().then((value) => UserModel.fromDocSnapShot(value.data()!));
    await store!
        .collection(FirebaseConst.postCollection)
        .doc(postEntity.postId)
        .delete();
    await store!
        .collection(FirebaseConst.userCollection).doc(postEntity.creatorId).update(
      {FirebaseConst.postNumber:currentUser.postNumber!-1}
    );
    await store!.collection(FirebaseConst.commentCollection).where(
      FirebaseConst.postId,isEqualTo: postEntity.postId).get().then((value) =>
    value.docs.forEach((element) {
      store!.collection(FirebaseConst.commentCollection).doc(element.id).delete();
    }));
  }

  @override
  Stream<List<PostEntity>> getPost(UserEntity currentUser,String useLocation) {
if(useLocation=="searchPage"){
  final colRef= store!.collection(FirebaseConst.postCollection);
  final snapShots = colRef.snapshots();
  final data = snapShots.map((event) =>
      event.docs.map((e) => PostModel.fromDocSnapShot(e.data())).toList());
  return data;
}
 else{
  final colRef= store!.collection(FirebaseConst.postCollection)
      .where(FirebaseConst.creatorId, whereIn: currentUser.followers);
  final snapShots = colRef.snapshots();
  final data = snapShots.map((event) =>
      event.docs.map((e) => PostModel.fromDocSnapShot(e.data())).toList());
  return data;
}
  }
  @override
  Stream<List<PostEntity>> getProfilePosts(UserEntity currentUser) {
    final colRef= store!.collection(FirebaseConst.postCollection)
        .where(FirebaseConst.creatorId, isEqualTo: currentUser.uid);
    final snapShots = colRef.snapshots();
    final data = snapShots.map((event) =>
        event.docs.map((e) => PostModel.fromDocSnapShot(e.data())).toList());
    return data;
  }
  @override
  Future updatePost(PostEntity postEntity) async {
    Map<String, dynamic> data;
    if(postEntity.postImageUrl!=null){
      data= {
        FirebaseConst.postImageUrl: postEntity.postImageUrl};
      await store!
          .collection(FirebaseConst.postCollection)
          .doc(postEntity.postId)
          .update(data);
    }
    if(postEntity.description!=null){
      Map<String, dynamic> data;
      data= {
        FirebaseConst.postDescription: postEntity.description};
      await store!
          .collection(FirebaseConst.postCollection)
          .doc(postEntity.postId)
          .update(data);
    }

  }

  @override
  Future<bool> likePost(PostEntity postEntity) async {
    DocumentReference ref =
        store!.collection(FirebaseConst.postCollection).doc(postEntity.postId);
    final uid = await getCurrentUid();
    final postRef = await ref.get();
    List likes = await postRef.get(FirebaseConst.likes);
    final likeNumber = await postRef.get(FirebaseConst.likeNumber);
    if (postRef.exists) {
      if (likes.contains(uid)) {
        likes.removeWhere((element) => element == uid);
        ref.update({
          FirebaseConst.likes: likes,
          FirebaseConst.likeNumber: likeNumber - 1
        });
        return false;
      } else {
        likes.add(uid);
        ref.update({
          FirebaseConst.likes: likes,
          FirebaseConst.likeNumber: likeNumber + 1
        });
        return true;
      }
    } else {
      throw Failure(errorMessage: "this post has been remove or not found");
    }

//comment
  }

//comment
  @override
  Future createComment({required CommentEntity commentEntity}) async {
    final post=await store!.collection(FirebaseConst.postCollection).doc(
      commentEntity.postId).get().then((value) =>
    PostModel.fromDocSnapShot(value.data()!));
    final currentUserUid = auth!.currentUser!.uid;
    DocumentReference ref = store!
        .collection(FirebaseConst.commentCollection)
        .doc(commentEntity.commentId);
    DocumentSnapshot docSnap = await ref.get();
    Map<String, dynamic> data = CommentModel(
            commentatorUid: currentUserUid,
            commentId: commentEntity.commentId,
            postId: commentEntity.postId,
            likeNumber: 0,
            likes: [],
            commentDescription: commentEntity.commentDescription,
            commentatorProfileImageUrl:
            commentEntity.commentatorProfileImageUrl,
            createdAt: commentEntity.createdAt,
            commentatorName: commentEntity.commentatorName,
            creatorId: commentEntity.creatorId,
            isMainComment:commentEntity.isMainComment,
            mainCommentId:commentEntity.mainCommentId,
            subComments:[]
             )
        .toJson();

    if (docSnap.exists) {
      await ref.update(data);

    } else {
      await ref.set(data);
    }
    await store!
        .collection(FirebaseConst.postCollection)
        .doc(commentEntity.postId)
        .update({FirebaseConst.commentNumber:post.commentNumber!+1});
  }

  @override
  Stream<List<CommentEntity>> getComments({required PostEntity postEntity}) {
    final collectionRef = store!
        .collection(FirebaseConst.commentCollection)
        // .orderBy(FirebaseConst.createdAt,descending: true)
        .where(FirebaseConst.postId, isEqualTo: postEntity.postId).where(
      "isMainComment",isEqualTo: "mainComment"
    );
    Stream<List<CommentEntity>> comments = collectionRef.snapshots().map(
        (snapShot) => snapShot.docs
            .map((streamDocSnapShot) =>
                CommentModel.fromDocSnapShot(streamDocSnapShot.data()))
            .toList());
    return comments;
  }
  @override
  Stream<List<CommentEntity>> getSubComments({required CommentEntity mainCommentEntity}){
    final collectionRef = store!
        .collection(FirebaseConst.commentCollection)
        .where(FirebaseConst.mainCommentId, isEqualTo: mainCommentEntity.commentId).where(
        "isMainComment",isEqualTo: "replyComment"
    );
    Stream<List<CommentEntity>> comments = collectionRef.snapshots().map(
            (snapShot) => snapShot.docs
            .map((streamDocSnapShot) =>
            CommentModel.fromDocSnapShot(streamDocSnapShot.data()))
            .toList());
    return comments;
  }


  @override
  Future<bool> likeComment(
      {required CommentEntity commentEntity,
      required PostEntity postEntity}) async {
    final currentUserUid = auth!.currentUser!.uid;
    DocumentReference docRef = store!
        .collection(FirebaseConst.commentCollection)
        .doc(commentEntity.commentId);
    DocumentSnapshot docSnapShot = await docRef.get();
    List likes = docSnapShot.get(FirebaseConst.likes);
    int likeNumber = docSnapShot.get(FirebaseConst.likeNumber);
    if (likes.contains(currentUserUid)) {
      likes.removeWhere((element) => element == currentUserUid);
      likeNumber = likeNumber - 1;
      await docRef.update(
          {FirebaseConst.likes: likes, FirebaseConst.likeNumber: likeNumber});
      return false;
    } else {
      likes.add(currentUserUid);
      likeNumber = likeNumber + 1;
      await docRef.update(
          {FirebaseConst.likes: likes, FirebaseConst.likeNumber: likeNumber});
      return true;
    }
  }

  @override
  Future updateComment(CommentEntity commentEntity) async {
    Map<String, dynamic> data;
    if (commentEntity.commentDescription != null) {
      data = {
        FirebaseConst.commentDescription: commentEntity.commentDescription
      };
      await store!
          .collection(FirebaseConst.commentCollection)
          .doc(commentEntity.commentId)
          .update(data);
    }else if(commentEntity.subComments!=null){
     data={FirebaseConst.subComments:commentEntity.subComments};
  return await store!.collection(FirebaseConst.commentCollection).doc(commentEntity.commentId).update(data);
  }
  }

  @override
  Future deleteComment(CommentEntity commentEntity) async {
    int totalCommentNumber;
    final post=await store!.collection(FirebaseConst.postCollection).doc(
        commentEntity.postId).get().then((value) =>
        PostModel.fromDocSnapShot(value.data()!));
    await store!.collection(FirebaseConst.commentCollection).doc(commentEntity.commentId).delete();
    totalCommentNumber=post.commentNumber!-1;
   // await store!
     //   .collection(FirebaseConst.postCollection)
       // .doc(commentEntity.postId)
        //.update({FirebaseConst.commentNumber:post.commentNumber!-1});
    if(commentEntity.subComments!=null&&commentEntity.subComments!.isNotEmpty){
      for(var subComment in commentEntity.subComments!){
        await store!.collection(FirebaseConst.commentCollection).doc(subComment).delete();
        totalCommentNumber-=1;

      }
    }
    await store!
        .collection(FirebaseConst.postCollection)
        .doc(commentEntity.postId)
        .update({FirebaseConst.commentNumber:totalCommentNumber});
  }
  @override
  Future<bool> follow({required UserEntity currentUserEntity,required UserEntity otherUser})async{
    final currentUserUid = auth!.currentUser!.uid;
    DocumentReference currentUserDocRef = store!.collection(FirebaseConst.userCollection).doc(currentUserEntity.uid);
    DocumentReference otherDocRef = store!.collection(FirebaseConst.userCollection).doc(otherUser.uid);
    DocumentSnapshot currentDocSnapShot = await currentUserDocRef.get();
    DocumentSnapshot otherDocSnapShot = await otherDocRef.get();
    List followers = currentDocSnapShot.get(FirebaseConst.followers);
    List followings = otherDocSnapShot.get(FirebaseConst.following);
    int followerNumber = currentDocSnapShot.get(FirebaseConst.followerNumber);
    int followingNumber = otherDocSnapShot.get(FirebaseConst.followingNumber);
    if (followers.contains(otherUser.uid)) {
      followers.removeWhere((element) => element == otherUser.uid);
      followings.removeWhere((element) => element==currentUserUid);
      followerNumber = followerNumber -1;
      followingNumber=followingNumber-1;
      await currentUserDocRef.update(
          {FirebaseConst.followers: followers, FirebaseConst.followerNumber: followerNumber});
      await otherDocRef.update(
          {FirebaseConst.following: followings, FirebaseConst.followingNumber: followingNumber});
      return false;
    } else {
      followers.add(otherUser.uid);
      followings.add(currentUserUid);
     followerNumber = followerNumber + 1;
     followingNumber=followingNumber+1;
      await currentUserDocRef.update(
          {FirebaseConst.followers: followers, FirebaseConst.followerNumber: followerNumber});
      await otherDocRef.update(
          {FirebaseConst.following: followings, FirebaseConst.followingNumber: followingNumber});
      return true;
    }
  }
@override
  Future createSubComment({required CommentEntity subCommentEntity,required CommentEntity mainCommentEntity}) async {
    final currentUserUid = auth!.currentUser!.uid;
    DocumentReference ref = store!
        .collection(FirebaseConst.commentCollection)
        .doc(subCommentEntity.commentId);
    DocumentSnapshot docSnap = await ref.get();
    Map<String, dynamic> data = CommentModel(
        commentatorUid: currentUserUid,
        commentId: subCommentEntity.commentId,
        postId: subCommentEntity.postId,
        likeNumber: 0,
        likes: [],
        commentDescription: subCommentEntity.commentDescription,
        commentatorProfileImageUrl:
        subCommentEntity.commentatorProfileImageUrl,
        createdAt: subCommentEntity.createdAt,
        commentatorName: subCommentEntity.commentatorName,
        creatorId: subCommentEntity.creatorId,
        isMainComment:subCommentEntity.isMainComment,
        mainCommentId:subCommentEntity.mainCommentId,
        subComments:[]
    )
        .toJson();

    if (docSnap.exists) {
      await ref.update(data);
    } else {
      await ref.set(data);
    }
    await store!.collection(FirebaseConst.commentCollection)
        .doc(mainCommentEntity.commentId).update({FirebaseConst.subComments:mainCommentEntity.subComments});
  }



}

