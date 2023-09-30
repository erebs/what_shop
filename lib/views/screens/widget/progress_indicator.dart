import 'package:flutter/material.dart';
import 'package:what_shop/constants/app_colors.dart';


class CustomProgressIndicator extends StatelessWidget {

   const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 30,
      width: 30,
      child: CircularProgressIndicator(color: AppColors.primary,),
    );
  }
}
