import 'dart:io';

import 'package:insta_clone/user_feature/domain/entity/comment_entity.dart';
import 'package:insta_clone/user_feature/domain/entity/post_entity.dart';
import 'package:insta_clone/user_feature/domain/entity/user_entity.dart';
import 'package:insta_clone/user_feature/domain/repo/user_repo.dart';
import 'package:photo_manager/photo_manager.dart';

class SignUpUseCase {
  UserRepo? repo;

  SignUpUseCase({required this.repo});

  Future call(UserEntity user) {
    return repo!.signUp(user);
  }
}

class SignInUseCase {
  UserRepo? repo;

  SignInUseCase({required this.repo});

  Future call(UserEntity user) {
    return repo!.signIn(user);
  }
}

class IsLoggedInUsecase {
  UserRepo? repo;

  IsLoggedInUsecase({required this.repo});

  Future<bool> call() async => repo!.isLoggedIn();
}

class SignOutUseCase {
  UserRepo? repo;

  SignOutUseCase({required this.repo});

  Future<void> call() async => repo!.signOut();
}

class GetSingleUserUseCase {
  UserRepo? repo;

  GetSingleUserUseCase({required this.repo});

  Stream<UserEntity> call(String uid) => repo!.getSingleUser(uid);
}

class GetMultipleUsersUseCase {
  UserRepo? repo;

  GetMultipleUsersUseCase({required this.repo});

  Future<List<UserEntity>> call() async => repo!.getUsers();
}

class GetCurrentUidUsecase {
  UserRepo? repo;

  GetCurrentUidUsecase({required this.repo});

  Future call() async => repo!.getCurrentUid();
}

class CreateUserUsecase {
  UserRepo? repo;

  CreateUserUsecase({required this.repo});

  Future call(UserEntity userEntity) async => repo!.createUser(userEntity);
}

class UpdateUserUsecase {
  UserRepo? repo;

  UpdateUserUsecase({required this.repo});

  Future call(UserEntity currentUser) async => repo!.updateUser(currentUser);
}

class AddImageToFireStorageUsecase {
  UserRepo? repo;

  AddImageToFireStorageUsecase({required this.repo});

  Future call(File image, bool isPost) async {
    final imageUrl = await repo!.addImageToFireStorage(image, isPost);
    return imageUrl!;
  }
}

class CreatePostUseCase {
  UserRepo? repo;

  CreatePostUseCase({required this.repo});

  Future call(PostEntity postEntity, UserEntity currentUser) async {
    await repo!.createPost(postEntity, currentUser);
  }
}

class UpdatePostUsecase {
  UserRepo? repo;

  UpdatePostUsecase({required this.repo});

  Future call(PostEntity postEntity) async {
    await repo!.updatePost(postEntity);
  }
}

class DeletePostUseCase {
  UserRepo? repo;

  DeletePostUseCase({required this.repo});

  Future call(PostEntity postEntity) async {
    await repo!.deletePost(postEntity);
  }
}

class GetPostUsecase {
  UserRepo? repo;

  GetPostUsecase({required this.repo});

  Stream<List<PostEntity>> call(UserEntity currentUser, String useLocation) {
    return repo!.getPost(currentUser, useLocation);
  }
}

class GetProfilePostsUsecase {
  UserRepo? repo;

  GetProfilePostsUsecase({required this.repo});

  Stream<List<PostEntity>> call(UserEntity currentUser) {
    return repo!.getProfilePosts(currentUser);
  }
}

class LikePostUsecase {
  UserRepo? repo;

  LikePostUsecase({required this.repo});

  Future<bool> call(PostEntity postEntity) async {
    return repo!.likePost(postEntity);
  }
}

//photoManager
class LoadAlbumsUsecase {
  UserRepo? repo;

  LoadAlbumsUsecase(this.repo);

  Future<List<AssetPathEntity>> call() async {
    return repo!.loadAlbums();
  }
}

class LoadAssetsUsecase {
  UserRepo? repo;

  LoadAssetsUsecase(this.repo);

  Future<List<AssetEntity>> call(AssetPathEntity album) async {
    return repo!.loadAssets(album);
  }
}

//comment
class GetCommentsUsecase {
  UserRepo? repo;

  GetCommentsUsecase(this.repo);

  Stream<List<CommentEntity>> call(PostEntity postEntity) {
    return repo!.getComments(postEntity: postEntity);
  }
}
class GetSubCommentsUsecase {
  UserRepo? repo;
  GetSubCommentsUsecase(this.repo);
  Stream<List<CommentEntity>> call(CommentEntity mainCommentEntity) {
    return repo!.getSubComments(mainCommentEntity: mainCommentEntity);
  }
}

class CreateCommentUsecase {
  UserRepo? repo;

  CreateCommentUsecase(this.repo);

  Future call(CommentEntity commentEntity) async {
    return repo!.createComment(commentEntity: commentEntity);
  }
}

class LikeCommentUseCase {
  UserRepo? repo;

  LikeCommentUseCase(this.repo);

  Future<bool> call(CommentEntity commentEntity, PostEntity postEntity) async {
    return repo!
        .likeComment(commentEntity: commentEntity, postEntity: postEntity);
  }
}

class DeleteCommentUseCase {
  UserRepo? repo;

  DeleteCommentUseCase({required this.repo});

  Future call(CommentEntity commentEntity) async {
    await repo!.deleteComment(commentEntity);
  }
}

class UpdateCommentUsecase {
  UserRepo? repo;

  UpdateCommentUsecase({required this.repo});

  Future call(CommentEntity commentEntity) async {
    return await repo!.updateComment(commentEntity);
  }
}

class FollowUseCase {
  UserRepo? repo;

  FollowUseCase({required this.repo});

  Future<bool> call(
      {required UserEntity currentUserEntity,
      required UserEntity otherUser}) async {
    return repo!
        .follow(otherUser: otherUser, currentUserEntity: currentUserEntity);
  }
}

