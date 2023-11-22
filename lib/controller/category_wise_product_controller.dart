import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_shop/models/category_wise_products_model.dart';
import 'package:what_shop/utils/api_services.dart';
import 'package:what_shop/utils/api_state_enum.dart';

class CategoryWiseProductController extends GetxController {
  final String catId;
  final RxInt pageNumber = 1.obs;
  final ScrollController scrollController = ScrollController();
  final Rx<CategoryWiseProductModel?> categoryProductResponse = Rx<CategoryWiseProductModel?>(null);
  final Rx<DataState> categoryWiseProductState = DataState.Loading.obs;
  final List<dynamic> categoryProducts = [].obs;
  int? lastPage;

  CategoryWiseProductController({required this.catId});

  @override
  void onInit() {
    super.onInit();
    getCategoryWiseProducts();
    pagination();
    ever(pageNumber, (callback) => pageNumber.value > lastPage! ? null : getCategoryWiseProducts());
  }

  Future<void> getCategoryWiseProducts() async {
    try {
      final response = await ApiService().post(
        endPoint: 'categorywise_products?page=${pageNumber.value}',
        body: {'catid': catId},
      );

      if (response == null || response.statusCode != 200) {
        categoryWiseProductState.value = DataState.Error;
        print('Error: Unable to fetch data');
        return;
      }

      Map<String, dynamic> jsonData = jsonDecode(response.body);
      print('Response Body: $jsonData');

      if (jsonData['sts'] == '01') {
        categoryProductResponse.value = CategoryWiseProductModel.fromJson(jsonData);

        if (jsonData['products']['data'] != null &&
            jsonData['products']['data'] != null) {
          categoryProducts.addAll((jsonData['products']['data'] as List)
              .map((item) => Data.fromJson(item))
              .toList());

          // lastPage =categoryProductResponse.value?.products?.lastPage ?? 1;
lastPage = jsonData['products']['last_page'];
          categoryWiseProductState.value =
          categoryProducts.isNotEmpty ? DataState.Data : DataState.Empty;

          print('Fetched data successfully: ${categoryProducts[1].image}');
        }
      } else {
        print('Error: Status is not 01');
      }
    } catch (e) {
      categoryWiseProductState.value = DataState.Error;
      print('Error: $e');
    }
  }

  void pagination() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (pageNumber.value == lastPage) {
          return;
        }
        pageNumber.value++;
        print('Loading more data, page: ${pageNumber.value}');
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    pageNumber.value = 1;
    categoryProducts.clear();
    print('Controller closed');
  }
}
