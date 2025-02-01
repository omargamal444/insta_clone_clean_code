import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/const.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/profile_controller.dart';
import 'package:insta_clone/user_feature/presentation/widget/modal_bottom_sheet_widget.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  static const profilePage = "/profilePage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: controller.getSingleUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final currentUser = snapshot.data!;
              return SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(currentUser.name!),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    _showModalBottom(context, onTap: () async {
                                      await controller.signOut();
                                    });
                                  },
                                  icon: const Icon(Icons.menu)),
                            ],
                          )
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
                              child: currentUser.profileUrl == ""
                                  ? const Icon(Icons.account_circle_sharp)
                                  :   CachedNetworkImage(
                                imageUrl:currentUser.profileUrl!,
                                placeholder: (context, url) =>
                                const Center(child: CircularProgressIndicator(),),
                                errorWidget: (context, url, error) => const Center(
                                  child:
                                    Icon(Icons.error_outline_rounded,color: Colors.red,))
                              )
                          ),
                          sizBoxWidth(50),
                          Column(
                            children: [
                              Text(
                                currentUser.postNumber!.toString(),
                              ),
                              const Text(
                                "posts",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          sizBoxWidth(10),
                          Column(
                            children: [
                              Text(currentUser.followerNumber.toString()),
                              const Text(
                                "followers",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          sizBoxWidth(10),
                          Column(
                            children: [
                              Text(currentUser.followingNumber.toString()),
                              const Text(
                                "following",
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                          Text(
                            currentUser.userName!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    sizBoxHeight(10),
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Row(
                        children: [
                          Text(currentUser.career!),
                        ],
                      ),
                    ),
                    sizBoxHeight(40),
                    StreamBuilder(
                      stream: controller.getPosts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          if (snapshot.data!.isEmpty) {
                            return const Text("No Posts Yet");
                          } else {
                            return Expanded(
                              child: GridView.builder(
                                  itemCount: snapshot.data!.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 6,
                                          mainAxisSpacing: 6),
                                  itemBuilder: (context, index) {
                                    final post = snapshot.data![index];
                                    return
                                      CachedNetworkImage(
                                        imageUrl:post.postImageUrl!,
                                        placeholder: (context, url) =>
                                            const Center(child: CircularProgressIndicator(),),
                                        errorWidget: (context, url, error) => const Center(
                                          child: Text("تحقق من اتصالك بالانتؤنت"),
                                        ),
                                      );
                                  }),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}

_showModalBottom(BuildContext context, {void Function()? onTap}) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return ModalBottomSheetWidget(onTap: onTap);
      });
}
