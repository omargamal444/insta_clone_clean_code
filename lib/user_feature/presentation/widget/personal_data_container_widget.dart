import 'package:flutter/material.dart';
import 'package:insta_clone/const.dart';

class PersonDataContainer extends StatelessWidget {
final String requirement;
 const PersonDataContainer(this.requirement, {super.key});
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty){
            return "لا يمكن ترك الحق فارغا";
          }
        },
      textAlign: TextAlign.left
      ,decoration: InputDecoration(
        contentPadding:const EdgeInsets.only(top: 10,left: 20),
          hintText: requirement,enabledBorder:OutlineInputBorder(
       borderRadius: BorderRadius.circular(20),
    borderSide:const BorderSide(color: whiteColor,width: 2,
      style: BorderStyle.solid
      )
      )
      //border: const OutlineInputBorder()
      ),),
    );
  }
}
