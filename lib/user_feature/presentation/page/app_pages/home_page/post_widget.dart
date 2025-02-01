import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/const.dart';
import 'package:insta_clone/user_feature/domain/entity/user_entity.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/comment_page/comment_page.dart';

class PostWidget extends StatelessWidget {
  final UserEntity currentUser;
  final String? userName;
  final String? description;
  final String? postImageUrl;
  final String? profileImage;
  final int? likeNumber;
  final List<bool>? showDeleteWidget;
  final int? index;
  final String? name;
  final String? commentNumber;
  final Timestamp? createdAt;
  final void Function()? onLoveButtonTap;
  final void Function()? onDeleteButtonTap;
  final void Function()? onPostSettingIconTap;
  final void Function()? onUpdatePostButtonTap;
  final void Function()? onCommentButtonTap;
  final Color? color;
  final String? creatorId;

  const PostWidget(
      {super.key,
      required this.onCommentButtonTap,
      required this.onDeleteButtonTap,
      required this.index,
      required this.showDeleteWidget,
      required this.currentUser,
      required this.creatorId,
      required this.color,
      required this.onLoveButtonTap,
      required this.onPostSettingIconTap,
      required this.onUpdatePostButtonTap,
      required this.postImageUrl,
      required this.likeNumber,
      required this.profileImage,
      required this.commentNumber,
      required this.userName,
      required this.name,
      required this.createdAt,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 180,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.deepOrange,
                      radius: 26,
                      child: CircleAvatar(
                        radius: 23,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(profileImage!)),
                      ),
                    ),
                    sizBoxWidth(8),
                    Flexible(
                      child: Text(
                        name!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              if (showDeleteWidget![index!] == true)
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: onDeleteButtonTap,
                          child: const Text(
                            "delete post",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: onUpdatePostButtonTap,
                          child: const Text(
                            "update post",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              sizBoxWidth(5),
              if (creatorId == currentUser.uid)
                Row(
                  children: [
                    sizBoxWidth(24),
                    GestureDetector(
                        onTap: onPostSettingIconTap,
                        child: const Icon(Icons.more_vert)),
                  ],
                )
            ],
          ),
        ),
        if (description != null && description != "")
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 16, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    description!,
                    style: const TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        sizBoxHeight(8),
        Container(
            height: 440,
            width: MediaQuery.of(context).size.width * .95,
            decoration: const BoxDecoration(),
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: postImageUrl!,
              placeholder: (context, url) {
                return const Center(child: CircularProgressIndicator());
              },
              errorWidget: (context, url, error) {
                return const Center(
                  child: Icon(
                    Icons.error_outline_rounded,
                    color: Colors.red,
                  ),
                );
              },
            )),
        sizBoxHeight(16),
        Row(
          children: [
            sizBoxWidth(25),
            GestureDetector(
              onTap: onLoveButtonTap,
              child:
                  Icon(Icons.favorite_border_outlined, size: 32, color: color!),
            ),
            sizBoxWidth(24),
            GestureDetector(
                onTap: () {
                  Get.toNamed(CommentPage.commentPage);
                },
                child: GestureDetector(
                  onTap: onCommentButtonTap,
                  child: const Icon(
                    Icons.send_outlined,
                    size: 24,
                  ),
                )),
            sizBoxWidth(24),
            const Icon(
              Icons.keyboard_option_key_outlined,
              size: 32,
            ),
            sizBoxWidth(MediaQuery.of(context).size.width * .42),
            const Icon(
              Icons.mode_comment_outlined,
              size: 32,
            )
          ],
        ),
        sizBoxHeight(8),
        Row(children: [
          sizBoxWidth(24),
          Text(
            "${likeNumber!} likes",
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ]),
        sizBoxHeight(16),
        Row(children: [
          sizBoxWidth(24),
          Text(
            userName!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ]),
        sizBoxHeight(16),
        Row(children: [
          sizBoxWidth(24),
          Text(
            "view all ${commentNumber!} comments",
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ]),
        sizBoxHeight(16),
        Row(children: [
          sizBoxWidth(24),
          Text(
            createdAt!.toDate().toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ]),
      ],
    );
  }
}
