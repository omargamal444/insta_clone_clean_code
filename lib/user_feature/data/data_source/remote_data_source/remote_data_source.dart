import 'dart:io';

import 'package:insta_clone/user_feature/domain/entity/comment_entity.dart';
import 'package:insta_clone/user_feature/domain/entity/post_entity.dart';

import '../../../domain/entity/user_entity.dart';

abstract class RemoteDataSource{
//user
  Future signIn(UserEntity userEntity);
  Future signUp(UserEntity userEntity);
  Future<bool>isLoggedIn();
  Future<void> signOut();
  Stream<UserEntity> getSingleUser(String uid);
  Future<List<UserEntity>>  getUsers();
  Future createUser(UserEntity userEntity);
  Future<String>getCurrentUid();
  Future updateUser(UserEntity currentUser);
  Future addImageToFireStorage(File image,bool isPost);
//post
  Future createPost(PostEntity postEntity,UserEntity currentUser);
  Future deletePost(PostEntity postEntity);
  Stream<List<PostEntity>> getPost(UserEntity currentUser,String useLocation) ;
  Future updatePost(PostEntity postEntity);
  Future <bool>likePost(PostEntity postEntity);
  Stream<List<PostEntity>> getProfilePosts(UserEntity currentUser);
//comment
  Future createComment({required CommentEntity commentEntity});
  Stream<List<CommentEntity>> getComments({required PostEntity postEntity});
  Future<bool> likeComment({required CommentEntity commentEntity,required PostEntity postEntity});
  Future deleteComment(CommentEntity commentEntity);
  Future updateComment(CommentEntity commentEntity);
  Stream<List<CommentEntity>> getSubComments({required CommentEntity mainCommentEntity});
  Future createSubComment({required CommentEntity subCommentEntity,required CommentEntity mainCommentEntity});
//follow
  Future <bool>follow({required UserEntity currentUserEntity,required UserEntity otherUser});
}