import 'dart:convert';

import 'package:get/get.dart';
import 'package:what_shop/models/order_details_model.dart';
import 'package:what_shop/utils/api_services.dart';
import 'package:what_shop/utils/api_state_enum.dart';

class OrderDetailsController extends GetxController {
  var orderDataFetchingState = DataState.Loading.obs;
  RxString errorMsg = ''.obs;

  Rx<OrderDetailsResponse?> orderDetailsResponse =
      Rx<OrderDetailsResponse?>(null);

  Future<void> getOrderDetails({orderId}) async {
    errorMsg.value = '';
    try {
     orderDataFetchingState.value = DataState.Loading;
      print('api called');
      final response = await ApiService().post(endPoint: 'order/${orderId.toString()}');
      if (response == null) {
        return;
      }
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData['orderDetails'] == null) {
          return;
        }
        orderDetailsResponse.value = OrderDetailsResponse.fromJson(jsonData);

        if(orderDetailsResponse.value?.orderDetails.orderItems.length != 0){
          orderDataFetchingState.value = DataState.Data;
        }else{
        orderDataFetchingState.value = DataState.Empty;

      }
      }
    } catch (e) {
      print(e.toString());
      orderDataFetchingState.value = DataState.Error;
      errorMsg.value = e.toString();
    }
  }
}
