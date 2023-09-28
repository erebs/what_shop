import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:what_shop/views/screens/authentication/login_screen.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../widgets/buttons.dart';
import '../../widgets/inputs.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

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
                    const Text("Welcome to",
                      style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),),
                    const Text("WhatShop",
                      style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5,),
                    Text("Register Now!",
                      style: TextStyle(
                          color: AppColors.fontOnWhite.withOpacity(0.3),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),),
                    const SizedBox(height: 25,),

                    EditableBox(
                        controller: nameController,
                        hint: 'Enter your Name',
                        type: TextInputType.text),
                    SizedBox(height: 15,),

                    EditableBox(
                        controller: mobileController,
                        hint: 'Enter your Mobile number',
                        maxLength: 10,
                        type: TextInputType.phone),
                    SizedBox(height: 15,),

                    EditableBox(
                        controller: emailController,
                        hint: 'Enter your Email ID',
                        maxLength: 10,
                        type: TextInputType.emailAddress),
                    SizedBox(height: 15,),

                    EditableBox(
                        controller: passwordController,
                        hint: 'Enter your Password',
                        isPassword: true,
                        type: TextInputType.text),
                    SizedBox(height: 15,),

                    EditableBox(
                        controller: cPasswordController,
                        hint: 'Confirm your Password',
                        isPassword: true,
                        type: TextInputType.text),
                    SizedBox(height: 25,),


                    PrimaryButton(
                        buttonText: 'Register',
                        onTap: () {})

                  ],
                ),
              ),


              Align(
                alignment: Alignment.bottomCenter,
                child: TouchableOpacity(
                  onTap: () {
                    Get.off(() => LoginScreen());
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "Already a member? "),
                          TextSpan(
                            text: 'Login Here',
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
