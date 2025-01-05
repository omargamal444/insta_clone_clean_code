import 'package:flutter/material.dart';
import 'package:insta_clone/const.dart';

import 'edit_profile_widget.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Padding(
      padding: const EdgeInsets.only(top: 80),
          child: Column(
            children: [
              Row(
                children: [
                  sizBoxWidth(30),
                  const Text("Edit Profile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                ],
                
              ),
              sizBoxHeight(50),
              const CircleAvatar(radius: 60,child: Text('omar'),),
              sizBoxHeight(20),
              const Text("change profile photo",style: TextStyle(color: Colors.red),),
              const Expanded(child: EditProfileWidget())
            ],
          ),

    ),);
  }
}
