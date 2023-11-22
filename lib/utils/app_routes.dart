import 'package:get/get.dart';
import 'package:what_shop/controller/controller_bindings/address_controller_bindings.dart';
import 'package:what_shop/controller/controller_bindings/cart_controller_binding.dart';
import 'package:what_shop/controller/controller_bindings/shop_data_controller_binding.dart';

import 'package:what_shop/views/screens/authentication/forgot_screen.dart';
import 'package:what_shop/views/screens/authentication/login_screen.dart';
import 'package:what_shop/views/screens/common/placeorder_success_screen.dart';
import 'package:what_shop/views/screens/whats/add_address_screen.dart';
import 'package:what_shop/views/screens/whats/address_screen.dart';
import 'package:what_shop/views/screens/whats/all_categories_screen.dart';
import 'package:what_shop/views/screens/whats/all_favourite_products_screen.dart';
import 'package:what_shop/views/screens/whats/all_products_screen.dart';
import 'package:what_shop/views/screens/whats/category_wise_products_screen.dart';
import 'package:what_shop/views/screens/whats/change_password_screen.dart';
import 'package:what_shop/views/screens/whats/order_history_screen.dart';
import 'package:what_shop/views/screens/whats/search_screen.dart';
import 'package:what_shop/views/screens/whats/cart_screen.dart';
import 'package:what_shop/views/screens/whats/edit_address_screen.dart';
import 'package:what_shop/views/screens/whats/edit_profile_screen.dart';
import 'package:what_shop/views/screens/whats/order_details_screen.dart';
import 'package:what_shop/views/screens/whats/product_details_screen.dart';
import 'package:what_shop/views/screens/whats/main_screen.dart';
import 'package:what_shop/views/screens/whats/home_screen.dart';

class RouteName {
  static const String loginScreen = '/login_screen';
  static const String forgetPasswordScreen = '/forget_password_screen';
  static const String homeScreen = '/whatScreen';
  static const String allShopsScreen = '/allShopsScreen';
  static const String mainScreen = '/mainScreen';
  static const String orderDetailsScreen = '/orderDetailsScreen';
  static const String addressScreen = '/addressScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String addAddressScreen = '/addAddressScreen';
  static const String cartScreen = '/cartScreen';
  static const String productDetailsScreen = '/productDetailsScreen';
  static const String editAddressScreen = '/editAddressScreen';
  static const String allProductsScreen = '/allProductsScreen';
  static const String orderHistoryScreen = '/orderHistoryScreen';
  static const String changePasswordScreen = '/changePasswordScreen';
  static const String placeOrderSuccessScreen = '/placeOrderSuccessScreen';
  static const String allCategoryScreen = '/allCategoryScreen';
  static const String categoryWiseProductScreen = '/categoryWiseProductScreen';
  static const String allFavouriteProductsScreen = '/allFavouriteProductsScreen';

}

class AppRoutes {
  static List<GetPage> appRoute() => [
        GetPage(name: RouteName.loginScreen, page: () => const LoginScreen()),
        GetPage(
            name: RouteName.forgetPasswordScreen,
            page: () => const ForgotScreen()),
        GetPage(name: RouteName.homeScreen, page: () => const HomeScreen()),
        GetPage(
            name: RouteName.allShopsScreen,
            page: () => const SearchScreen(),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 200)),
        GetPage(
            name: RouteName.mainScreen,
            page: () {
              return  MainScreen();
            }
            ,
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 200)),
        GetPage(
            name: RouteName.orderDetailsScreen,
            page: () => const OrderDetailsScreen(),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 200)),
        GetPage(
            name: RouteName.addressScreen,
            page: () => const AddressScreen(),
            binding: AddressBinding(),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 200)),
        GetPage(
            name: RouteName.editProfileScreen,
            page: () => const EditProfileScreen(),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 200)),
        GetPage(
            name: RouteName.addAddressScreen,
            page: () => const AddAddressScreen(),
            binding: AddressBinding(),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 200)),
        GetPage(
            name: RouteName.cartScreen,
            page: () => const CartScreen(),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 200)),
        GetPage(
            name: RouteName.productDetailsScreen,
            page: () => const ProductDetailsScreen(),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 200)),
        GetPage(
            name: RouteName.editAddressScreen,
            page: () => const EditAddressScreen(),
            binding: AddressBinding(),
            transition: Transition.leftToRight,
            transitionDuration: Duration(milliseconds: 200)),
    GetPage(
        name: RouteName.allProductsScreen,
        page: () => const AllProductsScreen(),
        binding: AddressBinding(),
        transition: Transition.leftToRight,
        transitionDuration: Duration(milliseconds: 200)),
    GetPage(
        name: RouteName.orderHistoryScreen,
        page: () => const OrderHistoryScreen(),
        binding: AddressBinding(),
        transition: Transition.leftToRight,
        transitionDuration: Duration(milliseconds: 200)),
    GetPage(
        name: RouteName.changePasswordScreen,
        page: () => const ChangePasswordScreen(),
        binding: AddressBinding(),
        transition: Transition.leftToRight,
        transitionDuration: Duration(milliseconds: 200)),
    GetPage(
        name: RouteName.placeOrderSuccessScreen,
        page: () => const PlaceOrderSuccessScreen(),
        transition: Transition.leftToRight,
        transitionDuration: Duration(milliseconds: 200)),
    GetPage(
        name: RouteName.allCategoryScreen,
        page: () => const AllCategoryScreen(),
        transition: Transition.leftToRight,
        transitionDuration: Duration(milliseconds: 200)),
    GetPage(
        name: RouteName.categoryWiseProductScreen,
        page: () => const CategoryWiseProductScreen(),
        transition: Transition.leftToRight,
        transitionDuration: Duration(milliseconds: 200)),
    GetPage(
        name: RouteName.allFavouriteProductsScreen,
        page: () => const AllFavouriteProductsScreen(),
        transition: Transition.leftToRight,
        transitionDuration: Duration(milliseconds: 200)),
      ];
}
