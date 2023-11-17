import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_shop/models/category_wise_products_model.dart';
import 'package:what_shop/utils/api_services.dart';
import 'package:what_shop/utils/api_state_enum.dart';


class CategoryWiseProductController extends GetxController {
  String catId;

  CategoryWiseProductController({required this.catId});

  RxInt pageNumber = 1.obs;
  ScrollController scrollController = ScrollController();
  Rx<CategoryProductResponse?> categoryProductResponse =
      Rx<CategoryProductResponse?>(null);
  var categoryWiseProductState = DataState.Loading.obs;
  List<dynamic> categoryProducts = [].obs;

  //------------------------
  int? lastPage;

  //------------------------
  // onInit
  void onInit() {
    super.onInit();
    getCategoryWiseProducts();
    pagination();
    ever(
        pageNumber,
        (callback) =>
            pageNumber > lastPage! ? null : getCategoryWiseProducts());
  }

  Future<void> getCategoryWiseProducts() async {
    try {
      final response = await ApiService().post(
          endPoint: 'categorywise_products?page=${pageNumber}',
          body: {'catid': catId});
      // -----------------
      if (response == null) {
        return;
      }
      //-------------------------
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        //------------
        print(jsonData['products']);
        //  --------------
        if (jsonData['products']['data'] != null &&
            jsonData['products']['data'] != null) {
          categoryProducts.addAll((jsonData['products']['data'] as List)
              .map((item) => ProductItem.fromJson(item))
              .toList());
          lastPage = jsonData['products']['last_page'];
          if (categoryProducts.isNotEmpty) {
            categoryWiseProductState.value = DataState.Data;
          } else {
            categoryWiseProductState.value = DataState.Empty;
          }
          //-------------------
          print(categoryProducts);
        }
      }
    } catch (e) {
      categoryWiseProductState.value = DataState.Error;
    }
  }

  void pagination() {
    scrollController.addListener(
      () {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          if (pageNumber.value == lastPage) {
            return;
          }
          pageNumber++;
        }
      },
    );
  }

  void onClose() {
    super.onClose();
    pageNumber.value = 1;
    categoryProducts.clear();
  }
}
