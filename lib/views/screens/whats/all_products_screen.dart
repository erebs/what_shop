import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_shop/controller/shop_data_controller.dart';
import 'package:what_shop/utils/api_state_enum.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/views/screens/common/error_page.dart';
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

    productController.getAllProductsByCategory(
        productController.currentPage, category['endPoint'],category['category']);
    scrollController.addListener(pagination);

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SecondaryCustomAppBar(
          title: category['screen_name'],
          onTap: () {
            productController.allProducts= [];
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

            }if(productController.allProductState.value == DataState.Error){
              return ErrorScreen(onTap: (){
                productController.getAllProductsByCategory(productController.currentPage, category['endPoint'],category['category']);
              },errorMsg: productController.errorMessage.value,);
            }

            return Column(
              children: [
                if (category['category'] == 'featuredproducts')
                  Expanded(
                    child: _buildProductGrid(
                        productController.allProductByCategory.value?.featuredproducts?.data),
                  ),
                if (category['category'] == 'trendingproducts')
                  Expanded(
                    child: _buildProductGrid(
                        productController.allProductByCategory.value?.trendingproducts?.data),
                  ),
                if (category['category'] == 'popularproducts')
                  Expanded(
                    child: _buildProductGrid(
                        productController.allProductByCategory.value?.popularproducts?.data),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
  Widget _buildProductGrid(List<dynamic>? productDataList) {
    return  ListView.builder(
        controller:scrollController,
        itemCount:productController.allProducts.length + 1,
        itemBuilder: (context,index){
      if(index < productController.allProducts.length){
        final data = productController.allProducts[index];
        return  ProductListTileCard(data:data,onTap:() {
          Get.toNamed(RouteName.productDetailsScreen,
              arguments: data.id.toString());
        },);
      }else if (index ==
          productController.allProducts.length) {
  return Obx((){
    if(productController.currentPage <
        productController.lastPage!){
      return Center(
        child: CustomProgressIndicator(strokeWidth: 1),
      );
    }else{
      return  SizedBox.shrink();

    }
  });
      }

    });

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
      productController.getAllProductsByCategory(
          productController.currentPage, category['endPoint'],
          category['category']);
      print('CURRENT PAGE ${productController.currentPage.value}');
    }
  }

}
