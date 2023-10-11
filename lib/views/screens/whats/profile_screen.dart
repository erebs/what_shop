import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          child: Column(
            children: [
              SizedBox(
                height: 17,
              ),
              userProfile(),
              SizedBox(
                height: 60,
              ),
              listLink()
            ],
          ),
        ),
      ),
    );
  }

  Widget userProfile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColors.inputBackgroundColor,
          ),
          height: 65,
          width: 65,
          child: Icon(
            Remix.user_line,
            size: 25,
          ),
        ),
        SizedBox(
          width: 14,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryText(
              text: 'Hi',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            PrimaryText(
              text: 'name',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 3,
            ),
            PrimaryText(text: 'shameel@gmail.com'),
            SizedBox(
              height: 2,
            ),
            PrimaryText(text: '956238830867'),
          ],
        )
      ],
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
          link(onTap: () {}, title: 'edit profile', icon: Remix.pencil_line),
          link(
              onTap: () {},
              title: 'notification',
              icon: Remix.notification_4_line),
          const PrimaryText(text: 'others',color: AppColors.mediumLight),
          SizedBox(height:25,),
          link(
              onTap: () {},
              title: 'support',
              icon: Remix.customer_service_2_line),
          link(onTap: () {}, title: 'share the app', icon: Remix.share_line),
          link(
              onTap: () {},
              title: 'about us',
              icon: Remix.information_line),
          link(
              onTap: () {},
              title: 'change password',
              icon: Remix.lock_unlock_line),
          link(
              onTap: () {},
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
        ));
  }
}
