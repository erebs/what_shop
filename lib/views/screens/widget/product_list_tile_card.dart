import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_variables.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/screens/widget/shimmer_container.dart';


class ProductListTileCard extends StatelessWidget {
  final VoidCallback? onTap;
  var data;

   ProductListTileCard({Key?key,this.onTap,this.data});

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap:onTap,
      child: Container(
        height: 100,
        padding: EdgeInsets.only(top: 10,
            bottom: 10,
            right:20),
        color: AppColors.fontOnSecondary,
        margin: EdgeInsets.only(bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            data != null
                ? Expanded(
              child: Container(
                height: 100,
                child: Image.network(
                  AppVariables.baseUrl + data.image,
                  errorBuilder: (context, error,
                      stackTrace) =>
                      Center(child: Text('!')),
                ),
              ),
            )
                : Container(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start,
                children: [
                  PrimaryText(
                    text: data!.name,
                    alignment: TextAlign.left,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PrimaryText(
                    text: data.desc,
                    alignment: TextAlign.left,
                    fontSize: 9,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                 //  Icon(
                 // Remix.heart_fill,
                 //   color: data.isFavourite == true ? Colors.pink.shade400 :
                 //         AppColors.lightGrey,
                 //  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


