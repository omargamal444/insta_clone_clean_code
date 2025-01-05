import 'package:flutter/material.dart';
import 'package:insta_clone/const.dart';
class CommentPage extends StatelessWidget {
  const CommentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return
     Scaffold(
        body: Column(
      children: [const Padding(
          padding: EdgeInsets.only(top: 100)),
      Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
          sizBoxWidth(15),
          const CircleAvatar(radius: 25,child: Text("omar"),),
          sizBoxWidth(15),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
              color: Colors.white.withOpacity(.1),),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start
            ,children: [
              sizBoxHeight(15),
              const Text("omar gamal",style: TextStyle(fontWeight: FontWeight.bold),),
            Expanded(child: const Text(   textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18.0),
                maxLines: 2,
                //softWrap: true,
                "khghhhhklhnklhnklhhjjhhnklhnkdhkhjjhjgjgjnbjgjjgfkfjnfjjgkkhjjhh"))
          ],),),
          sizBoxWidth(20)
        ],),

      ],
    ),

    );
  }
}