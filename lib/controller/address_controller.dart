import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_shop/models/user_address_model.dart';
import 'package:what_shop/utils/api_services.dart';
import 'package:what_shop/utils/api_state_enum.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/utils/shared_pref_util.dart';
import 'package:what_shop/views/screens/whats/main_screen.dart';
import 'package:what_shop/views/screens/widget/custom_snackbar.dart';

class AddressController extends GetxController {
  void onInit() {
    super.onInit();
    _getUserAddress();
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController state = TextEditingController();
  RxString type = 'Home'.obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isDataFetched = false.obs;
  RxList<Address> addresses = <Address>[].obs;
  RxString defaultAddress = '1'.obs;
  RxString defaultAddressId = ''.obs;

  //Data state variable
  var addressState = DataState.Loading.obs;

  void getUserAddress() => _getUserAddress();

  void deleteUserAddress(int id) => _deleteUserAddress(id: id);

  // to get user address
  Future<void> _getUserAddress() async {
    errorMessage.value = '';
    try {
      isLoading.value = true;
      final userId = await SharedPrefUtil().getUserId();
      final response = await ApiService()
          .post(endPoint: 'address', body: {'user_id': userId.toString()});
      if (response!.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData['sts'] == '01') {
          addresses.value = AddressResponse.fromJson(jsonData).addresses;
          if (addresses.isEmpty) {
            addressState.value = DataState.Empty;
          } else {
            addressState.value = DataState.Data;
            // Taking address id for place order function
            var defaultAddressData =
                addresses.firstWhere((e) => e.default_address == '1');
            defaultAddressId.value = defaultAddressData.id.toString();
          }

          print(addresses);
        }
      }
    } catch (e) {
      errorMessage.value = e.toString();
      print('${e.toString()} from get user adress address controller');
    } finally {
      isLoading.value = false;
      isDataFetched.value = true;
    }
  }

  // to delete user address
  Future<void> _deleteUserAddress({required int id}) async {
    try {
      final response = await ApiService().post(endPoint: 'address/remove/$id');
      if (response!.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData['sts'] == '01') {
          addresses.removeWhere((element) => element.id == id);
          addresses.refresh();
          customSnackBar(title:'Successful',message: 'Address removed');

        }
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // to create user address
  Future<void> createUserAddress() async {
    if (name.text.isEmpty ||
        email.text.isEmpty ||
        mobile.text.isEmpty ||
        address.text.isEmpty ||
        landmark.text.isEmpty ||
        pincode.text.isEmpty ||
        city.text.isEmpty ||
        district.text.isEmpty ||
        state.text.isEmpty) {
      errorMessage.value = 'All fields required';
      return;
    }
    try {
      isLoading.value = true;
      final userId = await SharedPrefUtil().getUserId();
      if (userId != null || userId!.isNotEmpty) {
        final response =
            await ApiService().post(endPoint: 'address/create', body: {
          'user_id': userId.toString(),
          'name': name.text,
          'email': email.text,
          'mobile': mobile.text,
          'address': address.text,
          'landmark': landmark.text,
          'pincode': pincode.text,
          'city': city.text,
          'district': district.text,
          'state': state.text,
          'type': type.value,
        });
        if (response!.statusCode == 200) {
          final Map<String, dynamic> jsonData = jsonDecode(response.body);
          print(jsonData);
          if (jsonData['sts'] == '01') {
            print(jsonData);
            addresses.add(Address(
                id: 1,
                customerid: int.parse(userId),
                name: name.text,
                email: email.text,
                mobile: mobile.text,
                address: address.text,
                landmark: landmark.text,
                pincode: pincode.text,
                city: city.text,
                district: district.text,
                state: state.text,
                type: type.value,
                default_address: '0'));
            customSnackBar(title:'Successful',message: 'Address added');
            Get.offAndToNamed(RouteName.addressScreen);
          }
        }
      } else {
        return;
      }
    } catch (e) {
      customSnackBar(title:'Error',message: 'Something went wrong');

    } finally {
      isLoading.value = false;
      name.clear();
      email.clear();
      mobile.clear();
      address.clear();
      landmark.clear();
      pincode.clear();
      city.clear();
      district.clear();
      state.clear();
    }
  }

  // to Edit user address
  Future<void> updateUserAddress(
      {required addressId1,
      required name1,
      required email1,
      required mobile1,
      required address1,
      required landmark1,
      required pincode1,
      required city1,
      required district1,
      required state1,
      required type1}) async {
    if (name1.isEmpty ||
        email1.isEmpty ||
        mobile1.isEmpty ||
        address1.isEmpty ||
        landmark1.isEmpty ||
        pincode1.isEmpty ||
        city1.isEmpty ||
        district1.isEmpty ||
        state1.isEmpty) {
      errorMessage.value = 'All fields required';
      return;
    }
    try {
      isLoading.value = true;
      final userId = await SharedPrefUtil().getUserId();
      if (userId != null && userId.isNotEmpty) {
        final response = await ApiService()
            .post(endPoint: 'address/update/$addressId1', body: {
          'user_id': userId.toString(),
          'name': name1,
          'email': email1,
          'mobile': mobile1,
          'address': address1,
          'landmark': landmark1,
          'pincode': pincode1,
          'city': city1,
          'district': district1,
          'state': state1,
          'type': type1,
        });
        if (response!.statusCode == 200) {
          final Map<String, dynamic> jsonData = jsonDecode(response.body);
          if (jsonData['sts'] == '01') {
            Get.back();
            Address data = addresses
                .firstWhere((element) => element.id == int.parse(addressId1));
            data.name = name1;
            data.email = email1;
            data.mobile = mobile1;
            data.address = address1;
            data.landmark = landmark1;
            data.pincode = pincode1;
            data.city = city1;
            data.district = district1;
            data.state = state1;
            data.type = type1;
            addresses.refresh();
            customSnackBar(title:'Successful',message: 'Address Updated');

          }
        }
      } else {
        customSnackBar(title:'Error',message: 'Something went wrong');
        return;
      }
    } catch (e) {
      customSnackBar(title:'Error',message: 'Something went wrong');
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setDefaultAddress({required addressId}) async {
    try {
      final userId = await SharedPrefUtil().getUserId();
      if (userId != null && userId.isNotEmpty) {
        final response = await ApiService().post(
            endPoint: 'address/default',
            body: {
              'userid': userId.toString(),
              'addressid': addressId.toString()
            });

        if (response!.statusCode == 200) {
          print(response.body);
          final Map<String, dynamic> jsonData = jsonDecode(response.body);
          if (jsonData['sts'] == '01') {
            _getUserAddress();
            print(jsonData);
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
