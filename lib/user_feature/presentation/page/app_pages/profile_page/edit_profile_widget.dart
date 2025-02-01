import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/edit_profile_page_controller.dart';

import '../../../../../const.dart';

class EditProfileWidget extends StatelessWidget{
  final String? name;
  final String? userName;
  final String? career;
  final TextEditingController? nameController;
  final TextEditingController? userNameController;
  final TextEditingController? careerController;
  final void Function()?onUpdateMyProfileButtonTap;

  const EditProfileWidget({super.key,
    required this.name,
    required this.userName,
    required this.career,
    required this.nameController,
    required this.userNameController,
    required this.careerController,
    required this.onUpdateMyProfileButtonTap
  });

  @override
  Widget build(BuildContext context) {
    final controller=Get.find<EditProfilePageController>();
    return
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          sizBoxHeight(120),
          TextField(
            focusNode: controller.nameFocusNode,
            textAlign: TextAlign.center,
            controller: nameController,
            decoration: const InputDecoration(hintText: "Edit name"),
          ),
          TextField(
            focusNode: controller.userNameFocusNode,
            textAlign: TextAlign.center,
            controller: userNameController,
            decoration: const InputDecoration(hintText: "Edit userName"),
          ),
          TextField(
            focusNode: controller.careerFocusNode,
            textAlign: TextAlign.center,
            controller: careerController,
            decoration: const InputDecoration(hintText: "Edit career"),
          ),
          sizBoxHeight(24),
          GestureDetector(onTap: onUpdateMyProfileButtonTap,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue),
              child: const Center(child: Text("update my profile")),
            ),
          ),
        ],
      );

  }
}
