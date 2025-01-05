import 'package:flutter/material.dart';

class EditProfileWidget extends StatelessWidget {
  const EditProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(reverse: true,
      child: Column(mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextField(textAlign: TextAlign.center,decoration:InputDecoration(hintText: "Edit Name"),),
          TextField(textAlign: TextAlign.center,decoration:InputDecoration(hintText: "Edit Username"),),
          TextField(textAlign: TextAlign.center,decoration:InputDecoration(hintText: "Edit Website"),),
          TextField(textAlign: TextAlign.center,decoration:InputDecoration(hintText: "Edit bio"),)
        ],
      ),
    );
  }
}
