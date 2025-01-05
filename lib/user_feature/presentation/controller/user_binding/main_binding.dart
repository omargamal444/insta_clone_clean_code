import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:insta_clone/user_feature/core/data_connection_checker.dart';
import 'package:insta_clone/user_feature/data/data_repo/user_repo_impl/user_repo_impl.dart';
import 'package:insta_clone/user_feature/data/data_source/remote_data_source/remote_data_source_impl.dart';
import 'package:insta_clone/user_feature/domain/use_case/user_usecase.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/home_controller.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/profile_controller.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/auth_controller/sign_in_controller.dart';

class MainBinding extends Bindings{
  @override
  void dependencies() {
Get.lazyPut(() => SignUpUseCase(repo: Get.find<UserRepoImpl>()),fenix: true);
Get.lazyPut(() => UserRepoImpl( connection: Get.find<Connection>(),remoteDataSource: Get.find<RemoteDataSourceImpl>()),fenix: true);
Get.lazyPut(() => RemoteDataSourceImpl(storage: Get.find<FirebaseStorage>(),auth: Get.find<FirebaseAuth>(),store: Get.find<FirebaseFirestore>()),fenix: true);
Get.lazyPut(() => FirebaseAuth.instance,fenix: true);
Get.lazyPut(() => FirebaseFirestore.instance,fenix: true);
Get.lazyPut(() => SignInUseCase(repo: Get.find<UserRepoImpl>()),fenix: true);
Get.lazyPut(() => SignOutUseCase(repo: Get.find<UserRepoImpl>()),fenix: true);
Get.lazyPut(() => ProfileController(),fenix: true);
Get.lazyPut(() =>HomeController(),fenix: true);
Get.lazyPut(() => CreateUserUsecase(repo: Get.find<UserRepoImpl>()),fenix: true);
Get.lazyPut(() => GetSingleUserUseCase(repo: Get.find<UserRepoImpl>()));
Get.lazyPut(() => FirebaseStorage.instance,fenix: true);
Get.lazyPut(() => AddImageToFireStorageUsecase(repo: Get.find<UserRepoImpl>()),fenix:true);
Get.lazyPut(() => Connection(),fenix: true);
Get.lazyPut(() => GetPostUsecase(repo: Get.find<UserRepoImpl>()));
Get.lazyPut(() => LikePostUsecase(repo: Get.find<UserRepoImpl>()));

  }

}