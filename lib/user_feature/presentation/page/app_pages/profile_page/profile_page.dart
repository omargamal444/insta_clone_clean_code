import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/const.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/profile_controller.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/profile_page/edit_profile_page.dart';
import 'package:insta_clone/user_feature/presentation/widget/modal_bottom_sheet_widget.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});
  static const profilePage="/profilePage";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() =>
         Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(controller.name.value),
                  sizBoxWidth(200),
                  IconButton(
                      onPressed: () {
                        _showModalBottom(context,
                        onTap:()async{
                           await controller.signOut();}
                        );
                      },
                      icon: const Icon(Icons.menu))
                ],
              ),
            ),
            sizBoxHeight(50),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  sizBoxWidth(10),
                  const CircleAvatar(
                      radius: 40, child: Icon(Icons.account_circle_sharp)),
                  sizBoxWidth(70),
                   Column(
                    children: [Text(controller.postNumber.value), const Text("posts")],
                  ),
                  sizBoxWidth(10),
                   Column(
                    children: [Text(controller.followerNumber.value),const Text("followers")],
                  ),
                  sizBoxWidth(10),
                  Column(
                    children: [Text(controller.followingNumber.value),const Text("following")],
                  ),
                ],
              ),
            ),
            sizBoxHeight(20),
             Padding(
              padding:const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Text(
                    controller.userName.value,
                    style:const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            sizBoxHeight(10),
             Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Text(controller.career.value),
                ],
              ),
            ),
            sizBoxHeight(40),
            const Text("No posts yet")
          ],
        ),
      ),
    );
  }
}

_showModalBottom(BuildContext context,{void Function()? onTap}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return ModalBottomSheetWidget(onTap: onTap);}
  );
}


