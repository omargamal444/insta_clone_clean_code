import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:insta_clone/user_feature/domain/entity/user_entity.dart';
import 'package:insta_clone/user_feature/domain/use_case/user_usecase.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/main_page.dart';
import '../../../../core/failure.dart';

class SignInController extends GetxController{

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  final RxBool _isLoading=false.obs;
  bool get isLoading=>_isLoading.value;
  SignInUseCase signInUseCase=Get.find<SignInUseCase>();

  Future signIn()async{
    UserEntity user=UserEntity(
        email: emailController.text.trim(),
        password: passwordController.text
    );

    try{
      _isLoading.value=true;
      Future.delayed(const Duration(seconds: 5));
    await signInUseCase.call(user);
    _isLoading.value=false;
      Get.offNamed(MainPage.mainPage);
    }on Failure catch (e){
      Get.snackbar("mesage", "${e.errorMessage}");
      _isLoading.value=false;
    }

  }

}
