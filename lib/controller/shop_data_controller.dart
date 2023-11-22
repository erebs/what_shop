import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:what_shop/models/banner_model.dart';
import 'package:what_shop/models/category_model.dart';
import 'package:what_shop/models/product_model.dart';
import 'package:what_shop/models/shop_details_by_id_model.dart';
import 'package:what_shop/utils/api_services.dart';
import 'package:what_shop/utils/api_state_enum.dart';
import 'package:what_shop/utils/shared_pref_util.dart';

class ShopDataController extends GetxController {
  String shopId;

  ShopDataController({required this.shopId});

  Rx<ProductResponse?> featuredProducts = Rx<ProductResponse?>(null);
  Rx<ProductResponse?> trendingProducts = Rx<ProductResponse?>(null);
  Rx<ProductResponse?> popularProducts = Rx<ProductResponse?>(null);
  Rx<ProductResponse?> allProductByCategory = Rx<ProductResponse?>(null);
  Rx<CategoryResponse?> categoryResponse = Rx<CategoryResponse?>(null);

  RxInt currentPage = 1.obs;
  int? lastPage;

  var featuredProductState = DataState.Loading.obs;
  var trendingProductState = DataState.Loading.obs;
  var popularProductState = DataState.Loading.obs;
  var bannerState = DataState.Loading.obs;
  var allProductState = DataState.None.obs;
  var categoryResponseState = DataState.Loading.obs;
  RxBool isLoading = false.obs;
  RxBool isAllProductsLoading = false.obs;
  RxString errorMessage = ''.obs;
  var shopDetails = Rx<ShopDetailsByIdModel?>(null);
  var banner = Rx<BannerList?>(null);
  List<dynamic> allProducts = [].obs;
  Rx<Poster?> poster = Rx<Poster?>(null);

  @override
  void onInit() {
    super.onInit();
    // _getShopDetailsById();
    SharedPrefUtil().setShopId(shopId: shopId);
    _getBanners();
    getCategories();
    _getFeaturedProducts();
    _getTrendingProducts();
    _getPopularProducts();
    // getAllFeaturedProducts(pageNumber);
    // ever(pageNumber, (value) => _getAllFeaturedProducts(pageNumber));
  }

  Future<void> _getBanners() async {
    try {
      isLoading.value = true;

      final response = await ApiService().post(
        endPoint: 'shopbanners',
        body: {'shopid': shopId},
      );

      if (response!.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        if (jsonData['sts'] == '01') {
          banner.value = BannerList.fromJson(jsonData);
          poster.value = Poster.fromJson(jsonData['poster']);
          print(poster.value);

          // Check if there are banners and set the state accordingly
          bannerState.value = banner.value?.firstad?.isNotEmpty == true
              ? DataState.Data
              : DataState.Empty;
        } else {
          bannerState.value = DataState.Error;
        }
      }
    } catch (e) {
      bannerState.value = DataState.Error;
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void getCategories() async {
    try {
      isLoading.value = true;
      final shopIdfromdevice = await SharedPrefUtil().getShopId();
      print(' shop id from device$shopIdfromdevice');
      final response = await ApiService()
          .post(endPoint: 'shopcategories', body: {'shopid': shopId});
      if (response?.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response!.body);
        if (jsonData['sts'] == '01') {
          categoryResponse.value = CategoryResponse.fromJson(jsonData);
          if (categoryResponse.value!.categories.isNotEmpty) {
            categoryResponseState.value = DataState.Data;
          } else {
            categoryResponseState.value = DataState.Empty;
          }
          print('CATEGORY RESPONSE : ${categoryResponse.value?.categories}');
        } else {
          categoryResponseState.value = DataState.Error;
        }
      }
    } catch (e) {
      categoryResponseState.value = DataState.Error;
      print(e.toString());
    }
  }

  //---------------
  // featured product
  Future<void> _getFeaturedProducts() async {
    try {
      final String? userId = await SharedPrefUtil().getUserId();
      final response = await ApiService().post(
        endPoint: 'featured_products',
        body: {'shopid': shopId, 'userid': userId.toString()},
      );

      if (response!.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['sts'] == '01') {
          featuredProducts.value = ProductResponse.fromJson(jsonData);
          featuredProductState.value =
              featuredProducts.value?.featuredproducts?.data?.isNotEmpty == true
                  ? DataState.Data
                  : DataState.Empty;
        } else {
          featuredProductState.value = DataState.Error;
        }
      }
    } catch (e) {
      featuredProductState.value = DataState.Error;
      print(e.toString());
    }
  }

  // trending product
  Future<void> _getTrendingProducts() async {
    try {
      final response = await ApiService().post(
        endPoint: 'trending_products',
        body: {'shopid': shopId},
      );

      if (response!.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['sts'] == '01') {
          trendingProducts.value = ProductResponse.fromJson(jsonData);

          trendingProductState.value =
              trendingProducts.value?.trendingproducts?.data?.isNotEmpty == true
                  ? DataState.Data
                  : DataState.Empty;
        } else {
          trendingProductState.value = DataState.Error;
        }
      }
    } catch (e) {
      trendingProductState.value = DataState.Error;
      print(e.toString());
    }

    update();
  }

  // popular ptoduct
  Future<void> _getPopularProducts() async {
    try {
      final response = await ApiService().post(
        endPoint: 'popular_products',
        body: {'shopid': shopId},
      );

      if (response!.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['sts'] == '01') {
          popularProducts.value = ProductResponse.fromJson(jsonData);

          popularProductState.value =
              popularProducts.value?.popularproducts?.data?.isNotEmpty == true
                  ? DataState.Data
                  : DataState.Empty;
        } else {
          popularProductState.value = DataState.Error;
        }
      }
    } catch (e) {
      popularProductState.value = DataState.Error;
      print(e.toString());
    }
  }

//   this is a dynamic api calling though the name is allfeatured products i will change te name once i have enough tym for this
//  this is for fetching all products according featured,popular or trending
  Future<void> getAllProductsByCategory(
      pageNumber, endPoint, categoryName) async {
    try {
      if (allProducts.isEmpty) {
        isAllProductsLoading.value = true;
      }
      final String? userId = await SharedPrefUtil().getUserId();
      print('api called');
      final response = await ApiService().post(
          endPoint: '$endPoint?page=$pageNumber',
          body: {'shopid': shopId, 'userId': userId.toString()});
      if (response == null) {
        return;
      }
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['sts'] == '01') {
          allProductByCategory.value = ProductResponse.fromJson(jsonData);

          allProducts.addAll((jsonData[categoryName]['data'] as List)
              .map((item) => Product.fromJson(item))
              .toList());
          lastPage = jsonData[categoryName]['last_page'];

          if (allProductByCategory.value?.featuredproducts?.data?.isNotEmpty ==
              true) {
            allProductState.value = DataState.Data;
          }
        } else {
          allProductState.value = DataState.Error;
        }
      }
    } catch (e) {
      allProductState.value = DataState.Error;
      errorMessage.value = e.toString();
      print(e.toString());
    } finally {
      isAllProductsLoading.value = false;
    }
  }

//  increment pageNumber for pagination
//   bool incrementPage(category) {
//     switch (category) {
//       case 'featuredproducts':
//         {
//           pageNumber.value += 1;
//           if (pageNumber.value >
//               (allFeaturedProducts.value?.featuredproducts?.lastPage ?? 0)) {
//             pageNumber.value -= 1;
//             return false;
//           }
//
//           return true;
//         }
//       case 'trendingproducts':
//         {
//           pageNumber.value += 1;
//           if (pageNumber.value >
//               (allFeaturedProducts.value?.trendingproducts?.lastPage ?? 0)) {
//             pageNumber.value -= 1;
//             return false;
//           }
//           return true;
//         }
//       case 'popularproducts':
//         {
//           pageNumber.value += 1;
//
//           if (pageNumber.value >
//               (allFeaturedProducts.value?.popularproducts?.lastPage ?? 0)) {
//             pageNumber.value -= 1;
//             return false;
//           }
//           return true;
//         }
//       default:
//         return false;
//     }
//   }

//  decrement pageNumber for pagination

// bool decrementPage() {
//   if (pageNumber.value == 1) {
//     return false;
//   }
//   pageNumber.value -= 1;
//   return true;
// }
}
