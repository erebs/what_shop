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
    print('afzxvczbnvcnbzvxnbcxzvnbzcv');
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
                    itemCount: categoryWiseProductController.categoryProducts
                        .length + 1,
                    itemBuilder: (context, index) {
                      if (index < categoryWiseProductController.categoryProducts
                          .length) {
                        final data = categoryWiseProductController
                            .categoryProducts[index];
                        return ProductListTileCard(data: data,onTap:(){
                          Get.toNamed(
                                    RouteName.productDetailsScreen,
                                    arguments: data.id.toString(),);
                        } ,);
                      } else if (index ==
                          categoryWiseProductController.categoryProducts
                              .length) {
                        return Obx(() =>
                        categoryWiseProductController.pageNumber.value <
                            categoryWiseProductController.lastPage!
                            ? Center(
                          child: CustomProgressIndicator(strokeWidth: 1),
                        )
                            : SizedBox.shrink());
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



}
