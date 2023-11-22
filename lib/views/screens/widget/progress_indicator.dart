import 'package:flutter/material.dart';
import 'package:what_shop/constants/app_colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double? strokeWidth;

  CustomProgressIndicator({this.strokeWidth});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: CircularProgressIndicator(
        color: AppColors.primary,
        strokeWidth: strokeWidth ?? 2,
      ),
    );
  }
}
