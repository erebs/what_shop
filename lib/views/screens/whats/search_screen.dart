import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_shop/constants/appSizes.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_images.dart';
import 'package:what_shop/controller/all_shops_controller.dart';
import 'package:what_shop/controller/search_screen_controller.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/views/screens/common/error_page.dart';
import 'package:what_shop/views/screens/widget/app_bar.dart';
import 'package:what_shop/views/screens/widget/dummy_shop_card.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/screens/widget/progress_indicator.dart';
import 'package:what_shop/views/screens/widget/shop_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  final allShopsController = Get.put(AllShopsController());
 final SearchScreenController searchController = Get.put(SearchScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar:  CustomAppBar(isSearch: true,searchText: searchController.searchText,onChange: (val){
          print(val);
          searchController.getFilteredShop();
        }),
        body: SingleChildScrollView(
          child: Container(
            color: AppColors.inputBackgroundColor,
            padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding - 10, vertical: 12),
            constraints:
                BoxConstraints(minHeight: Get.height, minWidth: Get.width),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                allShopsController.errorMessage.value.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: PrimaryText(text: 'All Shops'),
                      )
                    : const SizedBox.shrink(),
                Obx(() {
                  final allShops = allShopsController.allShops.value?.shops;
                  if (allShopsController.isLoading.value) {
                    return Center(child: CustomProgressIndicator(strokeWidth: 3,));
                  } else if (allShopsController.errorMessage.value.isNotEmpty) {
                    return ErrorScreen(
                      img: AppImages.errorImg,
                      errorMsg: allShopsController.errorMessage.value,
                      onTap: () {
                        allShopsController.reloadAllShops();
                      },
                    );
                  }else if(searchController.filteredShops.isNotEmpty){

                    return SingleChildScrollView(
                      child: Wrap(
                          runSpacing: runSpacing,
                          spacing:  (Get.width - (2*(horizontalPadding - 10))-(4 * 75))/3,
                        children:searchController.filteredShops.map((shop) =>ShopCard(image: shop.logo, name: shop.name, onTap:(){
                          FocusScope.of(context).unfocus();
                          Get.toNamed(RouteName.mainScreen,arguments: shop.id.toString());
                        })).toList()

                      ),
                    );
                    // Expanded(
                    //   child: ListView.builder(
                    //     itemCount: allShops?.length,
                    //     itemBuilder: (context, index) {
                    //       return ShopCard(image: allShops![index].logo, name: allShops![index].name, onTap:(){});
                    //     },
                    //   ),
                    // );
                  }else{
                    return SingleChildScrollView(
                      child: Wrap(
                          runSpacing: runSpacing,
                          spacing:  (Get.width - (2*(horizontalPadding - 10))-(4 * 75))/3,
                          children:allShops!.map((shop) =>ShopCard(image: shop.logo, name: shop.name, onTap:(){
                            Get.toNamed(RouteName.mainScreen,arguments: shop.id.toString());
                          })).toList()

                      ),
                    );
                  }


                }),
              ],
            ),
          ),
        ));
  }
}
