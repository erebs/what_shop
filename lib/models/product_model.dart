class ProductResponse {
  final String? sts;
  final String? msg;
  final ProductsList? featuredproducts;
  final ProductsList? trendingproducts;
  final ProductsList? popularproducts;
  final String? shopstatus;
  final String? theme;

  ProductResponse({
    this.sts,
    this.msg,
    this.featuredproducts,
    this.trendingproducts,
    this.popularproducts,
    this.shopstatus,
    this.theme,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      sts: json['sts'],
      msg: json['msg'],
      featuredproducts: json['featuredproducts'] != null
          ? ProductsList.fromJson(json['featuredproducts'])
          : null,
      trendingproducts: json['trendingproducts'] != null
          ? ProductsList.fromJson(json['trendingproducts'])
          : null,
      popularproducts: json['popularproducts'] != null
          ? ProductsList.fromJson(json['popularproducts'])
          : null,
      shopstatus: json['shopstatus'],
      theme: json['theme'],
    );
  }
}

class ProductsList {
  final int? currentPage;
  final List<Product>? data;
  final String? firstPageUrl;
  final String? lastPageUrl;
  final List<Link>? links;
  final String? nextPageUrl;
  final int? perPage;
  final String? path;
  final int? total;
  final int? lastPage;

  ProductsList({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.perPage,
    this.path,
    this.total,
    this.lastPage,
  });

  factory ProductsList.fromJson(Map<String, dynamic> json) {
    return ProductsList(
      currentPage: json['current_page'],
      data: (json['data'] as List).map((item) => Product.fromJson(item)).toList(),
      firstPageUrl: json['first_page_url'],
      lastPageUrl: json['last_page_url'],
      lastPage: json['last_page'],
      links: (json['links'] as List).map((item) => Link.fromJson(item)).toList(),
      nextPageUrl: json['next_page_url'],
      perPage: json['per_page'],
      path: json['path'],
      total: json['total'],
    );
  }
}

class Product {
  final int? id;
  final int? shopid;
  final String? name;
  final String? featured;
  final String? popular;
  final String? trending;
  final String? desc;
  final int? categoryid;
  final String? status;
  final String? image;
  final String? image2;
  final String? image3;
  final String? image4;
  final String? video;
  final String? link;
  final bool? isFavourite;
 final String? delStatus;
  Product({
    this.id,
    this.shopid,
    this.name,
    this.featured,
    this.popular,
    this.trending,
    this.desc,
    this.categoryid,
    this.status,
    this.image,
    this.image2,
    this.image3,
    this.image4,
    this.video,
    this.link,
    this.isFavourite,
    this.delStatus

});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      shopid: json['shopid'],
      name: json['name'],
      featured: json['featured'],
      popular: json['popular'],
      trending: json['trending'],
      desc: json['desc'],
      categoryid: json['categoryid'],
      status: json['status'],
      image: json['image'],
      image2: json['image2'],
      image3: json['image3'],
      image4: json['image4'],
      video: json['video'],
      link: json['link'],
      delStatus:json['del_status'],
      isFavourite: json['is_favorite']
    );
  }
}

class Link {
  final String? url;
  final String? label;
  final bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }
}
