import 'package:flutter/material.dart';

import '../../../../../const.dart';

class CommentWidget extends StatelessWidget {
  final String? profileImageUrl;
  final String? userName;
  final String? commentDescription;
  final String? createdAt;
  final int? likeNumber;
  final Color? color;
  final void Function()? onLikeButtonTap;
  final void Function()? onCommentLongTap;
  final void Function()? onReplyButtonPressed;

  const CommentWidget({
    super.key,
    required this.onReplyButtonPressed,
    required this.onCommentLongTap,
    required this.likeNumber,
    required this.color,
    required this.onLikeButtonTap,
    required this.createdAt,
    required this.commentDescription,
    required this.userName,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizBoxWidth(15),
              CircleAvatar(
                backgroundColor: Colors.deepOrange,
                radius: 26,
                child: CircleAvatar(
                  radius: 23,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                      backgroundImage: NetworkImage(profileImageUrl!)),
                ),
              ),
              sizBoxWidth(8),
              Flexible(
                child: GestureDetector(
                  onLongPress: onCommentLongTap,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.1),
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 16),
                              child: Text(
                                userName!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        sizBoxHeight(2),
                        Row(
                          children: [
                            Flexible(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, bottom: 8),
                                child: Text(
                                    style: const TextStyle(fontSize: 16),
                                    commentDescription!),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              sizBoxWidth(25),
            ],
          ),
          Row(
            children: [
              sizBoxWidth(MediaQuery.of(context).size.width * .06),
              Text(createdAt!),
              TextButton(
                  onPressed: onReplyButtonPressed, child: const Text("reply")),
              sizBoxWidth(MediaQuery.of(context).size.width * .007),
              IconButton(
                  color: color,
                  onPressed: onLikeButtonTap,
                  icon: const Icon(Icons.thumb_up)),
              Text(
                likeNumber!.toString(),
              )
            ],
          ),
        ],
      ),
    );
  }
}
