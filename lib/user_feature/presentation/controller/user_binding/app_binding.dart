import 'package:get/get.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/home_controller.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/profile_controller.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController(),fenix: true);
  }
}
class HomeBinding extends Bindings{
  @override
  void dependencies() {
  Get.lazyPut(() => HomeController(),fenix: true);
  }

}