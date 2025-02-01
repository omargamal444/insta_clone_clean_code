import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/const.dart';
import 'package:insta_clone/user_feature/domain/entity/post_entity.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/post_detail_page/post_datail_widget.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/search_page/searched_user_profile_page.dart';

import '../../../controller/user_controller/app_controller/main_page_controller.dart';
import '../../../controller/user_controller/app_controller/post_detail_page_controller.dart';
import '../profile_page/profile_page.dart';

class PostDetailPage extends GetView<PostDetailPageController>{
  const PostDetailPage({super.key});
static String postDetailPage="/postDetailPage";
  @override
  Widget build(BuildContext context) {
    PostEntity post=Get.arguments;
    final mainPageController=Get.find<MainPageController>();
    return
      Scaffold(body: SingleChildScrollView(
        child: Column(
          children: [
            sizBoxHeight(40),
            StreamBuilder(stream: controller.getUser(post.creatorId!),
              builder:(context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
              }
              else{
                final user=snapshot.data;
                return  PostDetailWidget(
                  userName: user!.userName,
                  userProfileUrl: user.profileUrl,
                  commentNumber:post.commentNumber.toString(),
                  createdAt: post.createdAt,
                  description: post.description,
                  likeNumber: post.likeNumber.toString(),
                  postImageUrl: post.postImageUrl,
                  onUserNameTap: (){
                    if(user.uid==mainPageController.currentUser!.uid){
                      Get.toNamed(ProfilePage.profilePage);
                    }else {
                      Get.toNamed(SearchedUserProfilePage.searchedUserProfilePage, arguments:user.uid);
                    }
                  },
                );
              }

              },
            ),
          ],
        ),
      ),
      );
  }
}
