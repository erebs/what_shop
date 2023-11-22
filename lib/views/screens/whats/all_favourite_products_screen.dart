import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_variables.dart';
import 'package:what_shop/controller/favourite_products_controller.dart';
import 'package:what_shop/views/screens/widget/product_card.dart';
import 'package:what_shop/views/screens/widget/product_list_tile_card.dart';
import 'package:what_shop/views/screens/widget/secondary_custom_app_bar.dart';

import '../widget/primary_text.dart';


class AllFavouriteProductsScreen extends StatefulWidget {
  const AllFavouriteProductsScreen({super.key});

  @override
  State<AllFavouriteProductsScreen> createState() => _AllFavouriteProductsScreenState();
}

class _AllFavouriteProductsScreenState extends State<AllFavouriteProductsScreen> {
  final favouriteProducts = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SecondaryCustomAppBar(title: 'Favourite products'),
        body: Container(
          height: Get.height,
          padding: EdgeInsets.only(bottom: 15,top:15,left:10,right:10),
          child: Column(
            children: [
              Expanded(child:GridView.builder(itemCount:favouriteProducts.length ?? 0,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
              ),itemBuilder: (context, index) => ProductCard(
               onTouch: (){},name: favouriteProducts[index].name,
                 image: favouriteProducts[index].image,


              )) )
            ],
          ),
        ),
      ),
    );
  }
  Widget productTileCard({required onTap,required data}) {
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
                    text: '',
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
