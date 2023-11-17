
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/widgets/buttons.dart';
import 'package:geocoding/geocoding.dart';
class LocationController extends GetxController {
  Rx<bool> isLocationGranted = false.obs;
  Position? location ;
  RxString? locality = ''.obs;
  String? pinCode;
  @override
  void onInit(){
    super.onInit();
    getPosition();
  }


  Future<void> getLocationPermission({BuildContext? context}) async {
    try {
      var permission = Permission.location;
      if (await permission.status.isDenied) {
        await permission.request();
      }
      await getLocationPermissionStatus();
      if (!isLocationGranted.value) {
        await showLocationDialogBox(context!);
      }else{
        try{
          await getPosition();
          if(location != null){
            await getAddress(location!.latitude, location!.longitude );
          }
        }catch(e){
          e.toString();
        }

        print(location);
      }
    } catch (e) {
      await showLocationDialogBox(context!);
      print(e.toString());
    }
  }



  Future<void> getLocationPermissionStatus() async {
    print('called');
    try {
      var permission = Permission.location;
      if (await permission.status.isGranted) {
        isLocationGranted.value = true;
      } else if (await permission.status.isDenied) {
        isLocationGranted.value = false;
      } else {
        isLocationGranted.value = false;
      }
    } catch (e) {
      e.toString();
    }
  }

  Future<Position?> getPosition() async {
    try {
      location = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(location);
      return location;
    } catch (e) {
      Get.snackbar('', e.toString());
    }
  }

  Future<String?> getAddress(lat,long)async{
    try{
      List<Placemark> placemarks = await placemarkFromCoordinates(lat,long);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        pinCode = place.postalCode;
        locality!.value='${place.locality}, ${place.administrativeArea}';
      }
      return null;
    }catch(e){
      e.toString();
      return null;
    }
  }

}




Future<void> showLocationDialogBox(BuildContext context) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: PrimaryText(text: 'Enable location access'),
          content: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            height: 40,
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryText(text: 'For the best experience, please enable'),
                SizedBox(
                  height: 5,
                ),
                PrimaryText(text: 'location services for this app.'),
              ],
            ),
          ),
          actions: [
            SecondaryButton(
                fontColor: AppColors.primary,
                borderColor: AppColors.primary,
                borderRadius: 8,
                width: 70,
                height: 30,
                buttonText: 'Cancel',
                onTap: () {
                  Get.back();
                }),
            SecondaryButton(
                fontColor: AppColors.inputBackgroundColor,
                borderColor: AppColors.primary,
                backgroundColor: AppColors.primary,
                borderRadius: 8,
                width: 75,
                height: 30,
                buttonText: 'Settings',
                onTap: () async {
                  await openAppSettings();
                  Get.back();
                })
          ],
        );
      });
}
