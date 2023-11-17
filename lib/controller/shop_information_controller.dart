

import 'dart:convert';

import 'package:get/get.dart';
import 'package:what_shop/models/shop_information_model.dart';
import 'package:what_shop/utils/api_services.dart';

class ShopInformationController extends GetxController{
 String shopId;
  ShopInformationController({required this.shopId});

  Rx<ShopInformationResponse?>  shopInformation = Rx<ShopInformationResponse?>(null);

  void onInit(){
    super.onInit();
    getShopInformation();
  }

 Future <void> getShopInformation()async{

   try{
     final response = await ApiService().post(endPoint:'shopdetails',body: {
       'shopid':shopId,
     } );

     if(response == null){
       return ;
     }
     if(response.statusCode == 200){
       Map<String,dynamic> jsonData = jsonDecode(response.body);
       shopInformation.value = ShopInformationResponse.fromJson(jsonData);
     }

   }catch(e){
     print(e.toString());
   }

 }



}