import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/home_controller.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/home_page/post_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  static String homePage = "/homePage";

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          collapsedHeight: 70,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.chat_sharp))
          ],
          backgroundColor: Colors.black54,
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
          stream: controller.getPosts(),
          builder: (context, snapshot) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, int index) {
                  if (!snapshot.hasData) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 300),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  } else if (snapshot.data == null) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 300),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(" او فى الفانكشن عندك غلطة فى الداتا بيز"),
                        ],
                      ),
                    );
                  } else {
                    return PostWidget(
                      description: snapshot.data![index].description,
                      commentNumber: snapshot.data![index].commentNumber,
                      createdAt: snapshot.data![index].createdAt,
                      name: snapshot.data![index].name,
                      likeNumber: snapshot.data![index].likeNumber,
                      postImageUrl: snapshot.data![index].postImageUrl,
                      profileImage: snapshot.data![index].profileImage,
                      userName: snapshot.data![index].userName,
                      onLoveButtonTap: () async {
                        await controller.likePost(snapshot.data![index]);
                      },
                      color: snapshot.data![index].likes!.contains(
                              controller.currentUser.getCurrentUser().uid)
                          ? Colors.red
                          : Colors.white,
                    );
                  }
                },
                childCount: 1,
              ),
            );
          },
        ),
      ],
    );
  }
}
