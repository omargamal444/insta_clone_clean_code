import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_clone/user_feature/core/data_connection_checker.dart';
import 'package:insta_clone/user_feature/core/failure.dart';
import 'package:insta_clone/user_feature/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:insta_clone/user_feature/domain/entity/post_entity.dart';
import 'package:insta_clone/user_feature/domain/entity/user_entity.dart';
import 'package:insta_clone/user_feature/domain/repo/user_repo.dart';

class UserRepoImpl implements UserRepo{
  RemoteDataSource? remoteDataSource;
  Connection?connection;

  UserRepoImpl({required this.remoteDataSource,required this.connection});

  @override
  Future createUser(UserEntity userEntity)async{
   if(await connection!.isConnected){
  await remoteDataSource!.createUser(userEntity);}
   else{
     throw Failure(errorMessage: "No internet connection");
   }
  }

  @override
  Future getCurrentUid()async{
 await remoteDataSource!.getCurrentUid();
  }

  @override
  Future<List<UserEntity>?> getSingleUser(String uid)async {
   return await remoteDataSource!.getSingleUser(uid);
  }

  @override
  Future<List<UserEntity>> getUsers()async {
  return await remoteDataSource!.getUsers();
  }

  @override
  Future<bool> isLoggedIn()async {
   return await remoteDataSource!.isLoggedIn();
  }

  @override
  Future signIn(UserEntity userEntity)async{
  await remoteDataSource!.signIn(userEntity);
  }

  @override
  Future<void> signOut()async {
await remoteDataSource!.signOut();
  }

  @override
  Future signUp(UserEntity userEntity)async {
    try{if (await connection!.isConnected){
      await remoteDataSource!.signUp(userEntity);}
    else {
      throw Failure(errorMessage: "No internet connection");}}
   on FirebaseAuthException catch(e){
      throw Failure(errorMessage: e.code);
   }
   catch (e) {
     throw Failure(errorMessage: "$e");
   }
  }

  @override
  Future updateUser()async{
  await remoteDataSource!.updateUser();
  }

  @override
  Future addImageToFireStorage(File image,bool isPost)async {
  final imageUrl= await remoteDataSource!.addImageToFireStorage(image,isPost);
  return imageUrl!;
  }

  @override
  Future createPost(PostEntity postEntity) {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Future deletePost(PostEntity postEntity) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Stream<List<PostEntity>> getPost(){
    try{
      return remoteDataSource!.getPost();
    }
    catch (e){
      throw Failure(errorMessage: e.toString());
    }
  }

  @override
  Future updatePost(PostEntity postEntity
      ) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }

  @override
  Future<bool>likePost(PostEntity postEntity)async{
   if(await connection!.isConnected){
     try{
       return remoteDataSource!.likePost(postEntity);
     }catch(e){
       throw Failure(errorMessage: "$e");
     }
   }
   else {
     throw Failure(errorMessage: "no internet connection");
   }
  }
}