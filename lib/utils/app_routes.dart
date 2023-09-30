

import 'package:get/get.dart';
import 'package:what_shop/views/screens/authentication/login_screen.dart';

class RouteName{
static const String loginScreen = '/login_screen';

}

class AppRoutes{
static List<GetPage> appRoute() =>[
  GetPage(name:RouteName.loginScreen,page:()=>LoginScreen()),
];}