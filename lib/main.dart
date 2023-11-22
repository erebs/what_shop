import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/views/screens/authentication/splash_screen.dart';
import 'package:what_shop/views/screens/whats/test.dart';

// Note
// location package file not added for ios

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages:AppRoutes.appRoute(),
      title: 'Whatsappshop',
      home: SplashScreen(),
    );
  }
}
