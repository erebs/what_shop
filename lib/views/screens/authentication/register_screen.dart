import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:what_shop/controller/user_registration_controller.dart';
import 'package:what_shop/views/screens/authentication/login_screen.dart';
import 'package:get/get.dart';
import 'package:what_shop/views/screens/widget/error_text.dart';
import 'package:what_shop/views/screens/widget/progress_indicator.dart';
import '../../../constants/app_colors.dart';
import '../../widgets/buttons.dart';
import '../../widgets/inputs.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final UserRegistrationController controller =
      Get.put(UserRegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(minHeight: Get.height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Welcome to",
                        style: TextStyle(
                            color: AppColors.secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "U MALL",
                        style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Register Now!",
                        style: TextStyle(
                            color: AppColors.fontOnWhite.withOpacity(0.3),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      EditableBox(
                          onChanged: (value) {
                            controller.errorMessage.value = '';
                          },
                          controller: controller.nameController,
                          hint: 'Enter your Name',
                          type: TextInputType.text),
                      const SizedBox(
                        height: 15,
                      ),
                      EditableBox(
                          maxLength: 10,
                          onChanged: (value) {
                            // if (value.length == 10) {
                            //   controller.verifyMobileNumber();
                            // }
                            controller.errorMessage.value = '';
                          },
                          controller: controller.mobileNumberController,
                          hint: 'Enter your Mobile number',
                          type: TextInputType.phone),
                      const SizedBox(
                        height: 15,
                      ),
                      EditableBox(
                          onChanged: (value) {
                            controller.errorMessage.value = '';
                          },
                          controller: controller.emailController,
                          hint: 'Enter your Email ID',
                          type: TextInputType.emailAddress),
                      const SizedBox(
                        height: 15,
                      ),
                      EditableBox(
                          onChanged: (value) {
                            controller.errorMessage.value = '';
                          },
                          controller: controller.passwordController,
                          hint: 'Enter your Password',
                          isPassword: true,
                          type: TextInputType.text),
                      const SizedBox(
                        height: 15,
                      ),
                      EditableBox(
                          onChanged: (value) {
                            controller.errorMessage.value = '';
                          },
                          controller: controller.confirmPasswordController,
                          hint: 'Confirm your Password',
                          isPassword: true,
                          type: TextInputType.text),
                      SizedBox(
                        height: 10,
                      ),
                     Obx(()=> ErrorText(text: controller.errorMessage.toString())),
                      const SizedBox(
                        height: 25,
                      ),
                      PrimaryButton(
                          buttonText: 'Register',
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            controller.registerUser();
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(()=>  Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Visibility(
                          visible: controller.isLoading.value,
                          child:  CustomProgressIndicator(),
                        ),),
                      ),
                    ],
                  ),
                  TouchableOpacity(
                    onTap: () {
                      FocusScope.of(context).unfocus();

                      Get.off(() => const LoginScreen());
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: "Already a member? "),
                            TextSpan(
                              text: 'Login Here',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
