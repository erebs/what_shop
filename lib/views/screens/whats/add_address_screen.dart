import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_shop/constants/appSizes.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/controller/address_controller.dart';
import 'package:what_shop/views/screens/widget/error_text.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/screens/widget/secondary_custom_app_bar.dart';
import 'package:what_shop/views/widgets/buttons.dart';
import 'package:what_shop/views/widgets/inputs.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final AddressController addressController = Get.find();
  RxString selectedOption = 'home'.obs;
  RxString office = 'office'.obs;
  RxString home = 'home'.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SecondaryCustomAppBar(title: 'Add New Address',onTap: (){
          addressController.errorMessage.value = '';
          Get.back();
        }),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          width: Get.width,
          color: AppColors.inputBackgroundColor,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                addressField(),
                const PrimaryText(
                  text: 'Address type',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
                const SizedBox(
                  height: 8,
                ),
                addressType(),
                const SizedBox(
                  height: 20,
                ),
                Center(child: Obx(()=> addressController.isLoading.value ? CircularProgressIndicator(color: AppColors.primary,):SizedBox.shrink( ))),
                SizedBox(height: 5,),
                saveButton(),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //This widget display all input box

  Widget addressField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          onChanged: (value){
            addressController.errorMessage.value = '';
          },
          hintText: 'Enter your name',
          controller: addressController.name,
          bgColor: AppColors.fontOnSecondary,
          borderRadius: 10,
          fontSize: 12,
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
            onChanged: (value){
              addressController.errorMessage.value = '';
            },
            hintText: 'Enter your phone number',
            keyBoardType: TextInputType.number,
            controller: addressController.mobile,
            bgColor: AppColors.fontOnSecondary,
            borderRadius: 10,
            fontSize: 12),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
            onChanged: (value){
              addressController.errorMessage.value = '';
            },
            hintText: 'Enter your mail',
            controller: addressController.email,
            bgColor: AppColors.fontOnSecondary,
            borderRadius: 10,
            fontSize: 12),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
            onChanged: (value){
              addressController.errorMessage.value = '';
            },
            hintText: 'Enter your address',
            controller: addressController.address,
            bgColor: AppColors.fontOnSecondary,
            borderRadius: 10,
            containerHeight: 100,
            fontSize: 12),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
            onChanged: (value){
              addressController.errorMessage.value = '';
            },
            hintText: 'Enter your landmark',
            controller: addressController.landmark,
            bgColor: AppColors.fontOnSecondary,
            borderRadius: 10,
            fontSize: 12),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
            onChanged: (value){
              addressController.errorMessage.value = '';
            },
            hintText: 'Enter your pincode',
            keyBoardType: TextInputType.number,
            controller: addressController.pincode,
            bgColor: AppColors.fontOnSecondary,
            borderRadius: 10,
            fontSize: 12),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
            onChanged: (value){
              addressController.errorMessage.value = '';
            },
            hintText: 'Enter your city',
            controller: addressController.city,
            bgColor: AppColors.fontOnSecondary,
            borderRadius: 10,
            fontSize: 12),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
          onChanged: (value){
            addressController.errorMessage.value = '';
          },
            hintText: 'Enter your district',
            controller: addressController.district,
            bgColor: AppColors.fontOnSecondary,
            borderRadius: 10,
            fontSize: 12),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
            onChanged: (value){
              addressController.errorMessage.value = '';
            },
            hintText: 'Enter your state',
            controller: addressController.state,
            bgColor: AppColors.fontOnSecondary,
            borderRadius: 10,
            fontSize: 12),
        SizedBox(height:7,),
        Obx(
          () => addressController.errorMessage.value.isNotEmpty
              ? ErrorText(text: addressController.errorMessage.value)
              : SizedBox.shrink(),
        ),
        const SizedBox(
          height: 19,
        ),
      ],
    );
  }

  //this display radio button for selecting address type
  Widget addressType() {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Obx(
          () => CustomListTile(
              text: 'Home',
              radioValue: 'Home',
              groupValue: addressController.type.value,
              onChanged: (value) {
                addressController.type.value = value!;
              }),
        ),
        Obx(
          () => CustomListTile(
              text: 'Work',
              radioValue: 'Work',
              groupValue: addressController.type.value,
              onChanged: (value) {
                addressController.type.value = value!;
              }),
        ),
      ],
    );
  }

  // this is the save button widget
  Widget saveButton() {
    return (SecondaryButton(
      height: 40,
      buttonText: 'Save',
      onTap: () {
        print(addressController.type.value);
        addressController.createUserAddress();
      },
      backgroundColor: AppColors.primaryDark,
      fontColor: AppColors.fontOnSecondary,
      borderRadius: 10,
    ));
  }
}

class CustomListTile extends StatelessWidget {
  final String text;
  final String radioValue;
  final String groupValue;
  final Function(String?) onChanged;

  CustomListTile({
    required this.text,
    required this.radioValue,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(-14, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
            value: radioValue,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          PrimaryText(
            text: text,
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}
