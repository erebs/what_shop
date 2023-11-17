import 'dart:convert';

import 'package:get/get.dart';
import 'package:what_shop/models/product_details_model.dart';
import 'package:what_shop/utils/api_services.dart';



class ProductDetailsController extends GetxController {
  final String productId;

  ProductDetailsController({required this.productId});

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  var productDetails = Rx<ProductResponse?>(null);


  @override
  void onInit() {
    super.onInit();
    _getProductDetails(productId: productId);
  }

  Future<void> _getProductDetails({productId}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await ApiService().post(
          endPoint: 'product_details', body: {
        'product_id': productId
      });
      if (response!.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData['sts'] == '01') {
          productDetails.value = ProductResponse.fromJson(jsonData);
          print(productDetails.value?.units);
        }
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
void onClose(){

}
}