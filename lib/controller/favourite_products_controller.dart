


import 'dart:convert';

import 'package:get/get.dart';
import 'package:what_shop/models/favourite_product_model.dart';
import 'package:what_shop/utils/api_services.dart';
import 'package:what_shop/utils/shared_pref_util.dart';

class FavouriteProductsController extends GetxController{

void onInit(){
  super.onInit();
  getFavouriteProducts();
}
  //================================
  Rx<FavoriteProductModel?> favouriteProducts =  Rx<FavoriteProductModel?>(null);
//  =======================================================================================================================================================
Future<void> getFavouriteProducts ()async{
  try{
    final userId = await SharedPrefUtil().getUserId();
    final shopId = await SharedPrefUtil().getShopId();
    //========================================================================================================================================
    final response = await ApiService().post(endPoint: 'favourite-products',body: {
      'user_id':userId.toString(),
      'shop_id':shopId.toString()
    });
  //=========================================================================================================================
    if(response == null){
      return;
    }
    if(response.statusCode == 200){
      Map<String,dynamic> jsonData = jsonDecode(response.body);
      if(jsonData['sts'] == '01'){
        favouriteProducts.value = FavoriteProductModel.fromJson(jsonData);
        print(favouriteProducts.value);
      }
    }
    // ======================================================================================================
  }catch(e){
    print(e.toString());
  }
}
}