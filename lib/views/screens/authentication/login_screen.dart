import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/views/screens/authentication/forgot_screen.dart';
import 'package:what_shop/views/screens/authentication/register_screen.dart';
import 'package:what_shop/views/widgets/buttons.dart';
import 'package:what_shop/views/widgets/inputs.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Welcome back",
                      style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),),
                    Text("WhatShop",
                      style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    Text("Login Here!",
                      style: TextStyle(
                          color: AppColors.fontOnWhite.withOpacity(0.3),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),),
                    SizedBox(height: 25,),

                    EditableBox(
                        controller: mobileController,
                        hint: 'Mobile number',
                        type: TextInputType.phone),

                    SizedBox(height: 15,),

                    EditableBox(
                        controller: passwordController,
                        hint: 'Password',
                        isPassword: true,
                        type: TextInputType.text),

                    SizedBox(height: 15,),

                    Align(
                      alignment: Alignment.topRight,
                      child: TouchableOpacity(
                        onTap: (){
                          Get.to(() => ForgotScreen());
                        },
                        child: const Text("Forgot Password?",
                            style: TextStyle(
                                color:AppColors.fontOnWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 13
                            )),
                      ),
                    ),

                    SizedBox(height: 20,),

                    PrimaryButton(

                        buttonText: 'Login',
                        onTap: () {})

                  ],
                ),
              ),


              Align(
                alignment: Alignment.bottomCenter,
                child: TouchableOpacity(
                  onTap: () {
                    Get.off(() => RegisterScreen());
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "Don't have an account yet? "),
                          TextSpan(
                            text: 'Register Now',
                            style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
