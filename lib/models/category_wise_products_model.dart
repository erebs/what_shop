class CategoryProductResponse {
  final String sts;
  final String msg;
  final ProductData products;

  CategoryProductResponse({
    required this.sts,
    required this.msg,
    required this.products,
  });

  factory CategoryProductResponse.fromJson(Map<String, dynamic> json) {
    return CategoryProductResponse(
      sts: json['sts'] as String,
      msg: json['msg'] as String,
      products: ProductData.fromJson(json['products']),
    );
  }
}

class ProductData {
  final int current_page;
  final List<ProductItem> data;

  ProductData({
    required this.current_page,
    required this.data,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      current_page: json['current_page'] as int,
      data: (json['data'] as List)
          .map((item) => ProductItem.fromJson(item))
          .toList(),
    );
  }
}

class ProductItem {
  final int id;
  final int shopid;
  final String name;
  final String featured;
  final String popular;
  final String trending;
  final String desc;
  final int categoryid;
  final String status;
  final String image;
  final String image2;
  final String image3;
  final String image4;
  final dynamic video;
  final dynamic link;
  final String del_status;

  ProductItem({
    required this.id,
    required this.shopid,
    required this.name,
    required this.featured,
    required this.popular,
    required this.trending,
    required this.desc,
    required this.categoryid,
    required this.status,
    required this.image,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.video,
    required this.link,
    required this.del_status,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id'] as int,
      shopid: json['shopid'] as int,
      name: json['name'] as String,
      featured: json['featured'] as String,
      popular: json['popular'] as String,
      trending: json['trending'] as String,
      desc: json['desc'] as String,
      categoryid: json['categoryid'] as int,
      status: json['status'] as String,
      image: json['image'] as String,
      image2: json['image2'] as String,
      image3: json['image3'] as String,
      image4: json['image4'] as String,
      video: json['video'],
      link: json['link'],
      del_status: json['del_status'] as String,
    );
  }
}
