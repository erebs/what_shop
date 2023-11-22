import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_variables.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';

class ShopCard extends StatelessWidget {
  final String? image;
  final String? name;
  final String? rating;
  final void Function() onTap;

  const ShopCard(
      {super.key,
       this.image,
       this.name,
      this.rating,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: onTap,
      child: Container(

        constraints: const BoxConstraints(
          minHeight: 90,
          // maxHeight: 110,
          maxWidth:75,
            minWidth:75
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 70,
                width: 70,
                decoration:
                    BoxDecoration(

                        color: AppColors.fontOnSecondary,

                        borderRadius: BorderRadius.circular(12)),
                child: image!.isNotEmpty
                    ?
                Image.network(
                        AppVariables.baseUrl + image!,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: AppColors.fontOnSecondary,
                          constraints: const BoxConstraints(
                            minHeight: 90,
                            maxHeight: 90,
                          ),
                          child:const Center(
                            child: PrimaryText(
                              text: 'Image not available',
                              fontSize: 5,
                            ),
                          ),
                        ),
                        fit: BoxFit.fill,
                      )
                    : Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: AppColors.fontOnSecondary,
                            borderRadius: BorderRadius.circular(12)),
                  child:const Center(
                    child: PrimaryText( text: 'Image not available',fontSize: 5,),
                  ),
                      ),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            PrimaryText(
              text: name ?? '',
              fontSize: 9,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //    PrimaryText(text: rating,fontSize:8,),
            //     const Icon(
            //       Remix.star_fill,
            //       size: 5,
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
