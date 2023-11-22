import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:what_shop/constants/appSizes.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/controller/edit_profile_controller.dart';
import 'package:what_shop/controller/user_data_controller.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/screens/widget/secondary_custom_app_bar.dart';
import 'package:what_shop/views/widgets/buttons.dart';
import 'package:what_shop/views/widgets/inputs.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final UserDataController userDataController = Get.find();
  final EditProfileController editProfileController = Get.put(EditProfileController());
  @override
  Widget build(BuildContext context) {
    editProfileController.nameController.text = userDataController.userData.value?.details.name ?? '';
    editProfileController.emailController.text = userDataController.userData.value?.details.email ?? '';
    return SafeArea(
      child: Scaffold(
        appBar: SecondaryCustomAppBar(title: 'Edit profile'),
        body:SingleChildScrollView(
          child: Container(
            color: AppColors.fontOnSecondary,
            width: Get.width,
            height: Get.height,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              children: [
                profileLogo(),
                SizedBox(height: 30,),

                CustomTextField(hintText: 'Name',borderRadius: 10,borderColor:AppColors.lightGrey,borderWidth: 1,controller:editProfileController.nameController,height:20,containerHeight:50,),
                SizedBox(height: 15,),
                CustomTextField(hintText: 'Email Id',borderRadius: 10,borderColor:AppColors.lightGrey,borderWidth: 1,controller: editProfileController.emailController,height:20,containerHeight:50,),
                SizedBox(height: 40,),
               Obx(() =>SecondaryButton(isLoading: editProfileController.isLoading.value,buttonText: 'Save Changes', onTap: (){
                 editProfileController.editUserProfile();
               },backgroundColor: AppColors.primaryDark,height: 45,borderRadius: 10,fontColor: AppColors.fontOnSecondary,)
               )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileLogo(){
    return   Column(
      children: [
        SizedBox(height: 54,),
        Container(
          decoration:BoxDecoration(
              color: AppColors.lightGrey,

              borderRadius: BorderRadius.circular(30)
          ),
          height: 91,
          width: 91,
          child: Icon(Remix.account_pin_circle_fill,color: AppColors.fontOnSecondary,size:50,),

        ),
        SizedBox(height: 10,),
        PrimaryText(text: 'Personal information',fontSize: 11,),
        SizedBox(height: 40,),

      ],
    );
  }
}
