import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/const.dart';
import 'package:insta_clone/user_feature/presentation/page/post_page/comment_page.dart';

class PostWidget extends StatelessWidget {
  final String? userName;
  final String?description;
  final String? postImageUrl;
  final String? profileImage;
  final int? likeNumber;
  final String? name;
  final String? commentNumber;
  final Timestamp? createdAt;
  final void Function()? onLoveButtonTap;
  final Color ?color;

  const PostWidget({
    super.key,
    required this.color,
    this.onLoveButtonTap,
    required this.postImageUrl,
    required this.likeNumber,
    required this.profileImage,
    required this.commentNumber,
    required this.userName,
    required this.name,
    required this.createdAt,
    required this.description

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 24),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 180,
                child: Row(
                  children: [ CircleAvatar(backgroundColor: Colors.deepOrange,
                    radius: 26,
                    child: CircleAvatar(
                      radius: 23,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(profileImage!)
                      ),
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
              sizBoxWidth(10),

              Row(
                children: [
                  sizBoxWidth(24),
                  const Icon(Icons.more_vert),
                ],
              )
            ],
          ),
        ),
        if(description!=null) Padding(
          padding: const EdgeInsets.only(top: 16,left: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            Text(description!,style:const TextStyle(fontSize: 16),)
          ],),
        ),
        sizBoxHeight(16),
        Container(height: 220,
          width: MediaQuery
              .of(context)
              .size
              .width * .95,
          decoration: const BoxDecoration(),
          child: Image.network(
            postImageUrl!,
            fit: BoxFit.fill,
          ),
        ),
        sizBoxHeight(16),
        Row(
          children: [
            sizBoxWidth(25),
             GestureDetector(
                 onTap: onLoveButtonTap
             ,child:Icon(
                 Icons.favorite_border_outlined, size: 32,color: color!)),
            sizBoxWidth(24),
            GestureDetector(
                onTap: () {
                  Get.to(const CommentPage());
                },
                child: const Icon(
                  Icons.send_outlined,
                  size: 24,
                )),
            sizBoxWidth(24),
            const Icon(
              Icons.keyboard_option_key_outlined,
              size: 32,
            ),
            sizBoxWidth(MediaQuery
                .of(context)
                .size
                .width * .42),
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
