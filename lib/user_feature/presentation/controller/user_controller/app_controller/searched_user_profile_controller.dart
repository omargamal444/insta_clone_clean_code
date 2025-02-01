import 'package:get/get.dart';
import 'package:insta_clone/user_feature/domain/entity/user_entity.dart';
import 'package:insta_clone/user_feature/domain/use_case/user_usecase.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/main_page_controller.dart';

class SearchedUserProfileController extends GetxController {
  RxString searchedUserFollowerNumber = "".obs;
  RxString searchedUserFollowingNumber = "".obs;
  final getSingleUserUseCase = Get.find<GetSingleUserUseCase>();
  final followUseCase = Get.find<FollowUseCase>();
  final mainPageController = Get.find<MainPageController>();
  final RxString _followOrUnFollow = "follow".obs;

  String get followOrUnFollow => _followOrUnFollow.value;

  set followOrUnFollow(String followOrUnFollow) {
    _followOrUnFollow.value = followOrUnFollow;
  }

  Stream<UserEntity> getSingleUser(String uid) {
    return getSingleUserUseCase.call(uid);
  }

  Future follow(
      {required UserEntity currentUserEntity,
      required UserEntity otherUser}) async {
    await followUseCase.call(
        currentUserEntity: currentUserEntity, otherUser: otherUser);
  }
}
