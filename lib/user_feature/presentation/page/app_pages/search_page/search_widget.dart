import 'package:flutter/material.dart';
import 'package:insta_clone/const.dart';

class  SearchItemWidget extends StatelessWidget {
  final String profileImageUrl;
  final String userName;
  final void Function()onSearchItemTap;
  const SearchItemWidget({
    super.key,
    required this.profileImageUrl,
    required this.userName,
    required this.onSearchItemTap

  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: onSearchItemTap,
        child: Container(color: Colors.white.withOpacity(.1),
          child: Row(
            children: [
              sizBoxWidth(16),
              CircleAvatar(
              backgroundColor: Colors.deepOrange,
              radius: 20,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: CircleAvatar(backgroundImage: NetworkImage(
                    profileImageUrl
                )),
              ),
            ),
            sizBoxWidth(8),
            Text(userName,style: const TextStyle(fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
    );
  }
}
