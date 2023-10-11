import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';

class SecondaryCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;

  SecondaryCustomAppBar({Key? key, required this.title})
      : preferredSize = Size.fromHeight(47),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(47),
      child: Container(
        color: AppColors.primaryDark,
        child: Row(
          children: [
            IconButton(onPressed: (){
              Get.back();
            }, icon:Icon(Remix.arrow_left_s_line,color: AppColors.fontOnSecondary,)),
            SizedBox(width: 5,),
            PrimaryText(text:title,color: AppColors.fontOnSecondary,fontSize:12,)
          ],
        ),
      ),
      // Add other desired AppBar attributes
    );
  }
}
