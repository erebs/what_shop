


import 'dart:convert';

import 'package:get/get.dart';
import 'package:what_shop/models/user_data_model.dart';
import 'package:what_shop/utils/api_services.dart';
import 'package:what_shop/utils/shared_pref_util.dart';

class UserDataController extends GetxController {

  void onInit(){
    super.onInit();
    getUserData();
  }

  Rx<UserDataModel?> userData = Rx<UserDataModel?>(null);


  Future<void> getUserData() async {
    try {
      final userId = await SharedPrefUtil().getUserId();
      final response = await ApiService().post(

          endPoint: 'customer-details',
          body: {'user_id': userId.toString()});
      if (response?.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response!.body);
        if (jsonData['sts'] == '01') {
          userData.value = UserDataModel.fromJson(jsonData);
          print(' from user data controller $jsonData');
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}