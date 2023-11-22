class ShopDetailsByIdModel {
  final String sts;
  final String msg;
  final List<MainBanner> mainBanners;
  final List<FooterBanner> footerBanners;
  final List<TrendingProduct> trendingProducts;
  final List<FeaturedProduct> featuredProducts;
  final List<PopularProduct> popularProducts;
  final String shopStatus;
  final String theme;

  ShopDetailsByIdModel({
    required this.sts,
    required this.msg,
    required this.mainBanners,
    required this.footerBanners,
    required this.trendingProducts,
    required this.featuredProducts,
    required this.popularProducts,
    required this.shopStatus,
    required this.theme,
  });

  factory ShopDetailsByIdModel.fromJson(Map<String, dynamic> json) {
    return ShopDetailsByIdModel(
      sts: json['sts'],
      msg: json['msg'],
      mainBanners: (json['mainbanners'] as List)
          .map((i) => MainBanner.fromJson(i))
          .toList(),
      footerBanners: (json['footerbanners'] as List)
          .map((i) => FooterBanner.fromJson(i))
          .toList(),
      trendingProducts: (json['trendingproducts'] as List)
          .map((i) => TrendingProduct.fromJson(i))
          .toList(),
      featuredProducts: (json['featuredproducts'] as List)
          .map((i) => FeaturedProduct.fromJson(i))
          .toList(),
      popularProducts: (json['popularproducts'] as List)
          .map((i) => PopularProduct.fromJson(i))
          .toList(),
      shopStatus: json['shopstatus'],
      theme: json['theme'],
    );
  }
}

class MainBanner {
  final int id;
  final int sellerId;
  final String type;
  final String image;
  final String title;
  final String url;

  MainBanner({
    required this.id,
    required this.sellerId,
    required this.type,
    required this.image,
    required this.title,
    required this.url,
  });

  factory MainBanner.fromJson(Map<String, dynamic> json) {
    return MainBanner(
      id: json['id'],
      sellerId: json['sellerid'],
      type: json['type'],
      image: json['image'],
      title: json['title'],
      url: json['url'],
    );
  }
}

class FooterBanner {
  final int id;
  final int sellerId;
  final String type;
  final String image;
  final String title;
  final String url;

  FooterBanner({
    required this.id,
    required this.sellerId,
    required this.type,
    required this.image,
    required this.title,
    required this.url,
  });

  factory FooterBanner.fromJson(Map<String, dynamic> json) {
    return FooterBanner(
      id: json['id'],
      sellerId: json['sellerid'],
      type: json['type'],
      image: json['image'],
      title: json['title'],
      url: json['url'],
    );
  }
}


class TrendingProduct {
  final int id;
  final String name;
  final String featured;
  final String popular;
  final String trending;
  final String desc;
  final int categoryId;
  final String status;
  final String image;
  final String categoryname;
  final List<Unit> units;

  TrendingProduct({
    required this.id,
    required this.name,
    required this.featured,
    required this.popular,
    required this.trending,
    required this.desc,
    required this.categoryId,
    required this.status,
    required this.image,
    required this.categoryname,
    required this.units,
  });

  factory TrendingProduct.fromJson(Map<String, dynamic> json) {
    return TrendingProduct(
      id: json['id'],
      name: json['name'],
      featured: json['featured'],
      popular: json['popular'],
      trending: json['trending'],
      desc: json['desc'],
      categoryId: json['categoryid'],
      status: json['status'],
      image: json['image'],
      categoryname: json['categoryname'],
      units: (json['units'] as List).map((i) => Unit.fromJson(i)).toList(),
    );
  }
}

class FeaturedProduct {
  final int id;
  final String name;
  final String featured;
  final String popular;
  final String trending;
  final String desc;
  final int categoryId;
  final String status;
  final String image;
  final String categoryname;
  final List<Unit> units;

  FeaturedProduct({
    required this.id,
    required this.name,
    required this.featured,
    required this.popular,
    required this.trending,
    required this.desc,
    required this.categoryId,
    required this.status,
    required this.image,
    required this.categoryname,
    required this.units,
  });

  factory FeaturedProduct.fromJson(Map<String, dynamic> json) {
    return FeaturedProduct(
      id: json['id'],
      name: json['name'],
      featured: json['featured'],
      popular: json['popular'],
      trending: json['trending'],
      desc: json['desc'],
      categoryId: json['categoryid'],
      status: json['status'],
      image: json['image'],
      categoryname: json['categoryname'],
      units: (json['units'] as List).map((i) => Unit.fromJson(i)).toList(),
    );
  }
}

class PopularProduct {
  final int id;
  final String name;
  final String featured;
  final String popular;
  final String trending;
  final String desc;
  final int categoryId;
  final String status;
  final String image;
  final String categoryname;
  final List<Unit> units;

  PopularProduct({
    required this.id,
    required this.name,
    required this.featured,
    required this.popular,
    required this.trending,
    required this.desc,
    required this.categoryId,
    required this.status,
    required this.image,
    required this.categoryname,
    required this.units,
  });

  factory PopularProduct.fromJson(Map<String, dynamic> json) {
    return PopularProduct(
      id: json['id'],
      name: json['name'],
      featured: json['featured'],
      popular: json['popular'],
      trending: json['trending'],
      desc: json['desc'],
      categoryId: json['categoryid'],
      status: json['status'],
      image: json['image'],
      categoryname: json['categoryname'],
      units: (json['units'] as List).map((i) => Unit.fromJson(i)).toList(),
    );
  }
}


class Unit {
  final int id;
  final int productId;
  final String name;
  final double price;
  final double offerPrice;
  final String status;
  final int dispOrder;
  final int deliveryCharge;

  Unit({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.offerPrice,
    required this.status,
    required this.deliveryCharge,
    required this.dispOrder
  });

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json['id'],
      productId: json['productid'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      offerPrice: (json['offerprice'] as num).toDouble(),
      status: json['status'],
      dispOrder: json['disp_order'],
      deliveryCharge: json['delivery_charge'],

    );
  }
}
