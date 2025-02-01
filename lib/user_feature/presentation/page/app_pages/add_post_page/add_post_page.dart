import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/add_post_controller.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

import '../../../../../const.dart';

class AddPostPage extends GetView<AddPostController> {
  const AddPostPage({super.key});

  static String addPostPage = "/addPostPage";

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
            appBar: AppBar(title: const Text("inastgram"), actions: [
              Row(
                children: [
                  if (controller.isLoading.value)
                    const CircularProgressIndicator(),
                  Padding(
                      padding: const EdgeInsets.only(right: 8, left: 24),
                      child: TextButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () async {
                                  if (controller.addOrUpdate == "Post") {
                                    final imageFile = await controller
                                        .assets[controller.index.value].file
                                        .then((value) => value);
                                    controller.postImagePath.value =
                                        imageFile!.path;
                                    await controller.createPost();
                                  } else {
                                    final imageFile = await controller
                                        .assets[controller.index.value].file
                                        .then((value) => value);
                                    controller.postImagePath.value =
                                        imageFile!.path;
                                    controller.updatePost();
                                  }
                                },
                          child: Text(
                            controller.addOrUpdate,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ))),
                ],
              )
            ]),
            body: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: TextFormField(
                      controller: controller.descriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20),
                          hintText: "write any thing ...")),
                ),
                sizBoxHeight(20),
                controller.addOrUpdate == "Update Post"
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * .36,
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                            imageUrl: controller.thePostEntity!.postImageUrl!,
                            placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator(),),
                            errorWidget: (context, url, error) => const Center(
                                child:
                                Icon(Icons.error_outline_rounded,color: Colors.red,))
                        )
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * .36,
                        width: MediaQuery.of(context).size.width,
                        child: controller.assets.isNotEmpty
                            ? Image(
                                fit: BoxFit.fill,
                                image: AssetEntityImageProvider(
                                  controller.assets[controller.index.value],
                                ))
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),
                Row(
                  children: [
                    sizBoxWidth(20),
                    Text(
                      controller.albumName.value,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height: 300,
                                      child: ListView.builder(
                                        itemCount: controller.albums.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () async {
                                              controller.albumName.value =
                                                  controller.albums[index].name;
                                              await controller.loadAssets();
                                              Get.offNamed(
                                                  AddPostPage.addPostPage);
                                            },
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8, bottom: 8),
                                                  child: Text(
                                                    controller
                                                        .albums[index].name,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                                const Divider(
                                                  color: Colors.white,
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                        icon: const Icon(Icons.arrow_drop_down_circle))
                  ],
                ),
                Container(
                  color: Colors.black.withOpacity(1),
                  height: MediaQuery.of(context).size.height * .43,
                  width: MediaQuery.of(context).size.width,
                  child: (GridView.builder(
                      itemCount: controller.assets.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 6,
                              mainAxisSpacing: 6),
                      itemBuilder: (context, index) {
                        final assetEntity = controller.assets[index];
                        return GestureDetector(
                          onTap: controller.isLoading.value
                              ? null
                              : () {
                                  controller.index.value = index;
                                  if (controller.addOrUpdate == "Update Post") {
                                    controller.addOrUpdate = "update post";
                                  }
                                },
                          child: Image(
                            fit: BoxFit.fill,
                            image: AssetEntityImageProvider(assetEntity),
                          ),
                        );
                      })),
                ),
              ]),
            )),
      );
    });
  }
}
