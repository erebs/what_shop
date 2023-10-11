import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:what_shop/constants/appSizes.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/screens/widget/secondary_custom_app_bar.dart';
import 'package:what_shop/views/widgets/buttons.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:SecondaryCustomAppBar(title: 'Addresses'),

        body: Container(
          padding:
              EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
          color:AppColors.inputBackgroundColor,
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    PrimaryText(text: 'Saved Addresses',fontSize: 10,),
                    SizedBox(height:8,),
                    Container(
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          color: AppColors.fontOnSecondary,
                          borderRadius: BorderRadius.circular(12)),
                      height: 114,
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
                                text: 'Work',
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
                                Text(
                                  'ERE business solutions, sahya building cyberpark, 623008',
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.mediumLight,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                PrimaryText(
                                  text: 'Phone no : 9745640896',
                                  color: AppColors.mediumLight,
                                ),
                                SizedBox(height:9,),

                                Row(
                                  children: [
                                    customIconconButton(icon: Remix.pencil_line,onTap: (){},bgColor:AppColors.primaryDark),
                                    SizedBox(width:9,),
                                    customIconconButton(icon: Remix.delete_bin_line,onTap: (){},bgColor:Colors.red)
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SecondaryButton(
                buttonText: 'Add new address',
                onTap: () {},
                height: 36,
                backgroundColor: AppColors.primaryDark,
                borderRadius: 10,
                fontColor: AppColors.fontOnSecondary,
                fontSize: 11,
              )
            ],
          ),
        ),
      ),
    );
  }


 // this widget is a custom iconButton
 Widget customIconconButton({required VoidCallback onTap,required Color bgColor,required IconData icon}){
    return   TouchableOpacity(
      onTap: onTap,
      activeOpacity: .8,
      child: Container(
          height: 21,
          width: 21,
          decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(7)),
          child:
          Center(
            child: Icon(
              icon,
              size: 13,
              color: AppColors.fontOnSecondary,
            ),
          )),
    );
 }
}
