

import 'package:get/get.dart';
import 'package:what_shop/controller/address_controller.dart';
import 'package:what_shop/controller/cart_count_controller.dart';

class CartCountBinding extends Bindings{
  @override
  void dependencies(){

    Get.lazyPut<CartCountController>(()=>CartCountController());
  }


}