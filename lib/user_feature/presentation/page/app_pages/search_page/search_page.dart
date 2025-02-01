import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/post_detail_page/post_detail_page.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/search_page/search_widget.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/search_page/searched_user_profile_page.dart';
import '../../../controller/user_controller/app_controller/search_page_controller.dart';
import '../profile_page/profile_page.dart';

class SearchPage extends GetView<SearchPageController> {
  const SearchPage({super.key});

  static String searchPage = "/searchPage";

  @override
  Widget build(BuildContext context) {
    final FocusNode unitCodeCtrlFocusNode = FocusNode();
    return GestureDetector(
      onTap: () {
        unitCodeCtrlFocusNode.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 48),
                child: TextFormField(
                  focusNode: unitCodeCtrlFocusNode,
                  controller: controller.searchController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    prefixIcon: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.search)),
                    hintText: "search ...",
                    contentPadding: const EdgeInsets.only(left: 16),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  onChanged: (String content) {
                    if (content.isNotEmpty) {
                      controller.filteredList.value =
                          controller.allUserList.where((user) {
                        return user.userName!.startsWith(content);
                      }).toList();
                    } else {
                      controller.filteredList.clear();
                    }
                  },
                ),
              ),
              Obx(
               () =>
                    ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.filteredList.length,
                    itemBuilder: (context, index) {
                      final searchedUser = controller.filteredList[index];
                      return SearchItemWidget(
                          profileImageUrl: searchedUser.profileUrl!,
                          userName: searchedUser.userName!,
                          onSearchItemTap: () {
                            if (searchedUser.uid != controller.currentUid) {
                              Get.toNamed(
                                  SearchedUserProfilePage
                                      .searchedUserProfilePage,
                                  arguments: searchedUser.uid);
                            } else {
                              Get.toNamed(ProfilePage.profilePage);
                            }
                          });

                    }),
              ),
              StreamBuilder(
                stream: controller.getPosts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.data!.isEmpty) {
                      return const Text("No Posts Yet");
                    } else {
                      return GridView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 6,
                                  mainAxisSpacing: 6),
                          itemBuilder: (context, index) {
                            final post = snapshot.data![index];
                            return InkWell(
                              onTap: (){
                                Get.toNamed(PostDetailPage.postDetailPage, arguments: post);
                              },
                              child: CachedNetworkImage(
                              imageUrl: post.postImageUrl!,
                               errorWidget:(context, url, error) => const Icon(Icons.error_outline_rounded,color: Colors.red,),
                               placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
                                fit: BoxFit.cover,
                              ),
                            );
                          });
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
