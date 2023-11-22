import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:what_shop/controller/home_screen_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:what_shop/utils/api_services.dart';
import 'package:what_shop/utils/shared_pref_util.dart';

class HomeController extends GetxController {
  final homeScreenController = Get.put(HomeScreenController());
  TextEditingController pinCodeController = TextEditingController();
  final RxMap<dynamic, dynamic> userDetails = {}.obs;
  void onInit() async{
    super.onInit();
    await getUserData();
    getHomeData();
  }
  RxString? locality = ''.obs;
  String? pinCode;
  Position? location ;



  Future<void> getHomeData() async {
   homeScreenController.isLoading.value = true;
   homeScreenController.errorMessage.value = '';
   pinCodeController.clear();
    // checking if user device location is turned on or not
    if (await Permission.location.serviceStatus.isEnabled) {
      await getShops();
    }
    else {
      var deviceLocationAccess = await loc.Location().requestService();

      // if device location is turned on
      if (deviceLocationAccess == true) {

        await getShops();

      }
      // if device location is turned off
      else {
        // homeScreenController.isLocationGranted.value = false;

        // ''' (do an api call for getting all shops)'''
        homeScreenController.getAllShops();
      }
    }
  }

  // checking if location access given for app
  Future<void> getShops() async {

    if (await Permission.location.status.isGranted) {
      homeScreenController.isLocationGranted.value = true;
      var currentLocation = await  _getLatitudeAndLongitude();
      await getAddress(lat: currentLocation!.latitude, long: currentLocation.longitude);
      await homeScreenController.getShopsFromPincode(pincode: '686507');


    }
    else if (await Permission.location.status.isDenied) {
      // asking for location permission access
      var status = await Permission.location.request();

      if (status.isGranted) {
        homeScreenController.isLocationGranted.value = true;
        var currentLocation = await  _getLatitudeAndLongitude();
        await getAddress(lat: currentLocation?.latitude, long: currentLocation?.longitude);
        await homeScreenController.getShopsFromPincode(pincode: '686507');
        // 686507
      }
      else if (status.isDenied) {
        homeScreenController.isLocationGranted.value = false;
        // do an api call for getting all shops
        homeScreenController.getAllShops();

      }
    }
  }

  // function to get latitude and longitude
  Future<Position?> _getLatitudeAndLongitude() async {
    try {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

    } catch (e) {
      print(e.toString());
      Get.snackbar('', e.toString());
      return null;  // Explicitly return null in case of error.
    }
  }

//   function to get user address
  Future<String?> getAddress({lat, long})async{
    try{
      List<Placemark> placemarks = await placemarkFromCoordinates(lat,long);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        pinCode = place.postalCode;
        locality!.value='${place.locality}, ${place.administrativeArea}';
        print(placemarks);
      }
      return null;
    }catch(e){
      e.toString();
      return null;
    }
  }

  Future<void> getUserData() async {
    Map<String, String?> fetchedData = await SharedPrefUtil().getUserData();
    userDetails.value = fetchedData;
    print(userDetails);
  }



}



