import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/user_feature/domain/entity/user_entity.dart';
import 'package:insta_clone/user_feature/domain/use_case/user_usecase.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/main_page.dart';

import '../../../../core/failure.dart';

class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController careerController = TextEditingController();
  final RxString _path = "".obs;

  String get path => _path.value;

  set path(String path) {
    _path.value = path;
  }

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  SignUpUseCase signUpUseCase = Get.find<SignUpUseCase>();
  CreateUserUsecase createUserUsecase = Get.find<CreateUserUsecase>();
  AddImageToFireStorageUsecase addImageToFireStorageUsecase =
      Get.find<AddImageToFireStorageUsecase>();

  Future signUp() async {
    try {
      _isLoading.value = true;
      UserEntity user = UserEntity(
        name: nameController.text,
        email: emailController.text.trim(),
        career: careerController.text,
        password: passwordController.text,
      );
      await signUpUseCase.call(user);
      if (_path.value != "") {
        final profileImageUrl =
            await addImageToFireStorageUsecase.call(File(_path.value), false);
        user.profileUrl = profileImageUrl;
      }
      Future.delayed(const Duration(seconds: 5));
      await createUserUsecase.call(user);
      _isLoading.value = false;
      Get.offNamed(MainPage.mainPage);
    } on Failure catch (e) {
      Get.snackbar("message", "${e.errorMessage}");
      _isLoading.value = false;
    }
  }

  Future<String> pickImage() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    return xFile!.path;
  }
}
