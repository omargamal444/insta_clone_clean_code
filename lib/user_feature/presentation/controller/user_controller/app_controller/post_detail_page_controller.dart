import 'package:get/get.dart';
import 'package:insta_clone/user_feature/domain/entity/post_entity.dart';
import 'package:insta_clone/user_feature/domain/use_case/user_usecase.dart';

import '../../../../domain/entity/user_entity.dart';

class PostDetailPageController extends GetxController{

  final getUserUsecase=Get.find<GetSingleUserUseCase>();
  PostEntity post=PostEntity();
  Stream<UserEntity> getUser(String uid){
   return getUserUsecase.call(uid);
  }
}