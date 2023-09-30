import 'package:flutter/material.dart';


class ErrorText extends StatelessWidget {
  final String text;
  const ErrorText({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,style:const TextStyle(
      color: Colors.red,
      fontSize: 12
    ),);
  }
}
