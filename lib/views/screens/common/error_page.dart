import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/views/widgets/buttons.dart';

class ErrorScreen extends StatefulWidget {
  final String errorMsg;
  final onTap;
  const ErrorScreen({super.key,required this.errorMsg,required this.onTap});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Remix.error_warning_line,size:30,),
          SizedBox(height:20,),
          Text('${widget.errorMsg}',textAlign: TextAlign.center,),
          SizedBox(height:50,),
          SizedBox(
            height:40,
            width: 100,
            child: SecondaryButton(
              onTap:widget.onTap,
              buttonText: 'Retry',
              backgroundColor: AppColors.primary,
              fontColor: AppColors.fontOnSecondary,
              borderRadius:20,
            ),
          )
        ],
      ),
    );
  }
}