import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../constants/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    Key? key,
    required this.buttonText,
    required this.onTap,
    this.isContinue = false,


  }) : super(key: key);

  String buttonText;
  VoidCallback onTap;
  bool isContinue;


  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: onTap,
      activeOpacity: 0.8,
      child: Container(
        height: 60,
        width: double.maxFinite,
        padding: EdgeInsets.all(18),
        decoration:   BoxDecoration(
            color: AppColors.primary,
            border: Border.all(width: 0, color: AppColors.primary),
            borderRadius: BorderRadius.circular(25)
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                buttonText,
                style: const TextStyle(
                    color: AppColors.fontOnSecondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),),
            ),

            Align(
                alignment: Alignment.centerRight,
                child: Icon(Remix.arrow_right_line, color: AppColors.fontOnSecondary, size: isContinue?20:0))

          ],
        ),
      ),
    );
  }
}


class PrimaryButtonLoader extends StatelessWidget {
  const PrimaryButtonLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.maxFinite,
      padding: const EdgeInsets.all(5),
      decoration:   BoxDecoration(
          color: AppColors.primary.withOpacity(0.8),
          border: Border.all(width: 0, color: AppColors.primary),
          borderRadius: BorderRadius.circular(25)
      ),
      child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,)),
    );
  }
}

class TabButton extends StatelessWidget {
  TabButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.isSelected = false,
  }) : super(key: key);

  final String text;
  bool isSelected;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: onTap,
      child: Container(
          height: 36,
          width: 110,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration:   BoxDecoration(
              color: isSelected?AppColors.primary:Colors.white,
              border: Border.all(width: 1, color: AppColors.primary),
              borderRadius: BorderRadius.circular(10)
          ),
          child: Align(
              alignment: Alignment.center,
              child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  color: isSelected?Colors.white:AppColors.primary,)
              )
          )

      ),
    );
  }
}


class TabButtonDelete extends StatelessWidget {
  TabButtonDelete({
    Key? key,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  bool isSelected;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: onTap,
      child: Container(
          height: 36,
          width: 110,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration:   BoxDecoration(
              color: isSelected?AppColors.primary:Colors.white,
              border: Border.all(width: 1, color: AppColors.primary),
              borderRadius: BorderRadius.circular(10)
          ),
          child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 3,)
          )

      ),
    );
  }
}