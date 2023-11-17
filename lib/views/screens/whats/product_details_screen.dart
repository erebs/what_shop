import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:what_shop/constants/appSizes.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_images.dart';
import 'package:what_shop/constants/app_variables.dart';
import 'package:what_shop/controller/add_to_cart_controller.dart';
import 'package:what_shop/controller/product_details_controller.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/screens/widget/secondary_custom_app_bar.dart';
import 'package:what_shop/views/widgets/buttons.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late final ProductDetailsController productDetailsController;
  final addToCartController = Get.put(AddToCartController());
  String productId = Get.arguments;
  RxInt _selectedIndex = 0.obs;

  void initState() {
    super.initState();
    print(productId);
    productDetailsController =
        Get.put(ProductDetailsController(productId: productId,),permanent: false);
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SecondaryCustomAppBar(
          title: 'Product details',
          onTap: (){
            Get.delete<ProductDetailsController>();
            Get.back();
          },
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration:
                const BoxDecoration(color: AppColors.inputBackgroundColor),
            constraints:
                BoxConstraints(minHeight: Get.width, minWidth: Get.width),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                productName(),
                productImage(),
                productDetails(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // product name widget
  Widget productName() {
    return Obx(() => Container(
        padding: EdgeInsets.only(
            left: horizontalPadding, top: 15, bottom: 15, right: Get.width / 4),
        child: Text(
          // textScaleFactor: 1,
          productDetailsController.productDetails.value?.product.name ??'...',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 10),
          maxLines: 2,
        )));
  }

// product image display widget
  Widget productImage() {
    return Obx(() => Container(
          margin: EdgeInsets.only(bottom: 3),
          color: AppColors.fontOnSecondary,
          height: 222,
          width: Get.width,
          child: productDetailsController.productDetails.value?.product.image !=
                  null
              ? Image.network(
                  (AppVariables.baseUrl +
                      productDetailsController
                          .productDetails.value!.product.image),
                  errorBuilder: (context, error, stackTrace) =>
                      Center(child: Text('No image found')),
                )
              : Center(child: Text('....')),
        ));
  }

  Widget productPriceAndQty() {
    return Obx(() => Container(
          margin: EdgeInsets.only(bottom: 30),
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      PrimaryText(
                        text: 'MRP :   ₹',
                        fontSize: 12,
                      ),
                      Text(

                        ' ${productDetailsController.productDetails.value?.units[addToCartController.selectedIndex.value].price.toString()}' ??
                            '...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,

                            decorationColor: AppColors.primary,
                            fontSize: 12,
                            decorationThickness: 4),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  PrimaryText(
                    text:
                        '₹ ${productDetailsController.productDetails.value?.units[addToCartController.selectedIndex.value].offerprice.toString()}' ??
                            'NA',
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  PrimaryText(
                    text: productDetailsController.productDetails.value?.product.status ?? '',
                    color: AppColors.teal,
                    fontSize: 11,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      PrimaryText(text: 'Qty : '),
                      quantityButton(),
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }

  // quantity button


  Widget quantityButton() {
    return GetBuilder<AddToCartController>(builder: (addToCartController){
      return
        Builder(
          builder: (context) {
            return Container(
              height: 20,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(width: .5, color: AppColors.lightGrey),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Center(
                child: DropdownButtonHideUnderline(
                  // Add this to hide the underline
                  child: DropdownButton<String>(
                    menuMaxHeight: 200,
                    borderRadius: BorderRadius.circular(3),
                    hint: Text(addToCartController.quantity),
                    iconSize: 13,
                    value:  addToCartController.quantity,
                    onChanged: (newValue) {

                      addToCartController.updateQuantity(newValue!);

                    },
                    items: <String>[
                      '1',
                      '2',
                      '3',
                      '4',
                      '5',
                      '6',
                      '7',
                      '8',
                      '9',
                      '10'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text('$value', style: TextStyle(fontSize: 12)),
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        ) ;
    });

  }

  // add to cart button
  Widget addToCartButton({bool? isLoading}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SecondaryButton(
          borderRadius: 11,
          height: 40,
          fontColor: AppColors.fontOnSecondary,
          backgroundColor: AppColors.primary,
          buttonText: 'Add to cart',
          isLoading: isLoading,
          onTap: () {
            addToCartController.addToCart(productid: productDetailsController.productDetails.value?.product.id);
          }),
    );
  }

  // buy now button
  // Widget buyNowButton() {
  //   return SecondaryButton(
  //       borderRadius: 11,
  //       height: 40,
  //       fontColor: AppColors.fontOnSecondary,
  //       backgroundColor: AppColors.primaryDark,
  //       buttonText: 'Buy Now',
  //       onTap: () {});
  // }

  Widget productDetails() {
    return Container(
        margin: EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: 15),
        // height: 200,
        color: AppColors.fontOnSecondary,
        child: Column(
          children: [
            productPriceAndQty(),
            units(),
            productDiscription(),
           Obx(() =>addToCartButton(isLoading: addToCartController.isLoading.value) ) ,
          ],
        ));
  }

  // popular products
  Widget popularProducts() {
    return Container(
      margin: EdgeInsets.only(bottom: 4),
      height: 153,
      color: AppColors.fontOnSecondary,
    );
  }

  // trending products
  Widget trendingProduct() {
    return Container(
      margin: EdgeInsets.only(bottom: 4),
      height: 153,
      color: AppColors.fontOnSecondary,
    );
  }

  Widget productDiscription() {
    return Obx(() => Container(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                text: 'Description',
                fontSize: 16,
              ),
              SizedBox(
                height: 6,
              ),
              PrimaryText(
                text: productDetailsController
                        .productDetails.value?.product.desc ??
                    '...',
                fontSize: 11,
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }

  // this widget display all units
  Widget units() {
    return Obx(
        () {
          addToCartController.unitId= productDetailsController
              .productDetails.value != null ?
              productDetailsController
                  .productDetails.value!.units[0].id : 0 ;
          print(addToCartController.unitId);
          return productDetailsController.productDetails.value?.units != null
              ? Container(
            height: 40,
            // color: Colors.cyan,
            child: ListView.builder(
              itemCount: productDetailsController
                  .productDetails.value?.units.length,
              itemBuilder: (context, index) {

                return unitCard(
                    text: productDetailsController
                        .productDetails.value?.units[index].name,
                    index: index,
                    onTap: () {
                      addToCartController.selectedIndex.value = index;
                      addToCartController.unitId=
                          productDetailsController
                              .productDetails.value!.units[index].id;
                      print(addToCartController.unitId);
                    });
              },
              scrollDirection: Axis.horizontal,
            ),
          )
              : SizedBox.shrink();
        }
    );
  }

  // a widget for showing unit
  Widget unitCard({text, onTap, index}) {
    print("Selected Index: ${addToCartController.selectedIndex.value}, Current Index: $index");
    return Obx(() => TouchableOpacity(

          onTap: onTap,
          child: Container(
              constraints: BoxConstraints(
                minWidth: 50,
              ),
              margin: EdgeInsets.only(right: 4, bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                  color: addToCartController.selectedIndex.value == index
                      ? AppColors.lightGrey
                      : Colors.transparent,
                  border: Border.all(color: AppColors.mediumLight)),
              padding: EdgeInsets.all(2),
              child: Center(
                  child: PrimaryText(
                text: text,
              ))),
        ));
  }

}
