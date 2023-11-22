import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_images.dart';
import 'package:what_shop/constants/app_variables.dart';
import 'package:what_shop/controller/add_favourite_controller.dart';
import 'package:what_shop/controller/cart_count_controller.dart';
import 'package:what_shop/controller/shop_information_controller.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';

class ShopAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isHome;
  final String? shopId;
  final int? themeColor;
  final String? logo;
  // final String? cartCount;
  const ShopAppBar({Key? key, this.isHome = false,this.shopId,this.themeColor,this.logo}) : super(key: key);

  @override
  State<ShopAppBar> createState() => _ShopAppBar();

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _ShopAppBar extends State<ShopAppBar> {
  final CartCountController controller = Get.find();
  final ShopInformationController shopInformationController = Get.find();
  final AddFavouriteShopController addFavouriteShopController = Get.put(AddFavouriteShopController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PreferredSize(
        preferredSize: Size.fromHeight(Get.height / 4),
        child: Container(
          padding: EdgeInsets.only(left: Get.width * 0.02,right: Get.width * 0.001),
          height: widget.preferredSize.height,
          color:AppColors.primaryDark,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              drawerOrBackButton(),
              appLogo(),
             favouriteAndCartIcon()
            ],
          ),
        ),
      ),
    );
  }
  Widget drawerOrBackButton(){
    return  widget.isHome
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
    );
  }

  Widget appLogo(){
    return widget.isHome ? Expanded(child: SvgPicture.asset(AppImages.appLogoSvg,height: 25,)):SizedBox.shrink();

  }

  Widget favouriteIcon(){
    return Obx(() => TouchableOpacity(
      onTap:(){
        addFavouriteShopController.addToFavouriteShops(context: context);
      } ,
      child: Icon(
        Remix.heart_fill, color: shopInformationController.shopInformation.value?.isFavourite == true  ?  Colors.pink.shade400 : AppColors.fontOnSecondary,size:19,),
    ));
  }
  Widget cartLogo(){
    return  Stack(
      children: [
        IconButton(
          onPressed: () {
            Get.toNamed(RouteName.cartScreen,arguments:widget.shopId);
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
        Obx(() => controller.cartCount.value == 0 ? SizedBox.shrink() : Visibility(
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
                color: AppColors.lightGrey,
              ),
              child: Center(
                  child:Obx(()=> Text(
                    controller.cartCount.value.toString(),
                    style:const TextStyle(fontSize:10, color:AppColors.primaryDark),
                  ),)
              ),
            ),
          ),
        )
        )
        //   }
        // })
      ],
    );
  }
  Widget favouriteAndCartIcon(){
    return Row(
      children: [
        favouriteIcon(),
        cartLogo()
      ],
    );
  }
}

