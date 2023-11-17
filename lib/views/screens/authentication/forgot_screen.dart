import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:what_shop/controller/forget_password_controller.dart';
import 'package:what_shop/controller/login_controller.dart';
import 'package:what_shop/views/screens/authentication/register_screen.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../widgets/buttons.dart';
import '../../widgets/inputs.dart';
class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final ForgetPasswordController forgetPasswordController = Get.put(ForgetPasswordController());
  final LoginController loginController = Get.find();

  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        top: false,
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
                    Text("Forgot password",
                      style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),),
                    Text("U MALL",
                      style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    Text("Reset Here!",
                      style: TextStyle(
                          color: AppColors.fontOnWhite.withOpacity(0.3),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),),
                    SizedBox(height: 25,),

                    EditableBox(
                        controller: mobileController,
                        hint: 'OTP',
                        maxLength: 4,
                        type: TextInputType.number),

                    SizedBox(height: 10,),

                    Align(
                      alignment: Alignment.topRight,
                      child: TouchableOpacity(
                        onTap: (){},
                        child: const Text("Resend OTP",
                            style: TextStyle(
                                color:AppColors.fontOnWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 13
                            )),
                      ),
                    ),

                    SizedBox(height: 15,),

                    EditableBox(
                        controller: passwordController,
                        hint: 'New Password',
                        isPassword: true,
                        type: TextInputType.text),

                    SizedBox(height: 15,),

                    EditableBox(
                        controller: confirmPasswordController,
                        hint: 'Confirm Password',
                        isPassword: true,
                        type: TextInputType.text),



                    SizedBox(height: 20,),

                    PrimaryButton(

                        buttonText: 'Submit',
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
