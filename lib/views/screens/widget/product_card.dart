import 'package:flutter/material.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_images.dart';
import 'package:what_shop/constants/app_variables.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';

class ProductCard extends StatelessWidget {
  final String? image;
  final String? name;
  final onTouch;
  double? marginRight;
   ProductCard(
      {super.key,
       this.image,
       this.name,
       this.onTouch,
      this.marginRight
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTouch,
      child: Container(
        margin: EdgeInsets.only(right:marginRight ?? 0),

        constraints: BoxConstraints(
          minHeight: 140,
          minWidth: 110,
          maxWidth: 110,
        ),
        child: Column(
          children: [
            (image != null && image!.isNotEmpty)
                ?
             Expanded(
               flex: 4,
               child: Container(
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
                          }, )),
                    ),
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
                        child: Text('img not available'),
                      ),
                    ),
                  ),
            SizedBox(
              height: 3,
            ),
            Expanded(
              child: Container(
                width: 90,
                child: Text(
                  name ?? '...',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 9),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),

          ],
        ),
      ),
    );
  }
}



