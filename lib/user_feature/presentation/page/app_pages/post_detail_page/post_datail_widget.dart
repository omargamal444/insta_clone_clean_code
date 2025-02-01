import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../const.dart';

class PostDetailWidget extends StatelessWidget {
  final String?description;
  final String?postImageUrl;
  final String?likeNumber;
  final String?userName;
  final String?userProfileUrl;
  final String?commentNumber;
  final Timestamp?createdAt;
  final void Function()?onUserNameTap;
  const PostDetailWidget({
    required this.userProfileUrl,
    required this.userName,
    required this.createdAt,
    required this.commentNumber,
    required this.likeNumber,
    required this.description,
    required this.postImageUrl,
    required this.onUserNameTap,
    super.key});

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
                            backgroundImage: CachedNetworkImageProvider(
                              userProfileUrl!,
                              errorListener: (p0) => const Icon(Icons.error_outline_rounded,color: Colors.red,),
                            )),
                      ),
                    ),
                    sizBoxWidth(8),

                       Flexible(
                        child:
                        GestureDetector(
                          onTap: onUserNameTap,
                          child:Text(
                          userName!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
            height: 400,
            width: MediaQuery.of(context).size.width * .95,
            decoration: const BoxDecoration(),
            child: CachedNetworkImage(
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
            const Icon(Icons.favorite_border_outlined, size: 32),
            sizBoxWidth(24),
            const Icon(
              Icons.keyboard_option_key_outlined,
              size: 32,
            ),
            sizBoxWidth(MediaQuery.of(context).size.width * .49),
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
