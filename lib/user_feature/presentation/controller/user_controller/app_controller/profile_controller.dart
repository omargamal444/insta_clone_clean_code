import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:insta_clone/user_feature/core/failure.dart';
import 'package:insta_clone/user_feature/data/data_source/remote_data_source/remote_data_source_impl.dart';
import 'package:insta_clone/user_feature/domain/entity/post_entity.dart';
import 'package:insta_clone/user_feature/domain/use_case/user_usecase.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/main_page_controller.dart';
import 'package:insta_clone/user_feature/presentation/page/credential_page/sign_in_screen.dart';

import '../../../../domain/entity/user_entity.dart';

class ProfileController extends GetxController{
  SignOutUseCase signOutUseCase=Get.find<SignOutUseCase>();
  final mainController=Get.find<MainPageController>();
  final getProfilePostsUseCase=Get.find<GetProfilePostsUsecase>();
  GetSingleUserUseCase getSingleUserUseCase=Get.find<GetSingleUserUseCase>();
  RemoteDataSourceImpl remoteDataSourceImpl=Get.find<RemoteDataSourceImpl>();
   Future signOut()async{
      await signOutUseCase.call();
     SystemNavigator.pop();
  }
  Stream<UserEntity> getSingleUser(){
   try{
     final uid=FirebaseAuth.instance.currentUser!.uid;
  return getSingleUserUseCase.call(uid);

   }
       on Failure catch(e){
          Get.snackbar("error", e.toString());
          throw("");
       }

  }
  Stream<List<PostEntity>>getPosts(){
     final currentUser=mainController.currentUser;
    return (getProfilePostsUseCase.call(currentUser!));
  }
}