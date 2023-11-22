import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:what_shop/constants/appSizes.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_images.dart';
import 'package:what_shop/controller/address_controller.dart';
import 'package:what_shop/models/user_address_model.dart';
import 'package:what_shop/utils/api_state_enum.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/views/screens/common/error_page.dart';
import 'package:what_shop/views/screens/common/no_address_added_screen.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/screens/widget/secondary_custom_app_bar.dart';
import 'package:what_shop/views/widgets/buttons.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  // final AddressController addressController = Get.put(AddressController(),permanent: false);
  final AddressController addressController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SecondaryCustomAppBar(
          title: 'Addresses',
          onTap: () => Get.back(),
        ),
        body: Container(
          padding:
              EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
          color: AppColors.inputBackgroundColor,
          height: Get.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimaryText(
                text: 'Saved Addresses',
                fontSize: 10,
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(child: addressList()),
              Obx(() => addressController.errorMessage.value.isEmpty
                  ? addAddressButton()
                  : SizedBox.shrink())
            ],
          ),
        ),
      ),
    );
  }

  Widget addressList() {
    final addresses = addressController.addresses;

    return Obx(() {
      if (addressController.addressState.value == DataState.Loading) {
        return const Center(
            child: CircularProgressIndicator(
          color: AppColors.primary,
        ));
      } else if (addressController.addressState.value == DataState.Error) {
        return ErrorScreen(
            img: AppImages.errorImg,
            onTap: () {
              addressController.getUserAddress();
            },
            errorMsg: addressController.errorMessage.value);
      } else if (addressController.addresses.isEmpty) {
        return const NoAddressFoundScreen();
      } else {
        return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: addresses.length,
            itemBuilder: (context, index) =>
                addressCard(address: addresses[index]));
      }
    });
  }

  //this widget is address card

  Widget addressCard({required Address address}) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: AppColors.fontOnSecondary,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Remix.home_2_line,
                size: 17,
              ),
              SizedBox(
                width: 5,
              ),
              PrimaryText(
                text: address.type,
                fontSize: 12,
              )
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Container(
            padding: EdgeInsets.only(left: 22, right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                    children: [
                      addressText(text: '${address.address}'),
                      addressText(text: ', ${address.landmark}'),
                      addressText(text: ', ${address.city}'),
                      addressText(text: ', ${address.district}'),
                      addressText(text: ', ${address.state}'),
                      addressText(text: ', ${address.pincode}'),

                    ],
                  ),

                SizedBox(height: 3,),
                addressText(text: '${address.mobile}'),
                SizedBox(height: 4,),

                Row(
                  children: [
                    customIconconButton(
                        icon: Remix.pencil_line,
                        onTap: () {
                          Get.toNamed(RouteName.editAddressScreen,
                              arguments: address);
                        },
                        bgColor: AppColors.primaryDark),
                    SizedBox(
                      width: 9,
                    ),
                    customIconconButton(
                        icon: Remix.delete_bin_line,
                        onTap: () {
                          addressController.deleteUserAddress(address.id);
                        },
                        bgColor: Colors.red)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  //dummy address card  for loader
  Widget DummyddressCard() {
    return Container(
      constraints: BoxConstraints(minHeight: 114, maxHeight: 120),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: AppColors.fontOnSecondary,
          borderRadius: BorderRadius.circular(12)),
    );
  }

  // this widget is a custom iconButton
  Widget customIconconButton(
      {required VoidCallback onTap,
      required Color bgColor,
      required IconData icon}) {
    return TouchableOpacity(
      onTap: onTap,
      activeOpacity: .8,
      child: Container(
          height: 21,
          width: 21,
          decoration: BoxDecoration(
              color: bgColor, borderRadius: BorderRadius.circular(7)),
          child: Center(
            child: Icon(
              icon,
              size: 13,
              color: AppColors.fontOnSecondary,
            ),
          )),
    );
  }

// this widget add address button

  Widget addAddressButton() {
    return SecondaryButton(
      buttonText: 'Add new address',
      onTap: () {
        Get.toNamed(RouteName.addAddressScreen);
      },
      height: 40,
      backgroundColor: AppColors.primaryDark,
      borderRadius: 10,
      fontColor: AppColors.fontOnSecondary,
      fontSize: 11,
    );
  }

  Widget addressText({required String text}) {
    return Container(
      margin: EdgeInsets.only(bottom:4),
      child: PrimaryText(
        text: text,
        color: Colors.grey.shade700,
        fontSize: 13,
      ),
    );
  }
}
