import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:what_shop/constants/app_colors.dart';
import 'package:what_shop/constants/app_variables.dart';
import 'package:what_shop/controller/cart_controller.dart';
import 'package:what_shop/controller/shop_data_controller.dart';
import 'package:what_shop/utils/app_routes.dart';
import 'package:what_shop/views/screens/widget/primary_text.dart';
import 'package:what_shop/views/screens/widget/secondary_custom_app_bar.dart';



class AllCategoryScreen extends StatefulWidget {

  const AllCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}
  class _AllCategoryScreenState extends State<AllCategoryScreen>{
 // screen variables
 final  ShopDataController shopDataController = Get.find();
  //-----------
  @override
    Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        appBar: SecondaryCustomAppBar(title:'Category',),
        body: Container(
          // height: Get.height,

          color: AppColors.inputBackgroundColor,
          padding: EdgeInsets.only(top: 20,right: 5,left: 5),
          child: Obx((){
            final data = shopDataController.categoryResponse.value?.categories;
return  GridView.builder(
  itemCount: data?.length,
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 3,
  mainAxisSpacing: 20,
  crossAxisSpacing: 10,

), itemBuilder: (context, index) {
  return categoryCard(
      image:data?[index].image,
      name:data?[index].name,
    onTap: (){
      Get.toNamed(RouteName.categoryWiseProductScreen, arguments: {
        // passing category id and screen that to show on app bar to category wise product screen
        'screenName':data?[index].name,
        'categoryId': data?[index].id,
      });
    }
  );
},);
          })

         )
        ),

    );
  }
 Widget categoryCard({String? image, String? name,VoidCallback? onTap}) {
   return TouchableOpacity(
     onTap: onTap,
     child: Container(
       margin: EdgeInsets.only(left: 10),
       padding: EdgeInsets.symmetric(horizontal: 5),

       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Expanded(
             flex: 3,
             child: CircleAvatar(
               radius: 50,
               backgroundColor: AppColors.lightGrey,
               backgroundImage: image != null
                   ? NetworkImage(AppVariables.baseUrl + image)
                   : null,
             ),
           ),
           SizedBox(
             height: 10,
           ),
           Expanded(child: Wrap(children: [PrimaryText(text: name ?? '...')]))
         ],
       ),
     ),
   );
 }
}