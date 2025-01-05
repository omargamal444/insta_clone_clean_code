import 'dart:io';
import 'package:insta_clone/user_feature/domain/entity/post_entity.dart';
import 'package:insta_clone/user_feature/domain/entity/user_entity.dart';
import 'package:insta_clone/user_feature/domain/repo/user_repo.dart';

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

  Future<List<UserEntity>?> call({required String ?uid}) async => repo!.getSingleUser(uid!);
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

class UpdateUser {
  UserRepo? repo;

  UpdateUser({required this.repo});

  Future call() async => repo!.updateUser();
}
class AddImageToFireStorageUsecase{
  UserRepo? repo;
  AddImageToFireStorageUsecase({required this.repo});
  Future call(File image,bool isPost)async{
  final imageUrl= await repo!.addImageToFireStorage(image,isPost);
  return imageUrl!;
  }
}
class CreatePost{
  UserRepo?repo;

  CreatePost({required this.repo});

  Future call(PostEntity postEntity)async{
    await repo!.createPost(postEntity);
  }
}
class UpdatePost{
  UserRepo?repo;

  UpdatePost({required this.repo});

  Future call(PostEntity postEntity)async{
    await repo!.updatePost(postEntity);
  }
}
class DeletePost{
  UserRepo?repo;

  DeletePost({required this.repo});

  Future call(PostEntity postEntity)async{
    await repo!.deletePost(postEntity);
  }
}
class GetPostUsecase{
  UserRepo?repo;

  GetPostUsecase({required this.repo});

  Stream<List<PostEntity>> call(){
   return repo!.getPost();
  }
}
class LikePostUsecase{
  UserRepo ?repo;

  LikePostUsecase({required this.repo});
  Future<bool>call(PostEntity postEntity)async{
    return repo!.likePost(postEntity);
  }
}