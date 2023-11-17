import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_shop/constants/appSizes.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/controller/change_password_controller.dart';
import 'package:what_shop/views/screens/widget/error_text.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/screens/widget/secondary_custom_app_bar.dart';
import 'package:what_shop/views/widgets/buttons.dart';
import 'package:what_shop/views/widgets/inputs.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController f = TextEditingController();
final ChangePasswordController changePasswordController = Get.put(ChangePasswordController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: SecondaryCustomAppBar(title: 'Change password'),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        constraints: BoxConstraints(minHeight: Get.height),
        child: Column(
          children: [
            Expanded(
              flex: MediaQuery.of(context).viewInsets.bottom == 0 ? 2 : 1,
              child: Container(
                width: Get.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        PrimaryText(
                          text: "Change Your",
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        PrimaryText(
                          text: " Password",
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        padding: EdgeInsets.only(right: 15),
                        child: PrimaryText(
                          text:
                              'Please create a strong password for your account. Your security is our priority. ',
                          alignment: TextAlign.start,
                          color: AppColors.mediumLight,
                        )),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      onChanged: (val){
                        changePasswordController.errorMessage.value = '';
                      },
                      hintText: 'password',
                      controller: changePasswordController.passwordController,
                      bgColor: AppColors.inputBackgroundColor,
                      borderRadius: 10,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                      onChanged: (val){
                        changePasswordController.errorMessage.value = '';
                      },
                      hintText: 'Confirm password',
                      controller: changePasswordController.confirmPasswordController,
                      bgColor: AppColors.inputBackgroundColor,
                      borderRadius: 10,
                    ),
                    SizedBox(height: 10,),
                   Obx(()=>ErrorText(text: changePasswordController.errorMessage.value))
                  ],
                ),
              ),
            ),
            Container(
              child:Obx(()=> SecondaryButton(
                buttonText: 'Update Password',
                onTap: () {
                  FocusScope.of(context).unfocus();
                  changePasswordController.changePassword();
                },
                backgroundColor: AppColors.primaryDark,
                height: 45,
                borderRadius: 10,
                fontColor: AppColors.fontOnSecondary,
                fontSize: 12,
                isLoading: changePasswordController.isLoading.value,
              ),)
            ),
            MediaQuery.of(context).viewInsets.bottom == 0
                ? Expanded(child: Container())
                : SizedBox.shrink()
          ],
        ),
      ),
    ));
  }
}
