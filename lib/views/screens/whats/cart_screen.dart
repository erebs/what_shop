import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:what_shop/constants/appSizes.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_images.dart';
import 'package:what_shop/constants/app_variables.dart';
import 'package:what_shop/controller/address_controller.dart';
import 'package:what_shop/controller/cart_controller.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/views/screens/common/error_page.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/screens/widget/secondary_custom_app_bar.dart';
import 'package:what_shop/views/widgets/buttons.dart';
import 'package:what_shop/views/widgets/inputs.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartItemsController cartItemsController =
      Get.put(CartItemsController());
  RxString selectedPayment = 'CoD'.obs;
  final shopId = Get.arguments;
  final AddressController addressController = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.inputBackgroundColor,
        appBar: SecondaryCustomAppBar(title: 'Cart'),
        body: SingleChildScrollView(
          child: Container(
              color: AppColors.inputBackgroundColor,
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: 16),
              child: Obx(() {
                if (cartItemsController.isLoading.value) {
                  return Container(
                      height: Get.height,
                      child: Center(
                          child: CircularProgressIndicator(
                        color: AppColors.primary,
                      )));
                }
                if (cartItemsController.errorMsg.isNotEmpty) {
                  return ErrorScreen(
                    errorMsg: cartItemsController.errorMsg.value,
                    onTap: () {
                      cartItemsController.reloadGetCartItems();
                    },
                    img: AppImages.errorImg,
                  );
                }
                if (cartItemsController.cartItems.value?.cart == null ||
                    cartItemsController.cartItems.value!.cart!.isEmpty) {
                  return ErrorScreen(
                    errorMsg: 'Your cart is empty',
                    onTap: () {
                      Get.offAllNamed(RouteName.homeScreen);
                    },
                    buttonText: 'Continue shopping',
                    img: AppImages.noCartItems,
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cartItems(),
                    headerText(heading: 'Bill Details'),
                    billDetails(),
                    headerText(heading: 'Optional Promo Code'),
                    applyCoupon(),
                    headerText(heading: 'Payment Options'),
                    paymentOptions(),
                    Obx(
                      () => addressController.addresses.isEmpty
                          ? const SizedBox.shrink()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                headerText(heading: 'Delivery Address'),
                                SizedBox(height: 5),
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColors.fontOnSecondary,
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 24),
                                    child: addressList()),
                              ],
                            ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    addAddressButton(),
                    SizedBox(
                      height: 27,
                    ),
                    buyNowButton(),
                  ],
                );
              })),
        ),
      ),
    );
  }

  // cart items
  Widget cartItems() {
    return Obx(() => Column(
          children: [
            ...cartItemsController.cartItems.value?.cart?.map((data) {
                  return cartCard(
                      image: data.image,
                      netWeight: data.unitname,
                      offerPrice: data.unitofferprice,
                      price: data.unitprice,
                      productName: data.productname,
                      quantity: data.quantity,
                      cartId: data.id,
                      deliveryCharge: data.deliveryCharge,
                      gst: data.tax);
                }).toList() ??
                [],
          ],
        ));
  }

  // cart card widget
  Widget cartCard(
      {netWeight,
      quantity,
      productName,
      price,
      offerPrice,
      cartId,
      image,
      deliveryCharge,
      gst}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.fontOnSecondary,
      ),
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 13),
      margin: EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          productImage(image: image),
          SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                productNamePrice(
                    productName: productName,
                    price: price,
                    offerPrice: offerPrice),
                PrimaryText(text: 'Gst : ₹$gst'),
                PrimaryText(text: 'Delivery Charge : ₹$deliveryCharge'),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    counterButton(
                        quantity: quantity.toString(), cartId: cartId),
                    SizedBox(width: 12),
                    deleteButton(cartId: cartId),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 18),
          Expanded(
              child: PrimaryText(
            text: netWeight ?? '',
            color: AppColors.primary,
            alignment: TextAlign.right,
          )),
        ],
      ),
    );
  }

  Widget productNamePrice({productName, price, offerPrice}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(productName ?? '', style: TextStyle(fontSize: 12), maxLines: 2),
        SizedBox(height: 7),
        Row(
          children: [
            PrimaryText(
                text: '₹$offerPrice',
                fontSize: 12,
                fontWeight: FontWeight.w500),
            SizedBox(width: 3),
            Text('₹$price ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  decorationThickness: 2,
                  color: AppColors.mediumLight,
                  fontSize: 11,
                )),
          ],
        ),
        SizedBox(height: 7),
      ],
    );
  }

  Widget productImage({required image}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: AppColors.lightGrey)),
      width: 72,
      height: 75,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(AppVariables.baseUrl + image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Center(
                  child: PrimaryText(text: 'No image', fontSize: 8),
                )),
      ),
    );
  }

  // cart item increment decrement button
  Widget counterButton({quantity, cartId}) {
    return Container(
      height: 25,
      width: 60,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGrey),
          borderRadius: BorderRadius.circular(6)),
      child: Row(
        children: [
          Expanded(
              child: TouchableOpacity(
                  onTap: () {
                    cartItemsController.decrementQuantity(
                        quantity: int.parse(quantity) - 1, cartId: cartId);
                  },
                  child: Container(
                    height: double.maxFinite,
                    child: Icon(Remix.subtract_fill,
                        size: 14, color: AppColors.primary),
                  ))),
          Expanded(
              child: PrimaryText(
                  text: quantity ?? '',
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary)),
          Expanded(
              child: TouchableOpacity(
                  onTap: () {
                    cartItemsController.incrementQuantity(
                        quantity: int.parse(quantity) + 1, cartId: cartId);
                  },
                  child: Container(
                    height: double.maxFinite,
                    child: Icon(Remix.add_fill,
                        size: 14, color: AppColors.primary),
                  ))),
        ],
      ),
    );
  }

  // delete button
  Widget deleteButton({required cartId}) {
    return SecondaryButton(
      buttonText: 'Delete',
      onTap: () {
        cartItemsController.removeItem(cartId: cartId, context: context);
      },
      height: 25,
      width: 55,
      borderRadius: 6,
      borderColor: AppColors.lightGrey,
      fontColor: AppColors.mediumLight,
      backgroundColor: AppColors.fontOnSecondary,
    );
  }

  Widget billDetails() {
    return Container(
        padding: EdgeInsets.all(15),
        constraints: BoxConstraints(
          minHeight: 160,
          // maxHeight: 120,
        ),
        decoration: BoxDecoration(
            color: AppColors.fontOnSecondary,
            borderRadius: BorderRadius.circular(12)),
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              billDetailRow(
                  'Item Total',
                  cartItemsController.cartSum.value?.sumTotal.toString() ??
                      '...'),
              billDetailRow(
                  'Product Delivery Charge',
                  cartItemsController.cartSum.value?.productDeliveryCharge
                          .toString() ??
                      '...'),
              billDetailRow(
                  'Delivery Charge',
                  cartItemsController.cartSum.value?.deliveryCharge
                          .toString() ??
                      '...'),
              billDetailRow(
                  'Tax',
                  cartItemsController.cartSum.value?.totalTax.toString() ??
                      '...'),
              cartItemsController.isCouponAdded.value
                  ? billDetailRow(
                      'Coupon applied',
                      cartItemsController.couponData.value?.discount
                              .toString() ??
                          '...')
                  : SizedBox.shrink(),
              Divider(
                height: 0,
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
              billDetailRow(
                  'Total Amount', cartItemsController.total.value.toString()),
            ],
          ),
        ));
  }

  //widget that display payment option
  Widget paymentOptions() {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.fontOnSecondary,
            borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        margin: EdgeInsets.only(top: 2, bottom: 19),
        height: 89,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PrimaryText(
                      text: 'Would you like to pay online',
                      fontSize: 12,
                    ),
                    Transform.scale(
                      scale: .8,
                      child: Radio(
                          value: 'online',
                          groupValue: selectedPayment.value,
                          onChanged: (value) {
                            selectedPayment.value = value!;
                          }),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(
              () => Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PrimaryText(
                      text: 'Would you like to pay cash on delivery',
                      fontSize: 12,
                    ),
                    Transform.scale(
                      scale: .8,
                      child: Radio(
                          value: 'CoD',
                          groupValue: selectedPayment.value,
                          onChanged: (value) {
                            selectedPayment.value = value!;
                          }),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(
              () => Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PrimaryText(
                      text: 'Would you like to pay on pick up',
                      fontSize: 12,
                    ),
                    Transform.scale(
                      scale: .8,
                      child: Radio(
                          value: 'Pick Up',
                          groupValue: selectedPayment.value,
                          onChanged: (value) {
                            selectedPayment.value = value!;
                          }),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  // color: AppColors.fontOnSecondary,
  // padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),

  Widget addressList() {
    return Container(
      color: AppColors.fontOnSecondary,
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 0),
      child: Column(
        children: List.generate(addressController.addresses.length, (index) {
          final data = addressController.addresses[index];
          return Column(
            children: [
              addressCard(
                address: data.address,
                type: data.type,
                name: data.name,
                pincode: data.pincode,
                district: data.district,
                city: data.city,
                number: data.mobile,
                defaultAddress: data.default_address,
                addressId: data.id,
              ),
              if (index < addressController.addresses.length - 1)
                Divider(
                  color: AppColors.inputBackgroundColor,
                ),
            ],
          );
        }),
      ),
    );
  }

  //address card
  Widget addressCard(
      {name,
      type,
      number,
      pincode,
      city,
      district,
      address,
      defaultAddress,
      addressId}) {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  PrimaryText(
                      text: name ?? '...',
                      fontSize: 11,
                      fontWeight: FontWeight.w500),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: AppColors.primary),
                      child: PrimaryText(
                        text: type ?? '...',
                        color: AppColors.fontOnSecondary,
                        fontSize: 8,
                      )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              PrimaryText(
                text: number ?? '...',
                color: AppColors.mediumLight,
              ),
              SizedBox(
                height: 1,
              ),
              PrimaryText(
                text: address ?? '...',
                color: AppColors.mediumLight,
              ),
              SizedBox(
                height: 1,
              ),
              PrimaryText(
                text: '$city, $district, $pincode' ?? '...',
                color: AppColors.mediumLight,
              ),
            ],
          ),
          Transform.scale(
              scale: .8,
              child: Radio(
                  value: defaultAddress,
                  groupValue: addressController.defaultAddress.value,
                  onChanged: (val) {
                    addressController.setDefaultAddress(addressId: addressId);
                  })),
        ],
      ),
    );
  }

  // add new address button
  Widget addAddressButton() {
    return TouchableOpacity(
        onTap: () {
          Get.toNamed(RouteName.addAddressScreen);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: AppColors.fontOnSecondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimaryText(
                text: 'Add new address',
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              IconButton(
                  onPressed: () {
                    Get.toNamed(RouteName.addAddressScreen);
                  },
                  icon: Icon(
                    Remix.add_circle_line,
                    size: 18,
                  ))
            ],
          ),
        ));
  }

  // buy now button
  Widget buyNowButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SecondaryButton(
        buttonText: 'Buy Now',
        onTap: () {
          cartItemsController.buyNow(
            context: context,
            shopId: shopId,
            addressId: addressController.defaultAddress.toString(),
            type: selectedPayment.value,
          );
        },
        backgroundColor: AppColors.primaryDark,
        fontColor: AppColors.fontOnSecondary,
        height: 50,
        borderRadius: 12,
      ),
    );
  }

  Widget billDetailRow(String title, String price) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: PrimaryText(
            text: title.toString(),
            fontSize: 12,
            alignment: TextAlign.start,
          )),
          Expanded(
            child: PrimaryText(
              text: '₹ ${price.toString()}',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              alignment: TextAlign.end,
            ),
          )
        ],
      ),
    );
  }

  Widget applyCoupon() {
    return Container(
      height: 50,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: CustomTextField(
              hintText: 'Coupon code',
              controller: cartItemsController.couponController,
              borderColor: AppColors.lightGrey,
              bgColor: AppColors.fontOnSecondary,
              borderRadius: 15,
              borderWidth: 1,
              height: 10,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
              child: SecondaryButton(
            isLoading: cartItemsController.isApplyingCouponLoading.value,
            buttonText: 'Apply',
            onTap: () {
              cartItemsController.applyCoupon(shopId: shopId, context: context);
            },
            borderColor: AppColors.inputBackgroundColor,
            borderRadius: 15,
            backgroundColor: AppColors.primaryDark,
            fontColor: AppColors.fontOnSecondary,
          ))
        ],
      ),
    );
  }

  Widget headerText({
    required String heading,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 19, bottom: 7),
      child:
          PrimaryText(text: heading, fontWeight: FontWeight.w500, fontSize: 14),
    );
  }
}
