// class CategoryProductResponse {
//   final String sts;
//   final String msg;
//   final ProductData products;
//
//   CategoryProductResponse({
//     required this.sts,
//     required this.msg,
//     required this.products,
//   });
//
//   factory CategoryProductResponse.fromJson(Map<String, dynamic> json) {
//     return CategoryProductResponse(
//       sts: json['sts'] as String,
//       msg: json['msg'] as String,
//       products: ProductData.fromJson(json['products']),
//     );
//   }
// }
//
// class ProductData {
//   final int current_page;
//   final List<ProductItem> data;
//
//   ProductData({
//     required this.current_page,
//     required this.data,
//   });
//
//   factory ProductData.fromJson(Map<String, dynamic> json) {
//     return ProductData(
//       current_page: json['current_page'] as int,
//       data: (json['data'] as List)
//           .map((item) => ProductItem.fromJson(item))
//           .toList(),
//     );
//   }
// }
//
// class ProductItem {
//   final int id;
//   final int shopid;
//   final String name;
//   final String featured;
//   final String popular;
//   final String trending;
//   final String desc;
//   final int categoryid;
//   final String status;
//   final String image;
//   final String image2;
//   final String image3;
//   final String image4;
//   final dynamic video;
//   final dynamic link;
//   final String del_status;
//   final bool? isFavourite;
//   ProductItem({
//     required this.id,
//     required this.shopid,
//     required this.name,
//     required this.featured,
//     required this.popular,
//     required this.trending,
//     required this.desc,
//     required this.categoryid,
//     required this.status,
//     required this.image,
//     required this.image2,
//     required this.image3,
//     required this.image4,
//     required this.video,
//     required this.link,
//     required this.del_status,
//     this.isFavourite,
//   });
//
//   factory ProductItem.fromJson(Map<String, dynamic> json) {
//     return ProductItem(
//       id: json['id'] as int,
//       shopid: json['shopid'] as int,
//       name: json['name'] as String,
//       featured: json['featured'] as String,
//       popular: json['popular'] as String,
//       trending: json['trending'] as String,
//       desc: json['desc'] as String,
//       categoryid: json['categoryid'] as int,
//       status: json['status'] as String,
//       image: json['image'] as String,
//       image2: json['image2'] as String,
//       image3: json['image3'] as String,
//       image4: json['image4'] as String,
//       video: json['video'],
//       link: json['link'],
//       del_status: json['del_status'] as String,
//         isFavourite:json['is_favorite'] as bool,
//     );
//   }
// }


class CategoryWiseProductModel {
  String? sts;
  String? msg;
  Products? products;

  CategoryWiseProductModel({this.sts, this.msg, this.products});

  CategoryWiseProductModel.fromJson(Map<String, dynamic> json) {
    sts = json['sts'];
    msg = json['msg'];
    products = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sts'] = this.sts;
    data['msg'] = this.msg;
    if (this.products != null) {
      data['products'] = this.products!.toJson();
    }
    return data;
  }
}

class Products {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Products(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Products.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  int? id;
  int? shopid;
  String? name;
  String? featured;
  String? popular;
  String? trending;
  String? desc;
  int? categoryid;
  String? status;
  String? image;
  String? image2;
  String? image3;
  String? image4;
  Null? video;
  Null? link;
  String? delStatus;

  Data(
      {this.id,
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
        this.delStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopid = json['shopid'];
    name = json['name'];
    featured = json['featured'];
    popular = json['popular'];
    trending = json['trending'];
    desc = json['desc'];
    categoryid = json['categoryid'];
    status = json['status'];
    image = json['image'];
    image2 = json['image2'];
    image3 = json['image3'];
    image4 = json['image4'];
    video = json['video'];
    link = json['link'];
    delStatus = json['del_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shopid'] = this.shopid;
    data['name'] = this.name;
    data['featured'] = this.featured;
    data['popular'] = this.popular;
    data['trending'] = this.trending;
    data['desc'] = this.desc;
    data['categoryid'] = this.categoryid;
    data['status'] = this.status;
    data['image'] = this.image;
    data['image2'] = this.image2;
    data['image3'] = this.image3;
    data['image4'] = this.image4;
    data['video'] = this.video;
    data['link'] = this.link;
    data['del_status'] = this.delStatus;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
