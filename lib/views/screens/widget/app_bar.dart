import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_images.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/views/screens/whats/whats_screen.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';


class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool? isSearch;
  final TextEditingController? searchText;
  var onChange;
   CustomAppBar({Key? key,this.isSearch = false,this.searchText,this.onChange}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBar();
  Size get preferredSize => Size.fromHeight(Get.height / 4);

}
@override

class _CustomAppBar extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(Get.height / 4),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.appLogo),
                  // SvgPicture.asset(AppImages.appLogo,width: 10,height: 10,),
                  const SizedBox(
                    width: 6,
                  ),
                  const PrimaryText(
                    text: 'WhatsAppShop',
                    fontSize: 13,
                    color: AppColors.fontOnSecondary,
                  ),
                ],
              ),
           dummySearchbar(context,isSearch: widget.isSearch, onTap:(){
                Get.toNamed(RouteName.allShopsScreen);
              },onChange: widget.onChange,searchText: widget.searchText
              )
            ],
          ),
        ),
      ),
    );
  }
}
Widget dummySearchbar(BuildContext context, {required void Function()? onTap,isSearch = false,TextEditingController? searchText,onChange}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 40,
      decoration: BoxDecoration(
          color: AppColors.fontOnSecondary,
          borderRadius: BorderRadius.circular(6)),
      padding: const EdgeInsets.only(right: 5, left: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isSearch == false ?const PrimaryText(
            text: 'Search  shops  by  Category',
            color: AppColors.mediumLight,
          ): Expanded(  // <-- Here
              child: TextField(
                onChanged: onChange,
                controller: searchText,
                decoration:const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical:16),
                    hintText: 'Search  shops  by  Category ',
                  hintStyle: TextStyle(color: AppColors.mediumLight,fontSize: 10,)
                ),
              )
          ),
          Container(
            width: 37,
            height: 26,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColors.inputBackgroundColor),
            child: const Icon(
              Remix.search_line,
              size: 18,
            ),
          )
        ],
      ),
    ),
  );
}