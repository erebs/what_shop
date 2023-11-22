import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/controller/home_screen_controller.dart';
import 'package:what_shop/controller/test_controller.dart';
import 'package:what_shop/controller/user_data_controller.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/utils/shared_pref_util.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final HomeController homeScreenController = Get.find();
  final UserDataController userDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fontOnSecondary,
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          child: Column(
            children: [
              userProfile(),
              SizedBox(height: 10,),
              listLink()
            ],
          ),
        ),
      ),
    );
  }
  // widget display user data
  Widget userProfile() {
    return Container(
      width: Get.width,
      height: 160,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColors.lightGrey,

            ),
            height: 80,
            width: 80,
            child: Icon(
              Remix.account_pin_circle_fill,
              color: AppColors.fontOnSecondary,
              size: 50,
            ),
          ),
          SizedBox(
            width: 14,
          ),
         Obx(()=>Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             PrimaryText(
               text: 'Hi',
               fontSize: 14,
               fontWeight: FontWeight.w500,
               color: AppColors.primary,
             ),
             PrimaryText(
               text:userDataController.userData.value?.details.name.toString() ?? '',
               fontSize: 14,
               fontWeight: FontWeight.w500,

             ),
             SizedBox(
               height: 3,
             ),
             PrimaryText(text: userDataController.userData.value?.details.email.toString() ?? ''),
             SizedBox(
               height: 2,
             ),
             PrimaryText(text:userDataController.userData.value?.details.phone.toString() ?? ''),
           ],
         ))
        ],
      ),
    );
  }

  Widget listLink() {
    return Container(
      padding: EdgeInsets.only(left:24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PrimaryText(text: 'your information',color: AppColors.mediumLight,),
          SizedBox(height:25,),
          link(
              onTap: () {
                Get.toNamed(RouteName.orderHistoryScreen);
              },
              title: 'order history',
              icon: Remix.file_history_line),
          link(
              onTap: () {
                Get.toNamed(RouteName.addressScreen);

              },
              title: 'address book',
              icon: Remix.map_pin_range_line),
          link(onTap: () {
            Get.toNamed(RouteName.editProfileScreen);
          }, title: 'edit profile', icon: Remix.pencil_line),
          link(
              onTap: () {},
              title: 'notification',
              icon: Remix.notification_4_line),
          const PrimaryText(text: 'others',color: AppColors.mediumLight),
          SizedBox(height:25,),
          link(
              onTap: () {
                Get.toNamed(RouteName.productDetailsScreen);
              },
              title: 'support',
              icon: Remix.customer_service_2_line),
          link(onTap: () {}, title: 'share the app', icon: Remix.share_line),
          link(
              onTap: () {},
              title: 'about us',
              icon: Remix.information_line),
          link(
              onTap: () {
                Get.toNamed(RouteName.changePasswordScreen);
              },
              title: 'change password',
              icon: Remix.lock_unlock_line),
          link(
              onTap: () async  {
                await SharedPrefUtil().deleteToken();
                Get.offAllNamed(RouteName.loginScreen);
              },
              title: 'logout',
              icon: Remix.logout_circle_line),
        ],
      ),
    );
  }

  // this widget is for making link
  Widget link({required IconData icon, required VoidCallback onTap, required title}) {
    return TouchableOpacity(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25,left:7),
          child: Row(
          children: [
          Icon(
            icon,
            size: 18,
            color: AppColors.mediumLight,
          ),
          SizedBox(
            width: 20,
          ),
          PrimaryText(
            text: title,
            fontSize: 12,
          )
          ],
        ),
        ),
      ),
    );
  }
}
