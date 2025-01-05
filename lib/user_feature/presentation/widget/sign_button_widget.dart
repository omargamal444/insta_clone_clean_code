import 'package:flutter/material.dart';

class Sign extends StatelessWidget {
  final String sign;
 const Sign({required this.sign,super.key});
  @override
  Widget build(BuildContext context) {
    return (
    Container(
      width: 330,
      height: 55,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
    color: Colors.blue),child: Center(child: Text(sign)),
    )
    )
    ;
  }
}
