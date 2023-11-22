import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_images.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/views/screens/whats/home_screen.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/widgets/inputs.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool? isSearch;
  final TextEditingController? searchText;
  var onChange;

  CustomAppBar({
    Key? key,
    this.isSearch = false,
    this.searchText,
    this.onChange,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBar();

  Size get preferredSize => Size.fromHeight(Get.height / 4);
}

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
              bottomRight: Radius.circular(18),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppImages.appLogoSvg,
                    height: 35,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                ],
              ),
              dummySearchbar(
                context,
                isSearch: widget.isSearch,
                onTap: () {
                  Get.toNamed(RouteName.allShopsScreen);
                },
                onChange: widget.onChange,
                searchText: widget.searchText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget dummySearchbar(
    BuildContext context, {
      required void Function()? onTap,
      isSearch = false,
      TextEditingController? searchText,
      onChange,
    }) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.fontOnSecondary,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.only(right: 5, left: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isSearch == false
              ? const PrimaryText(
            text: 'Search shops by category',
            color: AppColors.mediumLight,
          )
              : Expanded(
            child: CustomTextField(
              controller: searchText!,
              hintText: 'Search shops by category ',
              height: 16,
              onChanged: onChange,
              horizontalPadding: 0,
            ),
          ),
          Container(
            width: 37,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColors.fontOnSecondary,
            ),
            child: const Icon(
              Remix.search_line,
              size: 20,
            ),
          ),
        ],
      ),
    ),
  );
}
