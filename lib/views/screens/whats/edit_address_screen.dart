import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_shop/constants/appSizes.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/controller/address_controller.dart';
import 'package:what_shop/models/user_address_model.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/views/screens/widget/error_text.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/screens/widget/secondary_custom_app_bar.dart';
import 'package:what_shop/views/widgets/buttons.dart';
import 'package:what_shop/views/widgets/inputs.dart';

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({super.key});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final AddressController addressController = Get.find();
  final Address data = Get.arguments;
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final addressController2 = TextEditingController();
  final landmarkController = TextEditingController();
  final pincodeController = TextEditingController();
  final cityController = TextEditingController();
  final districtController = TextEditingController();
  final stateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the data
    nameController.text = data.name ?? '';
    mobileController.text = data.mobile ?? '';
    emailController.text = data.email ?? '';
    addressController2.text = data.address ?? '';
    landmarkController.text = data.landmark ?? '';
    pincodeController.text = data.pincode ?? '';
    cityController.text = data.city ?? '';
    districtController.text = data.district ?? '';
    stateController.text = data.state ?? '';
  }

  @override
  Widget build(BuildContext context) {
    addressController.type.value = data.type;
    return SafeArea(
      child: Scaffold(
        appBar: SecondaryCustomAppBar(title: 'Edit Address',
onTap: (){
  addressController.errorMessage.value = '';
Get.back();
},
        ),
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
                Center(
                    child: Obx(() => addressController.isLoading.value
                        ? CircularProgressIndicator(
                            color: AppColors.primary,
                          )
                        : SizedBox.shrink())),
                SizedBox(
                  height: 5,
                ),
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
          onChanged: (value) {
            addressController.errorMessage.value = '';
          },
          hintText: 'Enter your name',
          controller: nameController,
          bgColor: AppColors.fontOnSecondary,
          borderRadius: 10,
          fontSize: 12,
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
            onChanged: (value) {
              addressController.errorMessage.value = '';
            },
            hintText: 'Enter your phone number',
            keyBoardType: TextInputType.number,
            controller: mobileController,
            bgColor: AppColors.fontOnSecondary,
            borderRadius: 10,
            fontSize: 12),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
            onChanged: (value) {
              addressController.errorMessage.value = '';
            },
            hintText: 'Enter your mail',
            controller: emailController,
            bgColor: AppColors.fontOnSecondary,
            borderRadius: 10,
            fontSize: 12),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
            onChanged: (value) {
              addressController.errorMessage.value = '';
            },
            hintText: 'Enter your address',
            controller: addressController2,
            bgColor: AppColors.fontOnSecondary,
            borderRadius: 10,
            containerHeight: 100,
            fontSize: 12),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
            onChanged: (value) {
              addressController.errorMessage.value = '';
            },
            hintText: 'Enter your landmark',
            controller: landmarkController,
            bgColor: AppColors.fontOnSecondary,
            borderRadius: 10,
            fontSize: 12),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
            onChanged: (value) {
              addressController.errorMessage.value = '';
            },
            hintText: 'Enter your pincode',
            keyBoardType: TextInputType.number,
            controller: pincodeController,
            bgColor: AppColors.fontOnSecondary,
            borderRadius: 10,
            fontSize: 12),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
            onChanged: (value) {
              addressController.errorMessage.value = '';
            },
            hintText: 'Enter your city',
            controller: cityController,
            bgColor: AppColors.fontOnSecondary,
            borderRadius: 10,
            fontSize: 12),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
            onChanged: (value) {
              addressController.errorMessage.value = '';
            },
            hintText: 'Enter your district',
            controller: districtController,
            bgColor: AppColors.fontOnSecondary,
            borderRadius: 10,
            fontSize: 12),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
            onChanged: (value) {
              addressController.errorMessage.value = '';
            },
            hintText: 'Enter your state',
            controller: stateController,
            bgColor: AppColors.fontOnSecondary,
            borderRadius: 10,
            fontSize: 12),
        SizedBox(
          height: 7,
        ),
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
      height: 36,
      buttonText: 'Save',
      onTap: () {
        addressController.updateUserAddress(
          type1:addressController.type.value,
            addressId1: data.id.toString(),
            name1: nameController.text,
            email1: emailController.text,
            mobile1: mobileController.text,
            address1: addressController2.text,
            landmark1: landmarkController.text,
            pincode1: pincodeController.text,
            city1: cityController.text,
            district1: districtController.text,
            state1: stateController.text);

      },
      backgroundColor: AppColors.primaryDark,
      fontColor: AppColors.fontOnSecondary,
      borderRadius: 10,
    ));
  }
  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    addressController2.dispose();
    landmarkController.dispose();
    pincodeController.dispose();
    cityController.dispose();
    districtController.dispose();
    stateController.dispose();
    super.dispose();
  }
  // @override
  // void deactivate() {
  //   super.deactivate();
  //   addressController.errorMessage.value = '';
  // }
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
