import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_images.dart';
import 'package:what_shop/constants/app_variables.dart';
import 'package:what_shop/views/screens/authentication/forgot_screen.dart';
import 'package:what_shop/views/screens/authentication/register_screen.dart';
import 'package:what_shop/views/screens/whats/whats_screen.dart';

import 'login_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    screenNavigation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.center,
                  children: [

                    Image.asset(AppImages.bgImage, color: Colors.black,),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Icon(Remix.shopping_bag_3_line, color: AppColors.fontOnSecondary, size: 50,),
                        SizedBox(height: 5,),
                        Text("WhatShop",
                          style: TextStyle(
                              color: AppColors.fontOnSecondary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Developed By",
                  style: TextStyle(
                      color: AppColors.fontOnSecondary,
                      fontSize: 12,),),
                Image.asset(AppImages.ereLogo),
                SizedBox(height: 5,),

              ],
            ),

          ],
        ),
      ),
    );
  }

  screenNavigation () async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = (prefs.getBool('is_logged_in') == null || prefs.getBool('is_logged_in') == false ? false : true);

    String?   userName    = prefs.getString("user_name");
    int?      userId      = prefs.getInt("user_id");
    String?   userMobile  = prefs.getString("user_mobile");
    String?   userEmail   = prefs.getString("user_email");

    Future.delayed(const Duration (seconds: 3),(){
      Get.off(()=>isLoggedIn ? WhatScreen(
        // userName: userName!,
        // userMobile: userMobile!,
        // userEmail: userEmail!,
      ) :  const LoginScreen(),
          transition: Transition.native,
          duration: const Duration(microseconds: 1200));
    });

  }

}
