import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_images.dart';
import 'package:what_shop/constants/app_variables.dart';
import 'package:what_shop/controller/category_wise_product_controller.dart';
import 'package:what_shop/utils/api_state_enum.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/views/screens/common/error_page.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/screens/widget/product_list_tile_card.dart';
import 'package:what_shop/views/screens/widget/progress_indicator.dart';
import 'package:what_shop/views/screens/widget/secondary_custom_app_bar.dart';
import 'package:what_shop/views/screens/widget/shimmer_container.dart';

class CategoryWiseProductScreen extends StatefulWidget {
  const CategoryWiseProductScreen({super.key});

  @override
  State<CategoryWiseProductScreen> createState() =>
      _CategoryWiseProductScreenState();
}

class _CategoryWiseProductScreenState extends State<CategoryWiseProductScreen> {
  //variables
  final dataFromPreviousScreen = Get.arguments;
  late final CategoryWiseProductController categoryWiseProductController;

  //------------
  @override
  void initState() {
    super.initState();
    categoryWiseProductController = Get.put(
      CategoryWiseProductController(catId: dataFromPreviousScreen['categoryId'].toString()),
    );
    print(dataFromPreviousScreen);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SecondaryCustomAppBar(
          title: dataFromPreviousScreen['screenName'] ?? '',
          onTap: (){
            categoryWiseProductController.categoryProducts.clear();
            Get.back();
          },
        ),
        body: Container(
          height: Get.height,
          width: Get.width,

          child: Obx(
                () {
                  final products = categoryWiseProductController.categoryProductResponse.value?.products;
                  if (categoryWiseProductController.categoryWiseProductState
                      .value == DataState.Loading) {
                    return ProductTileShimmerList();
                  }
                  if (categoryWiseProductController.categoryWiseProductState
                      .value == DataState.Empty) {
                    return ErrorScreen(errorMsg: 'No products', onTap: () {
                      Get.back();
                    }, buttonText: 'Go back', img: AppImages.noShops);
                  }
                  if (categoryWiseProductController.categoryWiseProductState
                      .value == DataState.Empty) {
                    return ErrorScreen(errorMsg: 'No products', onTap: () {
                      Get.back();
                    }, buttonText: 'Go back',);
                  }
                  return
                    ListView.builder(
                    controller: categoryWiseProductController.scrollController,
                    itemCount: categoryWiseProductController.categoryProducts.length + 1,
                    itemBuilder: (context, index) {
                      if (index < categoryWiseProductController.categoryProducts.length) {
                        final data = categoryWiseProductController.categoryProducts[index];
                        return ProductTile(
                          data:data,onTap:(){
                          Get.toNamed(
                                    RouteName.productDetailsScreen,
                                    arguments: data?.id.toString(),);
                        } ,);
                      } else if (index ==
                         categoryWiseProductController.categoryProducts.length) {
                        return Obx(() {
                          final pageNumber = categoryWiseProductController.pageNumber.value;
                          final lastPage = categoryWiseProductController.lastPage ?? 0;
                       return  pageNumber < lastPage
                            ? Center(
                          child: CustomProgressIndicator(strokeWidth: 1),
                        )
                            : SizedBox.shrink();});
                      }
                      return SizedBox.shrink();
                    },
                  );
                }
  )
        ),
      ),
    );
  }

  Widget ProductTile({required data,required onTap}){
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
                    text: data.name,
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
