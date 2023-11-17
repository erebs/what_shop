import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:what_shop/constants/appSizes.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/controller/product_search_controller.dart';
import 'package:what_shop/utils/api_state_enum.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/views/screens/common/error_page.dart';
import 'package:what_shop/views/screens/widget/app_bar.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/screens/widget/product_card.dart';
import 'package:what_shop/views/screens/widget/progress_indicator.dart';
import 'package:what_shop/views/screens/widget/secondary_custom_app_bar.dart';
import 'package:what_shop/views/widgets/inputs.dart';

class ProductSearchScreen extends StatefulWidget {
  ProductSearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  TextEditingController j = TextEditingController();
  final ProductSearchController productSearchController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding - 2, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            searchField(onChanged: (value) {
              //this is for clearing array when the search text is empty
              if (productSearchController.searchTextController.text.isEmpty) {
                productSearchController.searchProductResponse.clear();
                return;
              }
              productSearchController.searchTextLength.value += 1;
            }),
            SizedBox(height: 8,),
            infoText(),
            SizedBox(
              height: 40,
            ),
            Expanded(child: searchProductList())
          ],
        ),
      ),
    );
  }

//   search field

  Widget searchField({required onChanged}) {
    return Container(
      padding: EdgeInsets.only(right: 2),
      decoration: BoxDecoration(
          color: AppColors.inputBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.lightGrey,
          )),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: CustomTextField(
              onChanged: onChanged,
              hintText: 'Search products',
              controller: productSearchController.searchTextController,
              height: 15,
              containerHeight: 35,
              borderRadius: 10,
            ),
          ),
          Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(7)),
              child: Icon(
                Remix.search_2_line,
                size: 21,
              ))
        ],
      ),
    );
  }

  Widget searchProductList() {
    return Obx(() {
      if (productSearchController.searchProductState.value ==
          DataState.Loading) {
        return Center(
          child: CustomProgressIndicator(),
        );
      }
      if (productSearchController.searchProductState.value == DataState.Empty) {
        return noProductFoundScreen();
      }
      return GridView.builder(
          itemCount: productSearchController.searchProductResponse.value.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 15,
              childAspectRatio: 2 / 2.2),
          itemBuilder: (context, index) {
            final data =
                productSearchController.searchProductResponse[index];
            return ProductCard(
              onTouch: () {
                FocusScope.of(context).unfocus();
                Get.toNamed(RouteName.productDetailsScreen,
                    arguments: data.id.toString());
              } ,
              image: data.image,
              name: data.name,
            );
          });
    });
  }

  Widget noProductFoundScreen() {
    return Center(
      child: Container(
        child: PrimaryText(
          text: 'No product found',
          color: AppColors.mediumLight,
          fontSize: 15,
        ),
      ),
    );
  }
  Widget infoText(){
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: PrimaryText(text: 'Search products you are looking for.',color:AppColors.mediumLight,),
    );
  }
}
