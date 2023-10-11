import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_images.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';

class ShopAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isHome;
  const ShopAppBar({Key? key, this.isHome = false}) : super(key: key);

  @override
  State<ShopAppBar> createState() => _ShopAppBar();

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _ShopAppBar extends State<ShopAppBar> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
        height: widget.preferredSize.height,
        color: AppColors.primaryDark,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.isHome
                ? IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
      },
        icon: const Icon(
          Remix.menu_2_fill,
          color: AppColors.inputBackgroundColor,
          size: 23,
        ),
      )
                : IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Remix.arrow_left_s_line,
                color: AppColors.inputBackgroundColor,
                size: 23,
              ),
            ),
           widget.isHome ? Row(
              children: [
                Image.asset(AppImages.appLogo),
                SizedBox(width: 8,),
                PrimaryText(text: 'WhatsAppShop',color: AppColors.inputBackgroundColor,fontSize:12,),
              ],
            ):SizedBox.shrink(),

            Stack(
              children: [
                IconButton(
                  onPressed: () {

                  },
                  icon: const Icon(
                    Remix.shopping_cart_2_fill,
                    size: 18,
                    color:AppColors.inputBackgroundColor,
                  ),
                ),
                // Obx(() {
                //   {
                //     return
                    Visibility(
                      // visible:controller.cartCount != RxString('0') && controller.cartCount.isNotEmpty ,
                      child: Positioned(
                        right: 5,
                        top: 5,
                        child: Container(
                          constraints: BoxConstraints(
                            minHeight: Get.width / 23,
                            minWidth: Get.width / 23,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.teal,
                          ),
                          child: Center(
                            child: Text(

                              '6',
                              style:const TextStyle(fontSize: 8, color:AppColors.primaryDark),
                            ),
                          ),
                        ),
                      ),
                    )
                //   }
                // })
              ],
            )
          ],
        ),
      ),
    );
  }
}
