import 'package:flutter/material.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_images.dart';
import 'package:what_shop/constants/app_variables.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';

class ProductCard extends StatelessWidget {
  final String? image;
  final String name;
  final String price;
  final String offerPrice;
  final onTouch;

  const ProductCard(
      {super.key,
      this.image,
      required this.name,
      required this.offerPrice,
      required this.price,
      required this.onTouch});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTouch,
      child: Container(
        margin: EdgeInsets.only(right: 15),
        constraints: BoxConstraints(
          minHeight: 128,
          minWidth: 110,
          maxWidth: 110,
        ),
        child: Column(
          children: [
            (image != null || image!.isNotEmpty)
                ? Container(
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        border: Border.all(color: Color(0xffE4E4E4)),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6))),
                    height: 80,
                    width: 110,
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6)),
                        child: Image.network(AppVariables.baseUrl + image!,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                          return Center(
                            child: PrimaryText(
                              text: 'Image not available',
                              fontSize: 7,
                            ),
                          );
                        }, fit: BoxFit.cover)),
                  )
                : Container(
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        border: Border.all(color: Color(0xffE4E4E4)),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6))),
                    height: 80,
                    width: 110,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6)),
                      child: Center(
                        child: Text('child not available'),
                      ),
                    ),
                  ),
            SizedBox(
              height: 3,
            ),
            Text(
              name,
              style: TextStyle(fontSize: 9),
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PrimaryText(
                  text: offerPrice,
                  fontSize: 8,
                  color: AppColors.teal,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 7,
                    color: AppColors.fontOnWhite,
                    decoration: TextDecoration.lineThrough,
                    decorationThickness: 1.5,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
