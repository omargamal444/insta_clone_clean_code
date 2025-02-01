import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_clone/user_feature/core/data_connection_checker.dart';
import 'package:insta_clone/user_feature/core/failure.dart';
import 'package:insta_clone/user_feature/data/data_source/local_data_source/local_data_source.dart';
import 'package:insta_clone/user_feature/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:insta_clone/user_feature/domain/entity/comment_entity.dart';
import 'package:insta_clone/user_feature/domain/entity/post_entity.dart';
import 'package:insta_clone/user_feature/domain/entity/user_entity.dart';
import 'package:insta_clone/user_feature/domain/repo/user_repo.dart';
import 'package:photo_manager/photo_manager.dart';

class UserRepoImpl implements UserRepo {
  RemoteDataSource? remoteDataSource;
  Connection? connection;
  LocalDataSource? localDataSource;

  UserRepoImpl(
      {required this.remoteDataSource,
      required this.connection,
      required this.localDataSource});

  @override
  Future createUser(UserEntity userEntity) async {
    if (await connection!.isConnected) {
      await remoteDataSource!.createUser(userEntity);
    } else {
      throw Failure(errorMessage: "No internet connection");
    }
  }
  @override
  Future getCurrentUid() async {
    await remoteDataSource!.getCurrentUid();
  }
  @override
  Stream<UserEntity>getSingleUser(String uid) {
    return remoteDataSource!.getSingleUser(uid);
  }
  @override
  Future<List<UserEntity>> getUsers() async {
    try{
    if (await connection!.isConnected) {
    return await remoteDataSource!.getUsers();
    }else{
      throw Failure(errorMessage: "No Internet Connection");
    }
    }
    on FirebaseException catch (e){
      throw Failure(errorMessage: e.message);
    }
  }
  @override
  Future<bool> isLoggedIn() async {
    try {
      if (await connection!.isConnected) {
        return await remoteDataSource!.isLoggedIn();
      }
      else{
        throw Failure(errorMessage: "No Internet Connection");
      }
    }
    on FirebaseException catch (e){
      throw Failure(errorMessage: e.message);
    }
  }
  @override
  Future signIn(UserEntity userEntity) async {
    try {
      if (await connection!.isConnected) {
        await remoteDataSource!.signIn(userEntity);
      }
      else{
        throw Failure(errorMessage: "No Internet Connection");
      }
    }
    on FirebaseException catch (e){
      throw Failure(errorMessage: e.message);
    }
  }
  @override
  Future<void> signOut() async {
    try {
      if (await connection!.isConnected) {
        await remoteDataSource!.signOut();
      }
      else{
        throw Failure(errorMessage: "No Internet Connection");
      }
    }
    on FirebaseException catch (e){
      throw Failure(errorMessage: e.message);
    }
  }
  @override
  Future signUp(UserEntity userEntity) async {
    try {
      if (await connection!.isConnected) {
        await remoteDataSource!.signUp(userEntity);
      } else {
        throw Failure(errorMessage: "No internet connection");
      }
    } on FirebaseAuthException catch (e) {
      throw Failure(errorMessage: e.code.toString());
    } catch (e) {
      throw Failure(errorMessage: "$e");
    }
  }
  @override
  Future updateUser(UserEntity currentUser) async {
    try{
    if (await connection!.isConnected) {
      await remoteDataSource!.updateUser(currentUser);
    }else{
      throw Failure(errorMessage: "No Internet Connection");
    }

    }
    on FirebaseAuthException catch (e) {
      throw Failure(errorMessage: e.code.toString());
    }

  }
  @override
  Future addImageToFireStorage(File image, bool isPost) async {
    try{
      if (await connection!.isConnected) {
        final imageUrl =
        await remoteDataSource!.addImageToFireStorage(image, isPost);
        return imageUrl!;
      } else {
        throw Failure(errorMessage: "No Internet Connection");
      }
    }
    on FirebaseAuthException catch (e) {
      throw Failure(errorMessage: e.message);
    }
  }
  @override
  Future createPost(PostEntity postEntity,UserEntity currentUser) async {
    try {
      if (await connection!.isConnected) {
        return remoteDataSource!.createPost(postEntity,currentUser);
      } else {
        throw Failure(errorMessage: "No Internet Connection");
      }
    } catch (e) {
      throw Failure(errorMessage: e.toString());
    }
  }
  @override
  Future deletePost(PostEntity postEntity) async {
    try {
      if (await connection!.isConnected) {
        await remoteDataSource!.deletePost(postEntity);
      } else {
        throw Failure(errorMessage: "No Internet connection");
      }
    } on FirebaseException catch (e) {
      throw Failure(errorMessage: e.code);
    }
  }
  @override
  Stream<List<PostEntity>> getPost(UserEntity currentUser,String useLocation)  {
    try {

      return remoteDataSource!.getPost(currentUser,useLocation);
    }on FirebaseException catch (e) {
      throw Failure(errorMessage: e.toString());
    }
  }
  @override
  Stream<List<PostEntity>> getProfilePosts(UserEntity currentUser)  {
    try {
      return remoteDataSource!.getProfilePosts(currentUser);
    } catch (e) {
      throw Failure(errorMessage: e.toString());
    }
  }
  @override
  Future updatePost(PostEntity postEntity) async {
    try {
      if (await connection!.isConnected) {
        return remoteDataSource!.updatePost(postEntity);
      } else {
        throw Failure(errorMessage: "No Internet connection");
      }
    } on FirebaseException catch (e) {
      throw Failure(errorMessage: e.code);
    }
  }
  @override
  Future<bool> likePost(PostEntity postEntity) async {
    if (await connection!.isConnected) {
      try {
        return remoteDataSource!.likePost(postEntity);
      }on FirebaseException catch (e) {
        throw Failure(errorMessage:e.message);
      }
    } else {
      throw Failure(errorMessage: "no internet connection");
    }
  }
  @override
  Future<List<AssetPathEntity>> loadAlbums() async {
    return await localDataSource!.loadAlbums();
  }
  @override
  Future<List<AssetEntity>> loadAssets(AssetPathEntity album) async {
    return await localDataSource!.loadAssets(album);}
  //comment
  @override
  Future createComment({required CommentEntity commentEntity}) async {
    try {
      if (await connection!.isConnected) {
        await remoteDataSource!.createComment(
            commentEntity: commentEntity);
      } else {
        throw Failure(errorMessage: "No internet connection");
      }
    } on FirebaseException catch (e) {
      throw Failure(errorMessage: e.message);
    }
  }
  @override
  Stream<List<CommentEntity>> getComments({required PostEntity postEntity}) {
    try {
      return remoteDataSource!.getComments(postEntity: postEntity);
    } on FirebaseException catch (e) {
      throw Failure(errorMessage: e.code);
    }
  }
  @override
  Stream<List<CommentEntity>> getSubComments({required CommentEntity mainCommentEntity}) {
    try {
      return remoteDataSource!.getSubComments(mainCommentEntity: mainCommentEntity);
    } on FirebaseException catch (e) {
      throw Failure(errorMessage: e.code);
    }
  }
  @override
  Future<bool>likeComment({required CommentEntity commentEntity, required PostEntity postEntity})async{
    try {
      if (await connection!.isConnected) {
       return await remoteDataSource!.likeComment(commentEntity: commentEntity, postEntity: postEntity);
    } else {
    throw Failure(errorMessage: "No internet connection");
    }
    } on FirebaseException catch (e) {
    throw Failure(errorMessage: e.code);
    }
  }
  @override
  Future updateComment(CommentEntity commentEntity) async {
    try {
      if (await connection!.isConnected) {
       return await remoteDataSource!.updateComment(commentEntity);
      } else {
        throw Failure(errorMessage: "No Internet connection");
      }
    } on FirebaseException catch (e) {
      throw Failure(errorMessage: e.code);
    }
  }
  @override
  Future deleteComment(CommentEntity commentEntity) async {
    try {
      if (await connection!.isConnected) {
        await remoteDataSource!.deleteComment(commentEntity);
      } else {
        throw Failure(errorMessage: "No Internet connection");
      }
    } on FirebaseException catch (e) {
      throw Failure(errorMessage: e.code);
    }
  }
  @override
  Future<bool> follow({required UserEntity currentUserEntity,required UserEntity otherUser}) async {
    if (await connection!.isConnected) {
      try {
        return remoteDataSource!.follow(currentUserEntity: currentUserEntity,otherUser: otherUser);
      } catch (e) {
        throw Failure(errorMessage: "$e");
      }
    } else {
      throw Failure(errorMessage: "no internet connection");
    }
  }
}

