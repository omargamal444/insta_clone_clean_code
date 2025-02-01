import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:insta_clone/user_feature/domain/entity/user_entity.dart';
import 'package:insta_clone/user_feature/domain/use_case/user_usecase.dart';

class MainPageController extends GetxController{
 final getSingleUserUseCase=Get.find<GetSingleUserUseCase>();
 final RxInt _currentIndex=0.obs;
 UserEntity? currentUser=UserEntity();
 int get currentIndex=>_currentIndex.value;
 set currentIndex(int currentIndex){
   _currentIndex.value=currentIndex;
 }
 Stream<UserEntity>getCurrentUser(){
   final uid=FirebaseAuth.instance.currentUser!.uid;
 return getSingleUserUseCase.call(uid);

 }
@override
  void onInit() {
    super.onInit();
  getCurrentUser().listen((event) {currentUser=event;});


  }
}