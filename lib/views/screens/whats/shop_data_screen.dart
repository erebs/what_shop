import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_images.dart';
import 'package:what_shop/constants/app_variables.dart';
import 'package:what_shop/controller/shop_data_controller.dart';
import 'package:what_shop/utils/api_state_enum.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/screens/widget/product_card.dart';
import 'package:what_shop/views/screens/widget/shimmer_container.dart';
import 'package:what_shop/views/widgets/buttons.dart';

class ShopDataScreen extends StatefulWidget {
  ShopDataScreen({Key? key}) : super(key: key);

  @override
  State<ShopDataScreen> createState() => _ShopDataScreen();
}

class _ShopDataScreen extends State<ShopDataScreen> {
  late final ShopDataController shopDataController;
  var dataFromPreveScreen = Get.arguments;

  @override
  void initState() {
    super.initState();
    shopDataController =
        Get.put(ShopDataController(shopId: dataFromPreveScreen));
    WidgetsBinding.instance.addPostFrameCallback((_) {
     Future.delayed(Duration(seconds: 2),() =>showDiscountPoster() ,) ;
      // showDiscountPoster();

    });    // print('data from preve ${dataFromPreveScreen['shopName']}');
  }
  Future<void> showDiscountPoster() async {
    final poster = shopDataController.poster.value;

    if (poster != null) {
      await showBottomSheet(
        enableDrag: false,
        context: context,
        backgroundColor: Colors.transparent,

        builder: (BuildContext context) {
          return Container(
            height: double.infinity,
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.transparent, // Set your desired background color

            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Center(
                child: Container(
                  width:Get.width/1.5,
                 height: 300,
                  color: Colors.transparent,
                  child: Stack(
                    children: [

                      Center(
                        child: Image.network(
                          AppVariables.baseUrl + poster.image,
                          fit: BoxFit.contain,
                          width:Get.width/1.5,
                          height: Get.height/3,
                        ),
                      ),
                      Positioned(
                        right: 0,
                          top: 10,
                          child: SecondaryButton(
                            backgroundColor:AppColors.inputBackgroundColor,
                        borderRadius:3,
                        onTap: (){
                              Get.back();
                        },
                        buttonText: 'close x',
                            height: 25,
                            width:55,
                      ))
                      // Add more content as needed
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          padding: EdgeInsets.only(bottom: 20),
          child: Container(
            child: Obx(() {
              if (shopDataController.featuredProductState.value ==
                      DataState.Loading ||
                  shopDataController.trendingProductState.value ==
                      DataState.Loading ||
                  shopDataController.popularProductState.value ==
                      DataState.Loading) {
                return Container(
                    height: Get.height,
                    child: Center(
                        child: CircularProgressIndicator(
                      color: AppColors.primary,
                    )));
              }

              return Column(
                children: [
                  mainCarousel(),
                  categoryList(),
                  SizedBox(height: 5),
                  featuredProducts(),
                  SizedBox(height: 3),
                  footerCarousel(),
                  SizedBox(height: 3),
                  trendingProducts(),
                  SizedBox(height: 3),
                  popularProducts(),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  //This widget is the items of main banner
  List<Widget> mainCarouselItems() {
    final itemList = shopDataController.banner.value?.firstad;

    if (itemList == null || itemList.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
              width: Get.width,
              height: 190,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    opacity: .3,
                    image: NetworkImage(
                      'https://img.freepik.com/free-photo/purple-store-shop-service-market-supermarket-ecommerce-business-icon-online-shopping-concept-3d-illustration_56104-2114.jpg?w=996&t=st=1699772721~exp=1699773321~hmac=ec180136f67839eed323a59c9e8472a3d50e406fd2f1dc3dd9808ecbe784f478',
                    )),
              )),
        ),
      ];
    }
    return itemList.map((banner) {
      return Container(
          width: Get.width,
          height: 170,
          child: Image.network(AppVariables.baseUrl + (banner.image ?? ''),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Image.asset(AppImages.graphicImage1)));
    }).toList();
  }

  // main banner
  Widget mainCarousel() {
    return Obx(() {
      return CarouselSlider(
        items: mainCarouselItems(),
        options: CarouselOptions(
            height: 190,
            autoPlay: true,
            enlargeCenterPage: false,
            viewportFraction: 1.0,
            pauseAutoPlayOnTouch: true,
            pauseAutoPlayOnManualNavigate: true,
            autoPlayInterval: Duration(seconds: 15),
            autoPlayAnimationDuration: Duration(seconds: 2)),
      );
    });
  }

  //This widget is the items of footer banner
  List<Widget> footerCarouselItems() {
    final itemList = shopDataController.banner.value?.secondad;

    if (itemList == null || itemList.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            width: Get.width,
            height: 190,
            decoration: BoxDecoration(
                color: AppColors.fontOnSecondary,
                borderRadius: BorderRadius.circular(13)),
          ),
        ),
      ];
    }

    // Filtering out any possible null items and returning the list.
    return itemList.where((banner) => banner != null).map((banner) {
      return Container(
          width: Get.width,
          height: 170,
          child: Image.network(AppVariables.baseUrl + (banner.image ?? ''),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Image.asset(AppImages.graphicImage1)));
    }).toList();
  }

  //featured product list
  Widget featuredProducts() {
    return Obx(() {
      if (shopDataController.featuredProductState.value == DataState.Loading) {
        return SizedBox.shrink();
      }

      if (shopDataController.featuredProductState.value == DataState.Error) {
        return SizedBox.shrink();
      }

      if (shopDataController.featuredProductState.value == DataState.Empty) {
        return SizedBox.shrink();
      }

      if (shopDataController.featuredProductState.value == DataState.Data) {
        var data =
            shopDataController.featuredProducts.value?.featuredproducts?.data;
        return Container(
          decoration:
              BoxDecoration(color: AppColors.fontOnSecondary, boxShadow: [
            BoxShadow(
                color: AppColors.lightGrey,
                offset: Offset(0, -1),
                spreadRadius: 0,
                blurRadius: 4),
            BoxShadow(
                color: AppColors.lightGrey,
                offset: Offset(0, 1),
                spreadRadius: 0,
                blurRadius: 2),
          ]),
          child: Column(
            children: [
              listHeading(context, headingText: 'Featured products', onTap: () {
                Get.toNamed(RouteName.allProductsScreen, arguments: {
                  'screen_name': 'Featured Products ',
                  'endPoint': 'featured_products',
                  'category': 'featuredproducts'
                });
              }),
              Container(
                height: 130,
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.only(left: 10, bottom: 15),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                        marginRight: 15,
                        name: data[index].name ?? '...',
                        image: data[index].image,
                        onTouch: () {
                          Get.toNamed(RouteName.productDetailsScreen,
                              arguments: data[index].id.toString());
                        });
                  },
                ),
              ),
            ],
          ),
        );
      }

      return Text('Error outside');
    });
  }

  // footer banner
  Widget footerCarousel() {
    return Obx(() {
      if (shopDataController.banner.value!.secondad!.isEmpty) {
        return SizedBox();
      }
      return CarouselSlider(
        items: footerCarouselItems(),
        options: CarouselOptions(
            height: 190,
            autoPlay: true,
            enlargeCenterPage: false,
            viewportFraction: 1.0,
            pauseAutoPlayOnTouch: true,
            pauseAutoPlayOnManualNavigate: true,
            autoPlayInterval: Duration(seconds: 15),
            autoPlayAnimationDuration: Duration(seconds: 3)),
      );
    });
  }

  //Trending product list
  Widget trendingProducts() {
    return Obx(() {
      if (shopDataController.trendingProductState.value == DataState.Loading) {
        return SizedBox.shrink();
      }
      // Check for NULL state or error in fetching data
      if (shopDataController.trendingProductState.value == DataState.Error) {
        return SizedBox.shrink();
      }
      if (shopDataController.trendingProductState.value == DataState.Empty) {
        return SizedBox.shrink();
      }
      if (shopDataController.trendingProductState.value == DataState.Data) {
        var data =
            shopDataController.trendingProducts.value?.trendingproducts?.data;
        return Container(
          decoration:
              BoxDecoration(color: AppColors.fontOnSecondary, boxShadow: [
            BoxShadow(
                color: AppColors.lightGrey,
                offset: Offset(0, -1),
                spreadRadius: 0,
                blurRadius: 4),
          ]),
          child: Column(
            children: [
              listHeading(context, headingText: 'Trending products', onTap: () {
                Get.toNamed(RouteName.allProductsScreen, arguments: {
                  'screen_name': 'Trending Products ',
                  'endPoint': 'trending_products',
                  'category': 'trendingproducts'
                });
              }),
              Container(
                height: 130,
                color: AppColors.fontOnSecondary,
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.only(left: 10, bottom: 15),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                        marginRight: 15,
                        name: data[index].name ?? '...',
                        image: data[index].image,
                        onTouch: () {
                          Get.toNamed(RouteName.productDetailsScreen,
                              arguments: data[index].id.toString());
                        });
                  },
                ),
              ),
            ],
          ),
        );
      }
      return Text('Error outside');
    });
  }

  //popular products
  Widget popularProducts() {
    return Obx(() {
      if (shopDataController.popularProductState.value == DataState.Loading) {
        return SizedBox.shrink();
      }

      // Check for NULL state or error in fetching data
      if (shopDataController.popularProductState.value == DataState.Error) {
        return SizedBox.shrink();
      }

      if (shopDataController.popularProductState.value == DataState.Empty) {
        return SizedBox.shrink();
      }

      if (shopDataController.popularProductState.value == DataState.Data) {
        var data =
            shopDataController.popularProducts.value?.popularproducts?.data;
        return Container(
          color: AppColors.fontOnSecondary,
          child: Column(
            children: [
              listHeading(context, headingText: 'Popular products', onTap: () {
                Get.toNamed(RouteName.allProductsScreen, arguments: {
                  'screen_name': 'Popular Products ',
                  'endPoint': 'popular_products',
                  'category': 'popularproducts'
                });
              }),
              Container(
                height: 130,
                color: AppColors.fontOnSecondary,
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.only(left: 10, bottom: 15),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data!.length,
                  padding: EdgeInsets.only(right: 10),
                  itemBuilder: (context, index) {
                    return ProductCard(
                        name: data[index].name ?? 'NA',
                        image: data[index].image,
                        marginRight: 15,
                        onTouch: () {
                          Get.toNamed(RouteName.productDetailsScreen,
                              arguments: data[index].id.toString());
                        });
                  },
                ),
              ),
            ],
          ),
        );
      }

      return Text('Error outside');
    });
  }

  Widget listHeading(BuildContext context,
      {required headingText, required onTap}) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 13, left: 20, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PrimaryText(
            text: headingText,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          TouchableOpacity(
            onTap: onTap,
            child: const Text(
              'View all',
              style: TextStyle(color: AppColors.primary, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }

  Widget categoryList() {
    return Obx(() {
      if (shopDataController.categoryResponseState == DataState.Empty) {
        return SizedBox.shrink();
      }
      return Container(
        child: Column(
          children: [
            listHeading(context, headingText: 'Top Categories', onTap: () {
              Get.toNamed(RouteName.allCategoryScreen);
            }),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: shopDataController
                    .categoryResponse.value?.categories.length,
                itemBuilder: (context, index) => categoryCard(
                    image: shopDataController
                        .categoryResponse.value?.categories[index].image,
                    name: shopDataController
                        .categoryResponse.value?.categories[index].name,
                    onTap: () {
                      Get.toNamed(RouteName.categoryWiseProductScreen,
                          arguments: {
                            // passing category id and screen that to show on app bar to category wise product screen
                            'screenName': shopDataController
                                .categoryResponse.value?.categories[index].name,
                            'categoryId': shopDataController
                                .categoryResponse.value?.categories[index].id,
                          });
                    }),
              ),
            ),
          ],
        ),
      );
    });
  }

// components
// category card
  Widget categoryCard({String? image, String? name, VoidCallback? onTap}) {
    return TouchableOpacity(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 10),
        width: 90,
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.lightGrey,
              backgroundImage: image != null
                  ? NetworkImage(AppVariables.baseUrl + image)
                  : null,
            ),
            SizedBox(
              height: 5,
            ),
            Wrap(children: [PrimaryText(text: name ?? '...')])
          ],
        ),
      ),
    );
  }
}
