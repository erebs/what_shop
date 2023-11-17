import 'package:get/get.dart';
import 'package:what_shop/models/category_model.dart';
import 'package:what_shop/utils/api_services.dart';

class CategoryController extends GetxController{

  RxBool isLoading = false.obs;
//  storing variable
  Rx<CategoryResponse> categoryResponse = CategoryResponse(sts: '', msg: '', categories: []).obs;


  void getCategories({required String shopId})async{

    try{
      isLoading.value = true;
      final response = ApiService().post(endPoint: 'shopcategories',body: {
        'shopid':shopId
      });
    }catch(e){

    }

  }

}