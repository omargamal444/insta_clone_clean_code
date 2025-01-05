import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/profile_page/edit_profile_page.dart';

class ModalBottomSheetWidget extends StatelessWidget {
  const ModalBottomSheetWidget({super.key,this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
    height: 200,child: SingleChildScrollView(
      child: Column(children: [
        const SizedBox(height: 50,child: Center(child: Text("More Options"))),
        const Divider(color: Colors.white,),
        SizedBox(height: 50,child: Center(child: GestureDetector(onTap:(){
          Get.to(const EditProfile());
        } ,child: const Text("Edit Profile")))),
        const Divider(color: Colors.white,),
        GestureDetector(onTap: onTap,
            child: const SizedBox(height: 50,child: Center(child: Text("Logout")))),

      ]),
    ),);
  }
}
