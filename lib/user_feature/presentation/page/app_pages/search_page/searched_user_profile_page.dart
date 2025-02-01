import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/const.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/main_page_controller.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/searched_user_profile_controller.dart';

class SearchedUserProfilePage extends GetView<SearchedUserProfileController> {
  const SearchedUserProfilePage({super.key});

  static const searchedUserProfilePage = "/searchedUserProfilePage";

  @override
  Widget build(BuildContext context) {
    final String searchedUserId = Get.arguments;
    final currentUid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
            stream: controller.getSingleUser(currentUid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("");
              } else {
                final currentUser = snapshot.data;
                return StreamBuilder(
                    stream: controller.getSingleUser(searchedUserId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else {
                        final searchedUser = snapshot.data;
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(searchedUser!.userName!),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            sizBoxHeight(50),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  sizBoxWidth(4),
                                  Container(
                                      width: 90,
                                      height: 90,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                      ),
                                      child: searchedUser.profileUrl == ""
                                          ? const Icon(
                                              Icons.account_circle_sharp)
                                          : Image.network(
                                              searchedUser.profileUrl!,
                                              fit: BoxFit.cover,
                                            )),
                                  sizBoxWidth(50),
                                  Column(
                                    children: [
                                      Text(
                                        searchedUser.postNumber.toString(),
                                      ),
                                      const Text(
                                        "posts",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  sizBoxWidth(10),
                                  Column(
                                    children: [
                                      Text(searchedUser.followerNumber
                                          .toString()),
                                      const Text(
                                        "followers",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  sizBoxWidth(10),
                                  Column(
                                    children: [
                                      Text(searchedUser.followingNumber
                                          .toString()),
                                      const Text(
                                        "following",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            sizBoxHeight(20),
                            Padding(
                              padding: const EdgeInsets.only(left: 24),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      searchedUser.userName!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  sizBoxWidth(MediaQuery.of(context).size.width*.2),
                                  Container(
                                    width: 140,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: currentUser!.followers!
                                            .contains(searchedUser.uid)
                                            ? Colors.black.withOpacity(.2)
                                            : Colors.blue,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: InkWell(
                                      onTap: () {
                                        controller.follow(
                                            currentUserEntity: currentUser,
                                            otherUser: searchedUser);
                                      },
                                      child: Center(
                                        child: Text(
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                          currentUser.followers!
                                              .contains(searchedUser.uid)
                                              ? "unfollow"
                                              : "follow",
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            sizBoxHeight(2),
                            Padding(
                              padding: const EdgeInsets.only(left: 24),
                              child: Row(
                                children: [
                                  Flexible(child: Text(
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),searchedUser.career!)),

                                ],
                              ),
                            ),
                            sizBoxHeight(100),
                            const Text("No posts yet")
                          ],
                        );
                      }
                    });
              }
            }),
      ),
    );
  }
}
