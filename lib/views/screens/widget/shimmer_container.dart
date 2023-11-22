import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:what_shop/constants/app_colors.dart';

// this is a container that is used to build shimmer effect widgets.


class ShimmerContainer extends StatelessWidget {
  final double? width;
  final double? height;

  ShimmerContainer({Key? key,this.width,this.height}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor:Colors.grey.shade300,
      highlightColor:AppColors.inputBackgroundColor,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.circular(6)
        ),
        height:height ?? 100,
        width:width,
      ),
    );
  }
}
class ProductTileShimmerList extends StatelessWidget {
  const ProductTileShimmerList({super.key});

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount:8,itemBuilder: (context,index)=>productTileShimmer());

  }
  Widget productTileShimmer(){
    return Container(
      height: 100,
      width: Get.width,

      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      margin: EdgeInsets.only(bottom:5),
      color: AppColors.fontOnSecondary,
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: ShimmerContainer(height: 100,)
          ),
          SizedBox(width: 10,),
          Expanded(
              flex: 5,
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerContainer(height: 25,),

                  SizedBox(height: 13,width: Get.width,),
                  ShimmerContainer(height: 20,width: Get.width/1.8,),


                ],
              ))
        ],
      ),
    );
  }
}