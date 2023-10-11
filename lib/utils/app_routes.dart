

import 'package:get/get.dart';
import 'package:what_shop/views/screens/authentication/forgot_screen.dart';
import 'package:what_shop/views/screens/authentication/login_screen.dart';
import 'package:what_shop/views/screens/whats/address_screen.dart';
import 'package:what_shop/views/screens/whats/all_shops_listing_screen.dart';
import 'package:what_shop/views/screens/whats/order_history_screen.dart';
import 'package:what_shop/views/screens/whats/shop_details_screen.dart';
import 'package:what_shop/views/screens/whats/whats_screen.dart';

class RouteName{
static const String loginScreen = '/login_screen';
static const String forgetPasswordScreen = '/forget_password_screen';
static const String homeScreen = '/whatScreen';
static const String allShopsScreen = '/allShopsScreen';
static const String shopDetailsScreen = '/shopDetailsScreen';
static const String orderHistoryScreen = '/orderHistoryScreen';
static const String addressScreen = '/addressScreen';



}

class AppRoutes{
static List<GetPage> appRoute() =>[
  GetPage(name:RouteName.loginScreen,page:()=>const LoginScreen()),
  GetPage(name:RouteName.forgetPasswordScreen,page:()=>const ForgotScreen()),
  GetPage(name:RouteName.homeScreen,page:()=>const WhatScreen()),
GetPage(name:RouteName.allShopsScreen,page:()=>const AllShopsScreen(),transition: Transition.leftToRight,transitionDuration:Duration(milliseconds:200)),
  GetPage(name:RouteName.shopDetailsScreen,page:()=>const ShopDetailsScreen(),transition: Transition.leftToRight,transitionDuration:Duration(milliseconds:200)),
  GetPage(name:RouteName.orderHistoryScreen,page:()=>const OrderHistoryScreen(),transition: Transition.leftToRight,transitionDuration:Duration(milliseconds:200)),
  GetPage(name:RouteName.addressScreen,page:()=>const AddressScreen(),transition: Transition.leftToRight,transitionDuration:Duration(milliseconds:200)),


];}