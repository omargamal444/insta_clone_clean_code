
import 'dart:io';

import 'package:insta_clone/user_feature/domain/entity/post_entity.dart';
import 'package:insta_clone/user_feature/domain/entity/user_entity.dart';

abstract class UserRepo {
  Future signIn(UserEntity userEntity);
  Future signUp(UserEntity userEntity);
  Future<bool>isLoggedIn();
  Future<void> signOut();
  Future<List<UserEntity>?> getSingleUser(String uid);
  Future<List<UserEntity>>  getUsers();
  Future createUser(UserEntity userEntity);
  Future getCurrentUid();
  Future updateUser();
  Future addImageToFireStorage(File image,bool isPost);
  Future createPost(PostEntity postEntity);
  Future deletePost(PostEntity postEntity);
  Stream<List<PostEntity>> getPost();
  Future updatePost(PostEntity postEntity);
  Future<bool>likePost(PostEntity postEntity);


}