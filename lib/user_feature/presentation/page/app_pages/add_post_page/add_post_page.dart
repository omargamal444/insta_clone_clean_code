import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    Column(children: [Container(color: Colors.green,
        height: MediaQuery.of(context).size.height*.5
        ,width: MediaQuery.of(context).size.width),],),);
  }
}
