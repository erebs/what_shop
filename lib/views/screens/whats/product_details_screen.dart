import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:what_shop/constants/appSizes.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_images.dart';
import 'package:what_shop/constants/app_variables.dart';
import 'package:what_shop/controller/add_favourite_product_controller.dart';
import 'package:what_shop/controller/add_to_cart_controller.dart';
import 'package:what_shop/controller/product_details_controller.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/screens/widget/product_card.dart';
import 'package:what_shop/views/screens/widget/progress_indicator.dart';
import 'package:what_shop/views/screens/widget/secondary_custom_app_bar.dart';
import 'package:what_shop/views/screens/widget/shop_card.dart';
import 'package:what_shop/views/widgets/buttons.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late final ProductDetailsController productDetailsController;
  final addToCartController = Get.put(AddToCartController());
  final AddFavouriteProductController  addToFav = Get.put(AddFavouriteProductController());
  String productId = Get.arguments;
  RxInt _selectedIndex = 0.obs;

  void initState() {
    super.initState();
    print(productId);
    productDetailsController = Get.put(
        ProductDetailsController(
          productId: productId,
        ),
        permanent: false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SecondaryCustomAppBar(
          title: 'Product details',
          onTap: () {
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
                relatedProducts(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // product name widget
  Widget productName() {
    return Obx(() {

      final pDetails =
          productDetailsController.productDetailsResponse.value?.product;
      return Padding(
        padding: EdgeInsets.only(right: Get.width * .06, left: Get.width * .05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding: EdgeInsets.only(
                  top: 18,
                  bottom: 15,
                ),
                child: Text(
                  // textScaleFactor: 1,

                  pDetails?.name ?? '...',
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 10),
                  maxLines: 2,
                )),

          ],
        ),
      );
    });
  }

// product image display widget
  Widget productImage() {

    return Obx(() {
      final isFavourite =
          productDetailsController.productDetailsResponse.value?.isFavorite;
      final pDetails =
          productDetailsController.productDetailsResponse.value?.product;
      return Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 3),
            color: AppColors.fontOnSecondary,
            height: 222,
            width: Get.width,
            child: pDetails?.image != null
                ? Image.network(
                    (AppVariables.baseUrl + pDetails!.image),
                    errorBuilder: (context, error, stackTrace) =>
                        Center(child: Text('No image found')),
                  )
                : Center(child: Text('....')),
          ),
          Positioned(
              right: Get.width * 0.07,
              top: 15,
              child:  TouchableOpacity(
            onTap: (){
              addToFav.setFavouriteProduct(productId:pDetails!.id.toString(),context: context);
            },
            child: Icon(
              Remix.heart_fill,
              size: 25,
              color: isFavourite == true
                  ? Colors.pink.shade400
                  : AppColors.lightGrey,
            ),
          ))
        ],
      );
    });
  }

  Widget productPriceAndQty() {
    return Obx(() {
      final pDetails =
          productDetailsController.productDetailsResponse.value?.product;
      final units =
          productDetailsController.productDetailsResponse.value?.units;
      return Container(
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
                    const PrimaryText(
                      text: 'MRP :   ₹',
                      fontSize: 12,
                    ),
                    Text(
                      ' ${units?[addToCartController.selectedIndex.value].price.toString()}' ??
                          '...',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          decorationColor: AppColors.primary,
                          fontSize: 12,
                          decorationThickness: 4),
                    )
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                PrimaryText(
                  text:
                      '₹ ${units?[addToCartController.selectedIndex.value].offerprice.toString()}' ??
                          '...',
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
                  text: pDetails?.status ?? '',
                  color: AppColors.teal,
                  fontSize: 11,
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    const PrimaryText(text: 'Qty : '),
                    quantityButton(),
                  ],
                )
              ],
            )
          ],
        ),
      );
    });
  }

  // quantity button

  Widget quantityButton() {
    return GetBuilder<AddToCartController>(builder: (addToCartController) {
      return Builder(
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
                  value: addToCartController.quantity,
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
      );
    });
  }

  // add to cart button
  Widget addToCartButton({bool? isLoading}) {
    final pDetails =
        productDetailsController.productDetailsResponse.value?.product;

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
            addToCartController.addToCart(productid: pDetails?.id);
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
            Obx(() => addToCartButton(
                isLoading: addToCartController.isLoading.value)),
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

  Widget productDiscription() {
    return Obx(() {
      final pDetails =
          productDetailsController.productDetailsResponse.value?.product;
      return Container(
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
              text: pDetails?.desc ?? '...',
              fontSize: 11,
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      );
    });
  }

  // this widget display all units
  Widget units() {
    return Obx(() {
      final units =
          productDetailsController.productDetailsResponse.value?.units;
      addToCartController.unitId = units != null ? units[0].id : 0;
      print(addToCartController.unitId);
      return units != null
          ? Container(
              height: 40,
              // color: Colors.cyan,
              child: ListView.builder(
                itemCount: units.length,
                itemBuilder: (context, index) {
                  return unitCard(
                      text: units[index].name,
                      index: index,
                      onTap: () {
                        addToCartController.selectedIndex.value = index;
                        addToCartController.unitId = units[index].id;
                        print(addToCartController.unitId);
                      });
                },
                scrollDirection: Axis.horizontal,
              ),
            )
          : SizedBox.shrink();
    });
  }

  // a widget for showing unit
  Widget unitCard({text, onTap, index}) {
    print(
        "Selected Index: ${addToCartController.selectedIndex.value}, Current Index: $index");
    return Obx(() => TouchableOpacity(
          onTap: onTap,
          child: Container(
              constraints: const BoxConstraints(
                minWidth: 50,
              ),
              margin: const EdgeInsets.only(right: 4, bottom: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: addToCartController.selectedIndex.value == index
                      ? AppColors.lightGrey
                      : Colors.transparent,
                  border: Border.all(color: AppColors.mediumLight)),
              padding: const EdgeInsets.all(2),
              child: Center(
                  child: PrimaryText(
                text: text,
              ))),
        ));
  }

  Widget relatedProducts() {
    return Obx(() {
      final relProducts = productDetailsController
          .productDetailsResponse.value?.relatedProducts;

      if (relProducts?.length == 0) {
        return SizedBox.shrink();
      }
      return Container(
        height: Get.height * 0.25,
color: AppColors.fontOnSecondary,
        padding: EdgeInsets.only(top: 10,right: Get.width * .06, left: Get.width * .05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryText(text: 'Related Products',fontSize:12,),
            SizedBox(
              height: 10,
            ),
            Container(
              height: Get.height * 0.16,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: relProducts?.length,
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.only(right: 5),
                    child: ProductCard(
                          onTouch: () {
                            Get.delete<ProductDetailsController>();
                            Get.offAndToNamed(RouteName.productDetailsScreen, arguments: relProducts?[index].id.toString());

                            print('hello');
                          },
                          name: relProducts?[index].name,
                          image: relProducts?[index].image,
                        ),
                  )),
            )
          ],
        ),
      );
    });
  }
}
