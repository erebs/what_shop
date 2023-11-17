import 'dart:convert';

import 'package:get/get.dart';
import 'package:what_shop/models/order_model.dart';
import 'package:what_shop/utils/api_services.dart';
import 'package:what_shop/utils/api_state_enum.dart';
import 'package:what_shop/utils/shared_pref_util.dart';

class OrderHistoryController extends GetxController {
  void onInit(){
    super.onInit();
    getOrders();
  }

  var orderState = DataState.Loading.obs;
  RxString errorMessage = ''.obs;
  Rx<OrderResponse?>? orders = Rx<OrderResponse?>(null);

  Future<void> getOrders() async {
    try {
      final userId = await SharedPrefUtil().getUserId();
      if (userId != null) {
        final response = await ApiService()
            .post(endPoint: 'orders', body: {'user_id': userId.toString()});

        if( response?.statusCode == 200){
          final Map<String, dynamic> jsonData = jsonDecode(response!.body);
          if (jsonData['sts'] == '01'){
            orders!.value = OrderResponse.fromJson(jsonData);
            orderState.value = orders?.value?.orders?.isNotEmpty == true ? DataState.Data : DataState.Empty;
            print('orders${orders?.value?.orders}');
          }else{
            orderState.value = DataState.Error;
          }
        }else{
          orderState.value = DataState.Error;
        }

      } else {
        print('userId error on getting orders for order history screen');
        return;
      }


    } catch (e) {
      orderState.value = DataState.Error;
      errorMessage.value = e.toString();
      print(e.toString());
    }
  }
}
