import 'package:flutter/material.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';

class DummyShopCard extends StatelessWidget {
  const DummyShopCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
          color: AppColors.fontOnSecondary,
          borderRadius: BorderRadius.circular(12)),
      child:const Center(

      ),
    );
  }
}
