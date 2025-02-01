import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/user_feature/domain/entity/user_entity.dart';
import 'package:insta_clone/user_feature/domain/use_case/user_usecase.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/main_page_controller.dart';

import '../../../../core/failure.dart';
import '../../../../domain/entity/post_entity.dart';

class SearchPageController extends GetxController {
  RxList<UserEntity> filteredList=<UserEntity>[].obs;
  final mainController=Get.find<MainPageController>();
  GetPostUsecase getPostUsecase=Get.find<GetPostUsecase>();
  List<UserEntity>allUserList=[];
  final currentUid=FirebaseAuth.instance.currentUser!.uid;
  TextEditingController searchController=TextEditingController();
  final getAllUsersUseCase=Get.find<GetMultipleUsersUseCase>();
 Future getAllUsers()async{
   try{
     allUserList=await getAllUsersUseCase.call();
   }
  on Failure catch (e){
   Get.snackbar("error", e.errorMessage!);
   throw "";
   }
 }
  Stream<List<PostEntity>>getPosts(){
    return (getPostUsecase.call(mainController.currentUser!,"searchPage"));
  }
@override
void onInit() async {
  super.onInit();
   getAllUsers();
}
}