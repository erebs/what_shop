import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_variables.dart';
import 'package:what_shop/controller/shop_data_controller.dart';
import 'package:what_shop/utils/api_state_enum.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/views/screens/common/error_page.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/screens/widget/product_card.dart';
import 'package:what_shop/views/screens/widget/product_list_tile_card.dart';
import 'package:what_shop/views/screens/widget/progress_indicator.dart';
import 'package:what_shop/views/screens/widget/secondary_custom_app_bar.dart';
import 'package:what_shop/views/screens/widget/shimmer_container.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  final Map<String, dynamic> category = Get.arguments;
  final ShopDataController productController = Get.find();
  ScrollController scrollController = ScrollController();

  void initState() {
    super.initState();
    print(category['endPoint']);

    productController.getAllProductsByCategory(productController.currentPage,
        category['endPoint'], category['category']);
    scrollController.addListener(pagination);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SecondaryCustomAppBar(
          title: category['screen_name'],
          onTap: () {
            productController.allProducts = [];
            productController.currentPage.value = 1;
            Get.back();
          },
        ),
        body: Container(
          constraints: BoxConstraints(minHeight: Get.height),
          padding: EdgeInsets.only(left: 15, top: 20),
          child: Obx(() {
            if (productController.isAllProductsLoading.value) {
              return ProductTileShimmerList();
            }
            if (productController.allProductState.value == DataState.Error) {
              return ErrorScreen(
                onTap: () {
                  productController.getAllProductsByCategory(
                      productController.currentPage,
                      category['endPoint'],
                      category['category']);
                },
                errorMsg: productController.errorMessage.value,
              );
            }

            return Column(
              children: [
                if (category['category'] == 'featuredproducts')
                  Expanded(
                    child: _buildProductGrid(productController
                        .allProductByCategory.value?.featuredproducts?.data),
                  ),
                if (category['category'] == 'trendingproducts')
                  Expanded(
                    child: _buildProductGrid(productController
                        .allProductByCategory.value?.trendingproducts?.data),
                  ),
                if (category['category'] == 'popularproducts')
                  Expanded(
                    child: _buildProductGrid(productController
                        .allProductByCategory.value?.popularproducts?.data),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildProductGrid(List<dynamic>? productDataList) {
    return ListView.builder(
        controller: scrollController,
        itemCount: productController.allProducts.length + 1,
        itemBuilder: (context, index) {
          if (index < productController.allProducts.length) {
            final data = productController.allProducts[index];

            return ProductTile(

              data: data,
              onTap: () {
                Get.toNamed(RouteName.productDetailsScreen,
                    arguments: data.id.toString());
              },
            );
          } else if (index == productController.allProducts.length) {
            return Obx(() {
              if (productController.currentPage < productController.lastPage!) {
                return Center(
                  child: CustomProgressIndicator(strokeWidth: 1),
                );
              } else {
                return SizedBox.shrink();
              }
            });
          }
        });
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
              flex: 2,
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
              flex: 4,
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

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Remove the listener when the widget is disposed
    scrollController.removeListener(pagination);
    super.dispose();
  }

  void pagination() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (productController.currentPage.value == productController.lastPage) {
        return;
      }
      productController.currentPage.value += 1;
      productController.getAllProductsByCategory(productController.currentPage,
          category['endPoint'], category['category']);
      print('CURRENT PAGE ${productController.currentPage.value}');
    }
  }

}
