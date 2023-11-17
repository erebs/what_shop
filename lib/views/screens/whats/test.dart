import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_shop/controller/test_controller.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override

  final controller = Get.put(HomeController());
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
