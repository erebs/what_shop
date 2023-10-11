import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_shop/controller/all_shops_controller.dart';
import 'package:what_shop/models/all_shops_model.dart';


class SearchScreenController extends GetxController{
  TextEditingController searchText = TextEditingController();
  final AllShopsController allShopsController = Get.find();
  var filteredShops = <Shop>[].obs;


    void getFilteredShop(){
      print('called');

      if (allShopsController.allShops.value != null) {
        List<Shop> shops = allShopsController.allShops.value!.shops;
        String query = searchText.text.trim().toLowerCase().removeAllWhitespace;

        // Ensure that the category_name is not null before checking its contents.
        filteredShops.value = shops.where((shop) => shop.category_name?.trim().toLowerCase().contains(query) ?? false).toList();
        print(filteredShops.value);
      }

}}