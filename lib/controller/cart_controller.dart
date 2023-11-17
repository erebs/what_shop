import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_images.dart';
import 'package:what_shop/controller/address_controller.dart';
import 'package:what_shop/controller/cart_count_controller.dart';
import 'package:what_shop/models/cart_item_model.dart';
import 'package:what_shop/models/cart_sum_total_model.dart';
import 'package:what_shop/models/coupon_model.dart';
import 'package:what_shop/utils/api_services.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/utils/shared_pref_util.dart';
import 'package:what_shop/views/screens/common/error_page.dart';
import 'package:what_shop/views/screens/widget/custom_snackbar.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';

class CartItemsController extends GetxController {
  void onInit() {
    super.onInit();
    _getCartItems();
  }

  final CartCountController cartCountController = Get.find();
  final AddressController addressController = Get.put(AddressController());
  // variables--------------
  RxBool isLoading = false.obs;
  RxString errorMsg = ''.obs;
  RxDouble total = 0.0.obs;
  Rx<CartItemResponse?> cartItems = Rx<CartItemResponse?>(null);
  Rx<CartSumModel?> cartSum = Rx<CartSumModel?>(null);
  //------------------------------------
  // Coupon Variables-------------------
  Rx<CouponModel?> couponData = Rx<CouponModel?>(null);
  RxBool isApplyingCouponLoading = false.obs;
  TextEditingController couponController = TextEditingController();
  String couponCode = '';
  RxBool isCouponAdded = false.obs;
  RxString couponErrorMsg = ''.obs;
  //-----------------------------
  // buy now variable
  RxBool isBuyNowProccessing = false.obs;
  //-----------------
  // function to reload cart page
  void reloadGetCartItems() => _getCartItems();

  // function to get cart items
  Future<void> _getCartItems() async {
    try {
      isLoading.value = true;
      // clearing error msg value is for work reloading properly
      errorMsg.value = '';
      final userId = await SharedPrefUtil().getUserId();
      if (userId == null || userId.isEmpty) {
        return;
      }
      final response = await ApiService()
          .post(endPoint: 'getcart', body: {'userid': userId});
      if (response!.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData['sts'] == '01') {
          cartItems.value = CartItemResponse.fromJson(jsonData);
          print(jsonData);
          getCartTotal();
        }
      }
    } catch (e) {
      print(e.toString());
      errorMsg.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

// Function to increment  quantity

  Future<void> incrementQuantity({required quantity, required cartId}) async {
    try {
      final response = await ApiService().post(
          endPoint: 'changequantity',
          body: {'cartid': cartId.toString(), 'quantity': quantity.toString()});
      if (response!.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData['sts'] == '01') {
          _getCartItems();
          // int index = cartItems.value!.cart!.indexWhere((item) => item.id == cartId);
          // // Check if index is valid
          // if (index != -1) {
          //   // Update quantity
          //   cartItems.value!.cart![index].quantity += 1;
          //   cartItems.refresh();

          // }
        }
      }
    } catch (e) {
      print(e.toString());
      errorMsg.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

// Function to  decrement quantity

  Future<void> decrementQuantity({required quantity, required cartId}) async {
    try {
      if (quantity == 0) {
        return;
      }
      final response = await ApiService().post(
          endPoint: 'changequantity',
          body: {'cartid': cartId.toString(), 'quantity': quantity.toString()});
      if (response!.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData['sts'] == '01') {
          _getCartItems();
          // int index = cartItems.value!.cart!.indexWhere((item) => item.id == cartId);
          // Check if index is valid
          // if (index != -1 ) {
          //   // Update quantity
          //   cartItems.value!.cart![index].quantity -= 1;
          //   cartItems.refresh();

          // }
        }
      }
    } catch (e) {
      print(e.toString());
      errorMsg.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

// this function is to remove cart item
  Future<void> removeItem({required cartId,required context}) async {
    try {
      final response = await ApiService()
          .post(endPoint: 'removecart', body: {'cartid': cartId.toString()});
      if (response!.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData['sts'] == '01') {
          // await _getCartItems();
          cartCountController.getCartCount();
          cartCountController.cartCount.refresh();
          cartItems.value!.cart!.removeWhere((item) => item.id == cartId);
          // int index = cartItems.value!.cart!.indexWhere((item) => item.id == cartId);
          // cartItems.value?.cart?.removeAt(index);
          cartItems.refresh();
customBottomSnakbar(context: context, text:'Item removed');
        }
      }
    } catch (e) {
      print(e.toString());
      errorMsg.value = e.toString();
    } finally {

    }
  }

  Future<void> getCartTotal() async {
    try {
      final userId = await SharedPrefUtil().getUserId();
      final response = await ApiService().post(
          endPoint: 'getcartsumtotal', body: {'userid': userId.toString()});
      if (response?.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response!.body);
        if (jsonData['sts'] == '01') {
          total.value = 0;
          cartSum.value = CartSumModel.fromJson(jsonData);
          total.value = cartSum.value!.productDeliveryCharge +
              cartSum.value!.totalTax +
              cartSum.value!.deliveryCharge +
              cartSum.value!.sumTotal;
          print('${jsonData} from cart item controller cart sum ');
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> placeOrder() async {
    try {} catch (e) {
      print(e.toString());
    }
  }

// function to calculate price
// void calculateTotal(){
//   itemTotal.value = 0.0;
//   deliveryCharge.value = 0.0;
//   tax.value = 0.0;
//   total.value = 0.0;
//   cartItems.value?.cart?.forEach((element) {
//     itemTotal.value += element.unitofferprice * element.quantity;
//     tax.value += element.tax * element.quantity;
//     deliveryCharge.value += element.deliveryCharge;
//   });
//   total.value += itemTotal.value + tax.value + deliveryCharge.value;
// }

  Future<void> applyCoupon({required shopId, required context}) async {
    try {
      // close keyboard
      FocusScope.of(context).unfocus();
      // checking coupon is empty
      if (couponController.text.isEmpty) {
        return;
      }

      if (isCouponAdded.value) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: PrimaryText(
              text: 'Coupon already applied!',
              fontSize: 12,
            ),
            content: PrimaryText(
                text:
                    'Do you want to remove the coupon that has already been added?'),
            actions: [
              TextButton(
                child: PrimaryText(
                  text: 'No',
                  color: AppColors.primaryDark,
                  fontSize: 15,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pop(); // Close the dialog on "No" option
                },
              ),
              TextButton(
                child: PrimaryText(
                  text: 'Yes',
                  color: AppColors.primaryDark,
                  fontSize: 15,
                ),
                onPressed: () {
                  removeCoupon();
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );

        return;
      }

      isApplyingCouponLoading.value = true;
      final userId = await SharedPrefUtil().getUserId();
      final response =
          await ApiService().post(endPoint: 'apply-promocode', body: {
        'couponcode': couponController.text,
        'shopid': shopId.toString(),
        'customerid': userId.toString()
      });
      if (response?.statusCode == 200) {
        couponCode = couponController.text;
        Map<String, dynamic> jsonData = jsonDecode(response!.body);
        couponData.value = CouponModel.fromJson(jsonData);
        //  show message for user coupon applied
        // if(total.value < couponData.value!.discount){
        //   customBottomSnakbar(context: context, text:'Coupon cannot be applied');
        //   return;
        // }
        isCouponAdded.value = true;
        customBottomSnakbar(context: context, text:'Coupon applied');

        // calculate total after adding coupon
        addCoupon();
        //---------------------------
        print(' from 200${response?.body}');
        print(couponData.value?.name);
        print(couponCode);
        //  ----------------
      } else {
        print(' from not 200${response?.body}');
      }
    } catch (e) {
      customSnackBar(title:'Invalid Coupon',message:e.toString());
    } finally {
      couponController.clear();
      isApplyingCouponLoading.value = false;
    }
  }

//  calculate total after adding coupon
  void addCoupon() {
    total.value -= couponData.value!.discount;
    return;
  }

  void removeCoupon() {
    total.value += couponData.value!.discount;
    isCouponAdded.value = false;
    couponCode = '';
    couponData.value = null;
    return;
  }

  void buyNow(
      {required String shopId,
      required String addressId,
      required String type,context}) async {
    try {
      isBuyNowProccessing.value = true;

      if(addressController.addresses.value.isEmpty){
        customSnackBar(message: 'Please add an address');
        return;
      }
      showDialog(
        barrierDismissible: false,
        context: context, builder:(context) => AlertDialog(
        content: Container(
          height: 100,
          width: 100,
          child: Center(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                CircularProgressIndicator(),
                SizedBox(height: 30,),
                PrimaryText(text: 'Processing your request...\nPlease do not go back from this page.')
              ],
            ),
          ),
        ),
      ),);
      final userId = await SharedPrefUtil().getUserId();
      final response = await ApiService().post(endPoint: 'placeorder', body: {
        // here shopId , addressId and type is passing from cartSCreen
        'userid': userId.toString(),
        'shopid': shopId.toString(),
        'addressid':addressController.defaultAddressId.value.toString(),
        'promocode':  couponCode.toString() ?? '',
        'discount': couponData.value?.discount.toString() ?? '',
        'deliverycharge':cartSum.value?.deliveryCharge.toString() ?? '0',
        'type': type,
      });
      if(response?.statusCode == 200){
        Map<String,dynamic> jsonData = jsonDecode(response!.body);
        if (jsonData['sts'] == '01'){
          cartCountController.getCartCount();

          Get.offAllNamed(RouteName.placeOrderSuccessScreen);
          print(jsonData);
        }
        print(jsonData);
      }else{
        print(response?.body);
      }
    } catch (e) {
customSnackBar(message:'Something went wrong' ,title:'Error');
      print(e.toString());
Navigator.of(context).pop();
    }finally{
      isBuyNowProccessing.value = false;
    }
  }
}
