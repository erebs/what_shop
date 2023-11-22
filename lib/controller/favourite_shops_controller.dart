import 'dart:convert';

import 'package:get/get.dart';
import 'package:what_shop/controller/shop_information_controller.dart';
import 'package:what_shop/models/favourite_shop_model.dart';
import 'package:what_shop/utils/api_services.dart';
import 'package:what_shop/utils/api_state_enum.dart';
import 'package:what_shop/utils/shared_pref_util.dart';
import 'package:what_shop/views/screens/widget/custom_snackbar.dart';

class FavouriteShopsController extends GetxController {

  void onInit(){
    super.onInit();
    getFavouriteShops();
  }
  Rx<FavouriteShop?> favouriteShops = Rx<FavouriteShop?>(null);
  var favouriteShopState = DataState.None.obs;
  Future getFavouriteShops() async {
    try {
      final userId = await SharedPrefUtil().getUserId();
      final response =
      await ApiService().post(endPoint: 'favourites', body: {
        'user_id':userId.toString(),
      });
      if (response == null) {
        return;
      }
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData['sts'] == '01') {
       favouriteShops.value = FavouriteShop.fromJson(jsonData);
       print(' from favorite shops Contrller ${favouriteShops.value?.fav}');

       if(favouriteShops.value?.fav == null){
           favouriteShopState.value = DataState.Empty;
           return;
         }
         if(favouriteShops.value!.fav.isEmpty){
           favouriteShopState.value = DataState.Empty;
           return;
         }
         if(favouriteShops.value!.fav.isNotEmpty){
           favouriteShopState.value = DataState.Data;
           return;
         }
        }
      }
    } catch (e) {
      favouriteShopState.value = DataState.Empty;
      print(e.toString());
    }
  }
}
