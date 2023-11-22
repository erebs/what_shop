import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:what_shop/models/product_search_model.dart';
import 'package:what_shop/utils/api_services.dart';
import 'package:what_shop/utils/api_state_enum.dart';

class ProductSearchController extends GetxController {
  final String shopId;

  ProductSearchController({required this.shopId});
  final searchTextLength = 1.obs;
  TextEditingController searchTextController = TextEditingController();
  RxList<SearchProduct> searchProductResponse = RxList<SearchProduct>([]);
  var searchProductState = DataState.None.obs;

  void onInit(){
    super.onInit();
    ever(searchTextLength, (callback) {
      searchProduct();
    }
    );
  }
  void searchProduct() async {
    try {
      searchProductState.value = DataState.Loading;

      final response = await ApiService().post(
          endPoint: 'search-product',
          body: {'name': searchTextController.text, 'shopid': shopId});
      if (response == null) {
        return;
      }
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        print(jsonData);
        if (jsonData['products'] == null) {
          return;
        }
        searchProductResponse.assignAll(
          List.from(jsonData['products'].map((item) => SearchProduct.fromJson(item))),
        );
        //------------
        print(searchProductResponse.value);
      //  ---------
        if(searchProductResponse.value.isEmpty){
          searchProductState.value = DataState.Empty;
        }else{
          searchProductState.value = DataState.Data;
        }
      }else{
        searchProductState.value = DataState.Error;
        print(response.body);
      }
    } catch (e) {
      searchProductState.value = DataState.Error;
      print(e.toString());
    }
  }
}
