import 'package:get/get.dart';
import 'package:what_shop/controller/shop_data_controller.dart';

class ShopDataControllerBinding extends Bindings {
  @override
  void dependencies() {
    final shopId = Get.arguments;
    Get.lazyPut<ShopDataController>(() => ShopDataController(shopId:shopId));
  }
}