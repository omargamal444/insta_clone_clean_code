import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/const.dart';
import 'package:insta_clone/user_feature/domain/entity/post_entity.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/comment_controller.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/is_loading_controller.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/comment_page/comment_widget.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/comment_page/sub_comment_widget.dart';

class CommentPage extends GetView<CommentController> {
  const CommentPage({super.key});

  static String commentPage = "/commentPage";

  @override
  Widget build(BuildContext context) {
    final FocusNode unitCodeCtrlFocusNode = FocusNode();

    final isLoadingController = Get.find<IsLoadingController>();
    PostEntity postEntity = Get.arguments;
    controller.postEntity = postEntity;
    return GestureDetector(
        onTap: () {
          unitCodeCtrlFocusNode.unfocus();
        },
        child: Scaffold(
            body: StreamBuilder(
                stream: controller.getComments(postEntity),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return Column(children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, commentIndex) {
                              final commentEntity =
                                  snapshot.data![commentIndex];
                              return Column(children: [
                                CommentWidget(
                                  likeNumber: commentEntity.likeNumber,
                                  color: commentEntity.likes!.contains(
                                          FirebaseAuth
                                              .instance.currentUser!.uid)
                                      ? Colors.blue
                                      : Colors.white,
                                  userName: commentEntity.commentatorName,
                                  commentDescription:
                                      commentEntity.commentDescription,
                                  createdAt: commentEntity.createdAt!
                                      .toDate()
                                      .toString(),
                                  profileImageUrl:
                                      commentEntity.commentatorProfileImageUrl,
                                  onLikeButtonTap: () async {
                                    controller.commentEntity = commentEntity;
                                    await controller.liKeComment();
                                  },
                                  onCommentLongTap: () {
                                    if (commentEntity.creatorId ==
                                        controller.currentUser.uid) {
                                      controller.commentEntity = commentEntity;
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return SizedBox(
                                              height: 160,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    children: [
                                                      sizBoxWidth(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .3),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          Get.back();
                                                          controller
                                                                  .commentController
                                                                  .text =
                                                              commentEntity
                                                                  .commentDescription!;
                                                          controller
                                                                  .updateOrCreateOrReply =
                                                              "update";
                                                        },
                                                        child: const Text(
                                                            "Edit Comment"),
                                                      ),
                                                      sizBoxWidth(8),
                                                      const Icon(
                                                        Icons.edit,
                                                      )
                                                    ],
                                                  ),
                                                  const Center(
                                                      child: Divider()),
                                                  Row(
                                                    children: [
                                                      sizBoxWidth(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .3),
                                                      GestureDetector(
                                                          onTap: () async {
                                                            controller
                                                                    .commentEntity =
                                                                commentEntity;
                                                            await controller
                                                                .deleteComment();
                                                            Get.back();
                                                          },
                                                          child: const Text(
                                                              "Delete Comment")),
                                                      sizBoxWidth(8),
                                                      const Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    }
                                  },
                                  onReplyButtonPressed: () {
                                    controller.updateOrCreateOrReply = "reply";
                                    controller.theMainCommentEntity =
                                        commentEntity;
                                    controller.commentController.clear();
                                    FocusScope.of(context)
                                        .requestFocus(unitCodeCtrlFocusNode);
                                  },
                                ),
                                StreamBuilder(
                                    stream: controller.getSubComments(commentEntity),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      }
                                      return ListView.builder(
                                          itemCount: snapshot.data!.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, subComment) {
                                            final subCommentEntity =
                                                snapshot.data![subComment];
                                            return SubCommentWidget(
                                                likeNumber:
                                                    subCommentEntity.likeNumber,
                                                color: subCommentEntity.likes!
                                                        .contains(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid)
                                                    ? Colors.blue
                                                    : Colors.white,
                                                createdAt: subCommentEntity
                                                    .createdAt!
                                                    .toDate()
                                                    .toString(),
                                                userName: subCommentEntity
                                                    .commentatorName,
                                                commentDescription:
                                                    subCommentEntity
                                                        .commentDescription,
                                                onCommentLongTap: () {
                                                  if (subCommentEntity
                                                          .creatorId ==
                                                      controller
                                                          .currentUser.uid) {
                                                    controller.commentEntity =
                                                        subCommentEntity;
                                                    showModalBottomSheet(
                                                        context: context,
                                                        builder: (context) {
                                                          return SizedBox(
                                                            height: 160,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    sizBoxWidth(
                                                                        MediaQuery.of(context).size.width *
                                                                            .3),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        Get.back();
                                                                        controller
                                                                            .commentController
                                                                            .text = subCommentEntity.commentDescription!;
                                                                        controller.updateOrCreateOrReply =
                                                                            "update";
                                                                      },
                                                                      child: const Text(
                                                                          "Edit Comment"),
                                                                    ),
                                                                    sizBoxWidth(
                                                                        8),
                                                                    const Icon(
                                                                      Icons
                                                                          .edit,
                                                                    )
                                                                  ],
                                                                ),
                                                                const Center(
                                                                    child:
                                                                        Divider()),
                                                                Row(
                                                                  children: [
                                                                    sizBoxWidth(
                                                                        MediaQuery.of(context).size.width *
                                                                            .3),
                                                                    GestureDetector(
                                                                        onTap:
                                                                            () async {
                                                                          controller.commentEntity =
                                                                              subCommentEntity;
                                                                          await controller
                                                                              .deleteComment();
                                                                          Get.back();
                                                                        },
                                                                        child: const Text(
                                                                            "Delete Comment")),
                                                                    sizBoxWidth(
                                                                        8),
                                                                    const Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color: Colors
                                                                          .red,
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                  }
                                                },
                                                profileImageUrl: subCommentEntity
                                                    .commentatorProfileImageUrl,
                                                onLikeButtonTap: () {
                                                  controller.commentEntity =
                                                      subCommentEntity;
                                                  controller.liKeComment();
                                                });
                                          });
                                    })
                              ]);
                            }),
                      ),
                      Obx(
                        () => TextFormField(
                          focusNode: unitCodeCtrlFocusNode,
                          controller: controller.commentController,
                          decoration: InputDecoration(
                            suffixIcon: isLoadingController.isLoading
                                ? const CircularProgressIndicator()
                                : IconButton(
                                    onPressed: () async {
                                      if (controller.updateOrCreateOrReply ==
                                          "create") {
                                        await controller.createComment(
                                          "mainComment",
                                        );
                                      } else if (controller
                                              .updateOrCreateOrReply ==
                                          "reply") {
                                        await controller.createComment("replyComment");
                                        controller.updateOrCreateOrReply =
                                            "create";
                                      } else if (controller
                                              .updateOrCreateOrReply ==
                                          "update") {
                                        await controller.updateComment();
                                        controller.updateOrCreateOrReply =
                                            "create";
                                        controller.commentController.clear();
                                      }
                                    },
                                    icon: const Icon(Icons.send)),
                            hintText: "write comment ...",
                            contentPadding: const EdgeInsets.only(left: 16),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(25)),
                          ),
                        ),
                      ),
                    ]);
                  } else {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          sizBoxHeight(MediaQuery.of(context).size.height * .1),
                          const Center(child: Text("No comments found")),
                          Obx(
                            () => TextFormField(
                              focusNode: unitCodeCtrlFocusNode,
                              controller: controller.commentController,
                              decoration: InputDecoration(
                                suffixIcon: isLoadingController.isLoading
                                    ? const CircularProgressIndicator()
                                    : IconButton(
                                        onPressed: () async {
                                          await controller.createComment("mainComment");
                                        },
                                        icon: const Icon(Icons.send)),
                                hintText: "write comment ...",
                                contentPadding: const EdgeInsets.only(left: 16),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(25)),
                              ),
                            ),
                          )
                        ]);
                  }
                })));
  }
}
