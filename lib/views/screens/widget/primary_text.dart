import 'package:flutter/material.dart';


class PrimaryText extends StatelessWidget {
  final double? fontSize;
  final FontWeight? fontWeight;
  final String text;
  final Color? color;
  final Color? backgroundColor;
final TextAlign? alignment;
  const PrimaryText({super.key,this.fontSize = 11,this.fontWeight,required this.text,this.color,this.backgroundColor,this.alignment});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize: fontSize,fontWeight:fontWeight,color: color,letterSpacing:.3,backgroundColor: backgroundColor ?? Colors.transparent),textAlign: alignment ?? TextAlign.center,maxLines: 2,);
  }
}
