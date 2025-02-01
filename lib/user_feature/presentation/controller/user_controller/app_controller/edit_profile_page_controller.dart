import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/user_feature/core/failure.dart';
import 'package:insta_clone/user_feature/domain/entity/user_entity.dart';
import 'package:insta_clone/user_feature/domain/use_case/user_usecase.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/is_loading_controller.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/main_page_controller.dart';
class EditProfilePageController extends GetxController{

  final RxString _path = "".obs;

  String get path => _path.value;

  set path(String path) {
    _path.value = path;
  }
  TextEditingController careerController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController userNameController=TextEditingController();
  final FocusNode nameFocusNode=FocusNode();
  final FocusNode userNameFocusNode=FocusNode();
  final FocusNode careerFocusNode=FocusNode();
  final updateUserUseCase=Get.find<UpdateUserUsecase>();
  final mainController=Get.find<MainPageController>();
  final isLoadingController=Get.find<IsLoadingController>();
  final addImageToFireStorageUsecase = Get.find<AddImageToFireStorageUsecase>();
Future updateUserProfile()async{
  isLoadingController.isLoading=true;
  try{
    final profileImageUrl=await changeProfilePhoto();
    UserEntity currentUser=UserEntity(
        uid: mainController.currentUser!.uid,
        career: careerController.text.trim(),
        name: nameController.text.trim(),
        userName: userNameController.text.trim(),
        profileUrl: profileImageUrl
    );
    await updateUserUseCase.call(currentUser);
    nameController.clear();
    userNameController.clear();
    careerController.clear();
    nameFocusNode.unfocus();
    userNameFocusNode.unfocus();
    careerFocusNode.unfocus();
    isLoadingController.isLoading=false;
    Get.back();
  } on Failure catch (e){
    Get.snackbar("error", e.errorMessage!);
  }


}

  Future changeProfilePhoto() async{
  try{
    if(_path.value!="") {
      return await addImageToFireStorageUsecase.call(File(_path.value),false);
    }
  }on Failure catch(e){
    Get.snackbar("error", e.errorMessage!);
  }

  }
  Future<String> pickImage() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    return xFile!.path;
  }
}