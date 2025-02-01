import 'package:flutter/material.dart';

import '../../../../../const.dart';

class SubCommentWidget extends StatelessWidget {
  final String? profileImageUrl;
  final String? userName;
  final String? commentDescription;
  final String? createdAt;
  final int?likeNumber;
  final Color?color;
  final void Function()?onLikeButtonTap;
  final void Function()?onCommentLongTap;

  const SubCommentWidget({
    super.key,
    required this.onCommentLongTap,
    required this.likeNumber,
    required this.color,
    required this.onLikeButtonTap,
    required this.createdAt,
    required this.commentDescription,
    required this.userName,
    required this.profileImageUrl
  });
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizBoxWidth(56),
            CircleAvatar(
              backgroundColor: Colors.deepOrange,
              radius: 19,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: CircleAvatar(backgroundImage: NetworkImage(
                    profileImageUrl!
                ),
                ),
              ),
            ),
            sizBoxWidth(4),
            Flexible(
              child: GestureDetector(onLongPress: onCommentLongTap,
                child: Container(decoration: BoxDecoration(
                    color:Colors.white.withOpacity(.1),
                    borderRadius: BorderRadius.circular(16)
                ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8,top: 16),
                            child: Text(
                              userName!,
                              style: const TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      sizBoxHeight(2),
                      Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16,bottom: 8),
                              child: Text(
                                  style: const TextStyle(fontSize: 16),
                                  commentDescription!
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            sizBoxWidth(MediaQuery.of(context).size.width*.007),
            IconButton(
                color: color,
                onPressed:onLikeButtonTap
                , icon:const Icon(Icons.thumb_up)),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(likeNumber!.toString(),),
            ),
            sizBoxWidth(25),

          ],
        ),
        sizBoxHeight(10),
        Text(createdAt!),
        sizBoxHeight(10),


      ],
    );
  }
}
