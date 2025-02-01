
import 'dart:io';

import 'package:insta_clone/user_feature/domain/entity/comment_entity.dart';
import 'package:insta_clone/user_feature/domain/entity/post_entity.dart';
import 'package:insta_clone/user_feature/domain/entity/user_entity.dart';
import 'package:photo_manager/photo_manager.dart';

abstract class UserRepo {
  //user
  Future signIn(UserEntity userEntity);
  Future signUp(UserEntity userEntity);
  Future<bool>isLoggedIn();
  Future<void> signOut();
  Stream<UserEntity> getSingleUser(String uid);
  Future createUser(UserEntity userEntity);
  Future getCurrentUid();
  Future<List<UserEntity>> getUsers() ;
  Future updateUser(UserEntity currentUser);
  Future addImageToFireStorage(File image,bool isPost);
  //posts
  Future createPost(PostEntity postEntity,UserEntity currentUser);
  Future deletePost(PostEntity postEntity);
  Stream<List<PostEntity>> getPost(UserEntity currentUser,String useLocation) ;
  Future updatePost(PostEntity postEntity);
  Future<bool>likePost(PostEntity postEntity);
  Stream<List<PostEntity>> getProfilePosts(UserEntity currentUser);
  //photoManager
  Future<List<AssetPathEntity>>loadAlbums();
  Future<List<AssetEntity>>loadAssets(AssetPathEntity album);
  //comment
  Future createComment({required CommentEntity commentEntity});
  Stream <List<CommentEntity>>getComments({required PostEntity postEntity});
  Future <bool>likeComment({required CommentEntity commentEntity,required PostEntity postEntity});
  Future deleteComment(CommentEntity commentEntity);
  Future updateComment(CommentEntity commentEntity);
  Stream<List<CommentEntity>> getSubComments({required CommentEntity mainCommentEntity});

//follow
  Future <bool>follow({required UserEntity currentUserEntity,required UserEntity otherUser});






}
