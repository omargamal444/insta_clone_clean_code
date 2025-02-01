import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:insta_clone/user_feature/core/data_connection_checker.dart';
import 'package:insta_clone/user_feature/data/data_repo/user_repo_impl/user_repo_impl.dart';
import 'package:insta_clone/user_feature/data/data_source/local_data_source/local_data_source_impl.dart';
import 'package:insta_clone/user_feature/data/data_source/remote_data_source/remote_data_source_impl.dart';
import 'package:insta_clone/user_feature/domain/use_case/user_usecase.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/add_post_controller.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/comment_controller.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/edit_profile_page_controller.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/home_controller.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/is_loading_controller.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/main_page_controller.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/post_detail_page_controller.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/profile_controller.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/search_page_controller.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/searched_user_profile_controller.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/auth_controller/sign_in_controller.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/auth_controller/sign_up_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
        () => UserRepoImpl(
            localDataSource: Get.find<LocalDataSourceImpl>(),
            connection: Get.find<Connection>(),
            remoteDataSource: Get.find<RemoteDataSourceImpl>()),
        fenix: true);
    Get.lazyPut(
        () => RemoteDataSourceImpl(
            storage: Get.find<FirebaseStorage>(),
            auth: Get.find<FirebaseAuth>(),
            store: Get.find<FirebaseFirestore>()),
        fenix: true);
    Get.lazyPut(() => FirebaseStorage.instance, fenix: true);
    Get.lazyPut(
        () => AddImageToFireStorageUsecase(repo: Get.find<UserRepoImpl>()),
        fenix: true);
    Get.lazyPut(() => Connection(), fenix: true);
    Get.lazyPut(() => LocalDataSourceImpl(), fenix: true);
    Get.lazyPut(() => FirebaseAuth.instance, fenix: true);
    Get.lazyPut(() => FirebaseFirestore.instance, fenix: true);
//page
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => MainPageController(), fenix: true);
    Get.lazyPut(() => AddPostController(), fenix: true);
    Get.lazyPut(() => SearchPageController(), fenix: true);
    Get.lazyPut(() => SearchedUserProfileController(), fenix: true);
    Get.lazyPut(() => EditProfilePageController(), fenix: true);
    Get.lazyPut(() => SignUpController(),fenix: true);
    Get.lazyPut(() => SignInController(),fenix: true);
    Get.lazyPut(() => PostDetailPageController(),fenix: true);


//user
    Get.lazyPut(() => CreateUserUsecase(repo: Get.find<UserRepoImpl>()),
        fenix: true);
    Get.lazyPut(() => GetSingleUserUseCase(repo: Get.find<UserRepoImpl>()),
        fenix: true);
    Get.lazyPut(() => GetMultipleUsersUseCase(repo: Get.find<UserRepoImpl>()),
        fenix: true);
    Get.lazyPut(() => UpdateUserUsecase(repo: Get.find<UserRepoImpl>()),
        fenix: true);
//auth
    Get.lazyPut(() => SignInUseCase(repo: Get.find<UserRepoImpl>()),
        fenix: true);
    Get.lazyPut(() => SignUpUseCase(repo: Get.find<UserRepoImpl>()),
        fenix: true);
    Get.lazyPut(() => SignOutUseCase(repo: Get.find<UserRepoImpl>()),
        fenix: true);
//photoManager
    Get.lazyPut(() => LoadAlbumsUsecase(Get.find<UserRepoImpl>()), fenix: true);
    Get.lazyPut(() => LoadAssetsUsecase(Get.find<UserRepoImpl>()), fenix: true);
//post
    Get.lazyPut(() => CreatePostUseCase(repo: Get.find<UserRepoImpl>()),
        fenix: true);
    Get.lazyPut(() => DeletePostUseCase(repo: Get.find<UserRepoImpl>()),
        fenix: true);
    Get.lazyPut(() => UpdatePostUsecase(repo: Get.find<UserRepoImpl>()),
        fenix: true);
    Get.lazyPut(() => GetPostUsecase(repo: Get.find<UserRepoImpl>()),
        fenix: true);
    Get.lazyPut(() => LikePostUsecase(repo: Get.find<UserRepoImpl>()),
        fenix: true);
    Get.lazyPut(() => IsLoadingController(), fenix: true);
    Get.lazyPut(() => GetProfilePostsUsecase(repo: Get.find<UserRepoImpl>()),
        fenix: true);
//comment
    Get.lazyPut(() => CreateCommentUsecase(Get.find<UserRepoImpl>()),
        fenix: true);
    Get.lazyPut(() => CommentController(), fenix: true);
    Get.lazyPut(() => GetCommentsUsecase(Get.find<UserRepoImpl>()),
        fenix: true);
    Get.lazyPut(() => LikeCommentUseCase(Get.find<UserRepoImpl>()),
        fenix: true);
    Get.lazyPut(() => DeleteCommentUseCase(repo: Get.find<UserRepoImpl>()),
        fenix: true);
    Get.lazyPut(() => UpdateCommentUsecase(repo: Get.find<UserRepoImpl>()),
        fenix: true);
    Get.lazyPut(() => GetSubCommentsUsecase(Get.find<UserRepoImpl>()),
        fenix: true);
//follower
    Get.lazyPut(() => FollowUseCase(repo: Get.find<UserRepoImpl>()),
        fenix: true);
  }
}
