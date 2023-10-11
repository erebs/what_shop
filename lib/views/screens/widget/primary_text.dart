import 'package:flutter/material.dart';


class PrimaryText extends StatelessWidget {
  final double? fontSize;
  final FontWeight? fontWeight;
  final String text;
  final Color? color;
  const PrimaryText({super.key,this.fontSize = 11,this.fontWeight,required this.text,this.color});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize: fontSize,fontWeight:fontWeight,color: color),textAlign: TextAlign.center,);
  }
}
