import 'dart:convert';

import 'package:get/get.dart';
import 'package:what_shop/controller/favourite_shops_controller.dart';
import 'package:what_shop/controller/shop_information_controller.dart';
import 'package:what_shop/utils/api_services.dart';
import 'package:what_shop/utils/shared_pref_util.dart';
import 'package:what_shop/views/screens/widget/custom_snackbar.dart';

class AddFavouriteShopController extends GetxController {
  final ShopInformationController shopInformationController = Get.find();
  final FavouriteShopsController favouriteShopsController = Get.find();
  Future addToFavouriteShops({required context}) async {
    try {
      final userId = await SharedPrefUtil().getUserId();
      final shopId =await SharedPrefUtil().getShopId();

      final response =
          await ApiService().post(endPoint: 'add-favourite', body: {
        'user_id':userId.toString(),
        'shop_id': shopId.toString(),
      });
      if (response == null) {
        return;
      }
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData['sts'] == '01') {
          shopInformationController.getShopInformation();
          customBottomSnakbar(context: context, text: jsonData['msg']);
          favouriteShopsController.getFavouriteShops();
        } else {
          customBottomSnakbar(
              context: context, text: 'something went wrong please try again');
        }
      }
    } catch (e) {
      customBottomSnakbar(
          context: context, text: 'something went wrong please try again');
      print(e.toString());
    }
  }
}
