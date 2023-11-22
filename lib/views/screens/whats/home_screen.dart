import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_images.dart';
import 'package:what_shop/constants/app_variables.dart';
import 'package:what_shop/controller/favourite_shops_controller.dart';
import 'package:what_shop/controller/home_screen_controller.dart';
import 'package:what_shop/controller/location_controller.dart';
import 'package:what_shop/controller/test_controller.dart';
import 'package:what_shop/controller/user_data_controller.dart';
import 'package:what_shop/utils/api_state_enum.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/utils/shared_pref_util.dart';
import 'package:what_shop/views/screens/common/error_page.dart';
import 'package:what_shop/views/screens/widget/app_bar.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/screens/widget/progress_indicator.dart';
import 'package:what_shop/views/screens/widget/shop_card.dart';
import 'package:what_shop/views/widgets/buttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key); // Corrected super call

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  void initState() {
    super.initState();
    favouriteShopsController = Get.put(FavouriteShopsController());
  }

  final UserDataController userDataController = Get.put(UserDataController());
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController(), permanent: true);
  final LocationController locationController = Get.put(LocationController());
  final HomeController homeController = Get.put(HomeController());

  // final FavouriteShopsController favouriteShopsController = Get.put(FavouriteShopsController());
  late final FavouriteShopsController favouriteShopsController;
  DateTime? lastPressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => willPop(),
      child: Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(minHeight: Get.height),
            color: AppColors.inputBackgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            width: Get.width,
            child: Obx(() {
              if (homeScreenController.errorMessage.value.isNotEmpty) {
                return ErrorScreen(
                    errorMsg: homeScreenController.errorMessage.value,
                    onTap: () {
                      homeController.getHomeData();
                    });
              }
              return Container(
                constraints: BoxConstraints(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    carousel(),
                    buildLocationRow(),
                    const SizedBox(height: 5),
                    favouriteShops(),
                    displayShops(),
                    const SizedBox(height: 15),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  // This widget is to pass items to carousel carousel
  List<Widget> mainCarouselItems() {
    final itemList = homeScreenController.shopsNearUser.value?.firstad;
    if (itemList == null || itemList.isEmpty) {
      return [];
    }
    // Filtering out any possible null items and returning the list.
    return itemList.map((banner) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: AppColors.fontOnSecondary,
            ),
            width: Get.width,
            height: 170,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Image.network(
                AppVariables.baseUrl + banner.image,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset(AppImages.bgImage),
              ),
            )),
      );
    }).toList();
  }

  Widget carousel() {
    return Obx(() {
      if (homeScreenController.shopData.value.firstad.isEmpty ||
          mainCarouselItems().isEmpty) {
        return SizedBox(height: 10);
      }
      return CarouselSlider(
        items: mainCarouselItems(),
        options: CarouselOptions(
            height: 180,
            scrollPhysics: PageScrollPhysics(),
            autoPlay: false,
            enlargeCenterPage: false,
            viewportFraction: 1.0,
            aspectRatio: 5),
      );
    });
  }

  // it display location box and apply button in row
  Widget buildLocationRow() {
    return Row(
      children: [
        locationBox(
            onTap: () {
              homeController.getHomeData();
            },
            place: homeController.locality),
        const SizedBox(width: 8),
        applyButton()
      ],
    );
  }

  Widget applyButton() {
    return Expanded(
      child: SecondaryButton(
        fontColor: AppColors.fontOnSecondary,
        borderRadius: 15,
        backgroundColor: AppColors.primaryDark,
        width: Get.width * 0.4,
        height: 42,
        buttonText: 'APPLY',
        onTap: () {
          FocusScope.of(context).unfocus();
          homeScreenController.getShopsFromPincode(
              pincode: homeController.pinCodeController.text);
        },
      ),
    );
  }

  ///////////////////////////////////////////////////////
  // it is widget that display and the location TextField
  Widget locationBox({onTap, var place}) {
    return Container(
        height: 45,
        width: Get.width * 0.62,
        child: Obx(
          () => TextField(
            controller: homeController.pinCodeController,
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
            ),
            decoration: InputDecoration(
                alignLabelWithHint: true,
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                fillColor: AppColors.fontOnSecondary,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
                suffixIcon: const Icon(
                  Remix.arrow_down_s_line,
                  size: 15,
                ),
                prefixIcon: IconButton(
                  icon: const Icon(
                    Remix.map_pin_2_fill,
                    size: 14,
                    color: AppColors.mediumLight,
                  ),
                  onPressed: onTap,
                ),
                hintText: place?.value == '' ? 'your pincode' : place?.value,
                hintStyle: const TextStyle(
                  fontSize: 10,
                )),
          ),
        ));
  }

  //-----------------------------------------------------

// This widget Display all shops if pincode is not Provide
  Widget allDefaultShops() {
    final newshops = homeScreenController.shopData.value.newshops;

    if (homeScreenController.allShopsState == DataState.Empty) {
      return Text('No shops available');
    }
    if (homeScreenController.allShopsState == DataState.Error) {
      return Text('error');
    }
    return Container(
      constraints: const BoxConstraints(
          // You can set a max height if you want.
          // maxHeight: 500, // for example
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heading(headingText: 'Newest Shops'),
          Container(
            height: 100, // you can adjust this value based on your need
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: newshops?.length,
              itemBuilder: (context, index) {
                final shop = newshops?[index];
                return Padding(
                  padding: EdgeInsets.only(),
                  child: ShopCard(
                    image: shop?.logo ?? '',
                    name: shop?.name ?? '',
                    onTap: () async{
                      await SharedPrefUtil().setShopId(shopId:shop!.id.toString());
                      Get.toNamed(
                        RouteName.mainScreen,
                        arguments: shop.id.toString(),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          buildShopListByCategory()
        ],
      ),
    );
  }

  //this widget disply all shops by category
  Widget buildShopListByCategory() {
    final category = homeScreenController.shopData.value.categories;
    if (category == null) {
      return const SizedBox.shrink();
    }
    return Column(
      children: category.map((category) {
        if (category.shops == null || category.shops!.isEmpty) {
          return const SizedBox
              .shrink(); // Return an empty widget if there are no shops for this category or it's null.
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heading(headingText: category.categoryName),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: category.shops!.length,
                itemBuilder: (context, index) {
                  final shop = category.shops![index];
                  return Padding(
                    padding: EdgeInsets.only(
                        right:
                            (index != category.shops!.length - 1) ? 10.0 : 0),
                    child: ShopCard(
                        image: shop.logo,
                        name: shop.name,
                        onTap: () async{
                          await SharedPrefUtil().setShopId(shopId: shop.id.toString());
                          Get.toNamed(
                            RouteName.mainScreen,
                            arguments: shop.id.toString(),
                          );
                          // Get.toNamed(RouteName.shopDetailsScreen);
                        }),
                  );
                },
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  // This widget display shops near user after providing pincode
  Widget buildShopListFromPinCode() {
    final shopList = homeScreenController.shopsNearUser.value;

// if(homeScreenController.shopsFromPinCodeState == DataState.Loading){
//   return CircularProgressIndicator();
// }
    if (homeScreenController.shopsFromPinCodeState == DataState.Error) {
      return Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              SvgPicture.asset(
                AppImages.errorImg,
                height: Get.height / 4,
              ),
              SizedBox(
                height: 10,
              ),
              PrimaryText(
                text: homeScreenController.errorMessage.value,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.mediumLight,
              )
            ],
          ),
        ),
      );
    }
    if (homeScreenController.shopsFromPinCodeState == DataState.Empty) {
      return Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              SvgPicture.asset(
                AppImages.noShops,
                height: Get.height / 4,
              ),
              SizedBox(
                height: 10,
              ),
              PrimaryText(
                text: 'No shops near you',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.mediumLight,
              )
            ],
          ),
        ),
      );
    }
    if (homeScreenController.shopsFromPinCodeState == DataState.Data) {
      return Column(
        children: shopList!.categories.map((category) {
          final shops = category.shops;

          // If this category has no shops, return an empty widget.
          if (shops == null || shops.isEmpty) {
            return const SizedBox.shrink();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0, bottom: 15, top: 18),
                child: PrimaryText(
                  text: category.categoryName,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: shops.length,
                  itemBuilder: (context, index) {
                    final shop = shops[index];
                    return Padding(
                      padding: EdgeInsets.only(
                          right: (index != shops.length - 1) ? 10.0 : 0),
                      child: ShopCard(
                        image: shop.logo ?? '',
                        name: shop.name,
                        onTap: () async{
                          await SharedPrefUtil().setShopId(shopId: shop.id.toString());
                          Get.toNamed(RouteName.mainScreen,
                              arguments: shop.id.toString());
                          // Get.toNamed(RouteName.shopDetailsScreen);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }).toList(),
      );
    }
    return Text('error outside');
  }

  // this widget is to display shops conditionally on the basis of whether the user granted location access

  Widget displayShops() {
    return Obx(() {
      if (homeScreenController.isLoading.value) {
        return Center(
          child: CustomProgressIndicator(strokeWidth: 3),
        );
      }
      if (homeScreenController.isLocationGranted.value) {
        return buildShopListFromPinCode();
      } else {
        return allDefaultShops();
      }
    });
  }

// //
  Future<bool> willPop() async {
    DateTime now = DateTime.now();
    if (lastPressed == null ||
        now.difference(lastPressed!) > Duration(seconds: 2)) {
      lastPressed = now;
      Get.snackbar(
        '',
        'Press back again to exit',
        snackPosition: SnackPosition.BOTTOM,
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        backgroundColor: AppColors.fontOnSecondary,
        boxShadows: [
          BoxShadow(
            color: AppColors.mediumLight,
            blurRadius: 0,
            spreadRadius: 0,
          )
        ],
        borderRadius: 0,
        duration: Duration(seconds: 2),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  Widget favouriteShops() {
    final data = favouriteShopsController.favouriteShops.value?.fav;
    if (data == null || data.isEmpty) {
      return SizedBox.shrink(); // or show a different widget
    } else {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heading(headingText: 'Favourite'),
            Container(
              height: Get.height * .13,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) => ShopCard(
                        onTap: () async {
                          await SharedPrefUtil().setShopId(shopId: data[index].shopId.toString());
                          Get.toNamed(RouteName.mainScreen,
                              arguments: data[index].shopId.toString());
                        },
                        image: data[index].logo,
                        name: data[index].name,
                      )),
            ),
          ],
        ),
      );
    }
  }
}

//Heading is for the heading text of shop category

Widget heading({required headingText}) {
  return Padding(
    padding: const EdgeInsets.only(left: 0, bottom: 13, top: 18),
    child: PrimaryText(
      text: headingText,
      fontSize: 10,
      fontWeight: FontWeight.w500,
    ),
  );
}
