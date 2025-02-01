import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/add_post_controller.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/home_controller.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/main_page_controller.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/add_post_page/add_post_page.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/comment_page/comment_page.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/home_page/post_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  static String homePage = "/homePage";

  @override
  Widget build(BuildContext context) {
    final mainPageController = Get.find<MainPageController>();
    final addPosController = Get.find<AddPostController>();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            collapsedHeight: 70,
            backgroundColor: Colors.black,
            title: Text(
              "instgram",
              style:
                  GoogleFonts.allison(textStyle: const TextStyle(fontSize: 60)),
            ),
            expandedHeight: 30,
            floating: true,
            pinned: false,
            //   pinned: true
          ),
          StreamBuilder(
            stream: controller.getPosts(
                mainPageController.currentUser!, "homePage"),
            builder: (context, snapshot) {
              return
                SliverList(
                delegate: SliverChildBuilderDelegate((_, int index) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 300),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  } else {if(snapshot.data!.isEmpty) {
                    return const Center(child: Text("No Posts Yet"),);
                  }
                  else {
                    final postEntity = snapshot.data![index];
                    controller.showDeleteWidget.value =
                        List.filled(snapshot.data!.length, false);
                    return
                      Obx(() {
                      print(controller.showDeleteWidget.length);
                        return
                           PostWidget(
                              showDeleteWidget: controller.showDeleteWidget,
                              index: index,
                              currentUser: mainPageController.currentUser!,
                              creatorId: postEntity.creatorId,
                              description: postEntity.description,
                              commentNumber: postEntity.commentNumber.toString(),
                              createdAt: postEntity.createdAt,
                              name: postEntity.name,
                              likeNumber: postEntity.likeNumber,
                              postImageUrl: postEntity.postImageUrl,
                              profileImage: postEntity.profileImage,
                              userName: postEntity.userName,
                              onLoveButtonTap: () async {
                                await controller.likePost(postEntity);
                              },
                              onPostSettingIconTap: () {
                                controller.showDeleteWidget[index] =
                                    !controller.showDeleteWidget[index];
                              },
                              onDeleteButtonTap: () async {
                                await controller.deletePost(
                                    postEntity: postEntity);
                                Get.snackbar("message",
                                    "you have successfully deleted your post");
                              },
                              onUpdatePostButtonTap: () {
                                addPosController.addOrUpdate = "Update Post";
                                addPosController.descriptionController.text =
                                    postEntity.description!;
                                addPosController.thePostEntity = postEntity;
                                Get.toNamed(AddPostPage.addPostPage);
                                Get.delete<HomeController>();
                              },
                              onCommentButtonTap: () {
                                Get.toNamed(CommentPage.commentPage,
                                    arguments: postEntity);
                              },
                              color: postEntity.likes!.contains(controller
                                      .currentUser
                                      .getCurrentUser()
                                      .uid)
                                  ? Colors.red
                                  : Colors.white,
                            );
                      }
                    );
                  }
                }
                  }, childCount: snapshot.hasData ? snapshot.data!.length : 1),
              );
            },
          ),
        ],
      ),
    );
  }
}
