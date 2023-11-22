import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:what_shop/controller/favourite_products_controller.dart';
import 'package:what_shop/controller/product_details_controller.dart';
import 'package:what_shop/utils/api_services.dart';
import 'package:what_shop/utils/shared_pref_util.dart';
import 'package:what_shop/views/screens/widget/custom_snackbar.dart';

class AddFavouriteProductController extends GetxController {
  Future<void> setFavouriteProduct(
      {required String productId, required context}) async {
    try {
      final userId = await SharedPrefUtil().getUserId();
      final shopId = await SharedPrefUtil().getShopId();
      //  response
      final response =
          await ApiService().post(endPoint: 'add-fav-product', body: {
        'user_id': userId.toString(),
        'shop_id': shopId.toString(),
        'product_id': productId.toString()
      });
      //  --------
      if (response == null) {
        return;
      }
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        //--------------
        if (jsonData['sts'] == '01') {
          final ProductDetailsController productDetailsController = Get.find();
          final FavouriteProductsController favouriteProductsController = Get.find();
          productDetailsController.getProductDetails(productId: productId);
          favouriteProductsController.getFavouriteProducts();
          customBottomSnakbar(context: context, text: jsonData['msg']);
        }
      }
      //----------
    } catch (e) {
      customBottomSnakbar(
          context: context, text: 'something went wrong please try again');

      print(e.toString());
    }
  }

}
