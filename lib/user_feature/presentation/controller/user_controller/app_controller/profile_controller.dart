import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:insta_clone/user_feature/core/failure.dart';
import 'package:insta_clone/user_feature/data/data_source/remote_data_source/remote_data_source_impl.dart';
import 'package:insta_clone/user_feature/domain/use_case/user_usecase.dart';
import 'package:insta_clone/user_feature/presentation/page/credential_page/sign_in_screen.dart';

import '../../../../domain/entity/user_entity.dart';

class ProfileController extends GetxController{
  RxString followerNumber="".obs;
  RxString followingNumber="".obs;
  RxString postNumber="".obs;
  RxString userName="".obs;
  RxString career="".obs;
  RxString name="".obs;
  SignOutUseCase signOutUseCase=Get.find<SignOutUseCase>();
  GetSingleUserUseCase getSingleUserUseCase=Get.find<GetSingleUserUseCase>();
  RemoteDataSourceImpl remoteDataSourceImpl=Get.find<RemoteDataSourceImpl>();
   Future signOut()async{
      await signOutUseCase.call();
    //  Get.offNamed(SignInScreen.signInScreen);
     SystemNavigator.pop();

  }
 Future<UserEntity>?getUserProfile()async{

   try{
     final uid=await remoteDataSourceImpl.getCurrentUid();
   List<UserEntity>?usersList= await getSingleUserUseCase.call(uid: uid);
   final user=usersList![0];
   followerNumber.value=user.followerNumber.toString();
   followingNumber.value=user.followingNumber.toString();
   name.value=user.name!;
   userName.value=user.userName!;
   career.value=user.career!;
   postNumber.value=user.postNumber!;
   return user;
   }
       on Failure catch(e){
          Get.snackbar("error", e.toString());
          throw("");
       }

  }
  @override
  void onInit() {
    super.onInit();
    getUserProfile();
  }
}