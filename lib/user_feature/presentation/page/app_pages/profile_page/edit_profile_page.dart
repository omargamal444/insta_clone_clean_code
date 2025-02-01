import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/const.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/edit_profile_page_controller.dart';

import 'edit_profile_widget.dart';

class EditProfile extends GetView<EditProfilePageController>{
  const EditProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
      controller.careerFocusNode.unfocus();
      controller.nameFocusNode.unfocus();
      controller.userNameFocusNode.unfocus();
    },
      child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 80),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      sizBoxWidth(30),
                      const Text("Edit Profile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                    ],

                  ),
                  sizBoxHeight(50),
                  Stack(
                    children: [
                      Obx(() =>
                        Container(
                            width: 100,
                            height:100,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child:
                            controller.path == ""?
                            const Icon(Icons.account_circle_sharp)
                            :
                            Image.file(
                              File(controller.path),
                              fit: BoxFit.cover,
                            )
                        ),
                      ),

                      Positioned(
                        left: 40,
                        top: 48,
                        child: IconButton(
                          onPressed: () async {
                           final imagePath = await controller.pickImage();
                           controller.path = imagePath;
                          },
                          icon: const Icon(Icons.camera_alt_rounded),
                        ),
                      )
                    ],
                  ),

                  sizBoxHeight(130),
           Obx((){
            return controller.isLoadingController.isLoading?const CircularProgressIndicator():const Text("");
           }),
               EditProfileWidget(
                 userName: controller.userNameController.text,
                 career: controller.careerController.text,
                 name: controller.nameController.text,
                 careerController: controller.careerController,
                 nameController: controller.nameController,
                 userNameController: controller.userNameController,
                 onUpdateMyProfileButtonTap: ()async{
                   if(!controller.isLoadingController.isLoading){
                   await controller.updateUserProfile();
                   }
                 },
                  )
                ],
              ),
            ),

      ),),
    );
  }
}
