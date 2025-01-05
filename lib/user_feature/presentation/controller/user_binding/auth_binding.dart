import 'package:get/get.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/auth_controller/sign_in_controller.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/auth_controller/sign_up_controller.dart';

class SignUpBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController(),fenix: true);
  }

}
class SignInBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController(),fenix: true);
  }

}

