// Obx(() {
// if(data?.mainBanners == null){
// return
// }else if(shopDetailsByIdController.isLoading.value){
// return CarouselSlider(
// items: dummyCarousel(
// controller: carouselItems,
// ),
// options: CarouselOptions(
// autoPlayInterval: Duration(seconds: 7),
// viewportFraction: 1.0,
// // Set the desired options for the carousel
// height: 180,
// enlargeCenterPage: false,
//
// autoPlay: true,
// // Enable auto-play
// autoPlayAnimationDuration: Duration(
// milliseconds:
// 500), // Set the auto-play animation duration
// // Set the aspect ratio of each item
// // You can also customize other options such as enlargeCenterPage, enableInfiniteScroll, etc.
// ),
// );
// }else{
// return CarouselSlider(
// items: getCarouselItems1(
// controller: data?.mainBanners,
// ),
// options: CarouselOptions(
// autoPlayInterval: Duration(seconds: 7),
// viewportFraction: 1.0,
// // Set the desired options for the carousel
// height: 180,
// enlargeCenterPage: false,
//
// autoPlay: true,
// // Enable auto-play
// autoPlayAnimationDuration: Duration(
// milliseconds:
// 500), // Set the auto-play animation duration
// // Set the aspect ratio of each item
// // You can also customize other options such as enlargeCenterPage, enableInfiniteScroll, etc.
// ),
// );
// }
// }
//
//
// Container(
//     padding: EdgeInsets.symmetric(horizontal: 10),
//     child: Column(
//       children: [
//         listHeading(context,
//             headingText: 'Featured Products', onTap: () {}),
//         Container(
//           height: 128,
//           child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: 10,
//               itemBuilder: (context, index) => ProductCard(
//                   image: data!.featuredProducts[index].image,
//                   name: data!.featuredProducts[index].name,
//                   offerPrice: data!
//                       .featuredProducts[index].units[0].offerPrice
//                       .toString(),
//                   price: data!
//                       .featuredProducts[index].units[0].price
//                       .toString(),
//                   onTouch: () {})),
//         ),
//       ],
//     )),
// shopDetailsByIdController.isLoading.value ? CarouselSlider(
//   items: dummyCarousel(
//     controller: carouselItems,
//   ),
//   options: CarouselOptions(
//     autoPlayInterval: Duration(seconds: 7),
//     viewportFraction: 1.0,
//     // Set the desired options for the carousel
//     height: 180,
//     enlargeCenterPage: false,
//
//     autoPlay: true,
//     // Enable auto-play
//     autoPlayAnimationDuration: Duration(
//         milliseconds:
//         500), // Set the auto-play animation duration
//     // Set the aspect ratio of each item
//     // You can also customize other options such as enlargeCenterPage, enableInfiniteScroll, etc.
//   ),
// ):   CarouselSlider(
//   items: getCarouselItems2(
//       controller: data?.footerBanners,
//      ),
//   options: CarouselOptions(
//     autoPlayInterval: Duration(seconds: 7),
//     viewportFraction: 1.0,
//     // Set the desired options for the carousel
//     height: 180,
//     enlargeCenterPage: false,
//
//     autoPlay: true,
//     // Enable auto-play
//     autoPlayAnimationDuration: Duration(
//         milliseconds:
//             500), // Set the auto-play animation duration
//     // Set the aspect ratio of each item
//     // You can also customize other options such as enlargeCenterPage, enableInfiniteScroll, etc.
//   ),
// ),
// Container(
//     padding: EdgeInsets.symmetric(horizontal: 10),
//     child: Column(
//       children: [
//         listHeading(context,
//             headingText: 'Trending Products', onTap: () {}),
//         Container(
//           height: 128,
//           child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: 10,
//               itemBuilder: (context, index) => ProductCard(
//                   image: data!.trendingProducts[index].image,
//                   name: data!.trendingProducts[index].name,
//                   offerPrice: data!
//                       .trendingProducts[index].units[0].offerPrice
//                       .toString(),
//                   price: data!
//                       .trendingProducts[index].units[0].price
//                       .toString(),
//                   onTouch: () {})),
//         ),
//       ],
//     )),
// Container(
//     padding: EdgeInsets.symmetric(horizontal: 10),
//     child: Column(
//       children: [
//         listHeading(context,
//             headingText: 'Trending Products', onTap: () {}),
//         Container(
//           height: 128,
//           child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: 10,
//               itemBuilder: (context, index) => ProductCard(
//                   image: data!.popularProducts[index].image,
//                   name: data!.popularProducts[index].name,
//                   offerPrice: data!
//                       .popularProducts[index].units[0].offerPrice
//                       .toString(),
//                   price: data!
//                       .popularProducts[index].units[0].price
//                       .toString(),
//                   onTouch: () {})),
//         ),
//       ],
//     )),
// )