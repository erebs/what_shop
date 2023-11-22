class ProductDetailsModel {
  ProductDetailsModel({
    required this.sts,
    required this.msg,
    required this.isFavorite,
    required this.product,
    required this.units,
    required this.relatedProducts,
  });
  late final String sts;
  late final String msg;
  late final bool isFavorite;
  late final Product product;
  late final List<Units> units;
  late final List<RelatedProducts> relatedProducts;

  ProductDetailsModel.fromJson(Map<String, dynamic> json){
    sts = json['sts'];
    msg = json['msg'];
    isFavorite = json['is_favorite'];
    product = Product.fromJson(json['product']);
    units = List.from(json['units']).map((e)=>Units.fromJson(e)).toList();
    relatedProducts = List.from(json['related_products']).map((e)=>RelatedProducts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sts'] = sts;
    _data['msg'] = msg;
    _data['is_favorite'] = isFavorite;
    _data['product'] = product.toJson();
    _data['units'] = units.map((e)=>e.toJson()).toList();
    _data['related_products'] = relatedProducts.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Product {
  Product({
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
    this.video,
    this.link,
    required this.delStatus,
  });
  late final int id;
  late final int shopid;
  late final String name;
  late final String featured;
  late final String popular;
  late final String trending;
  late final String desc;
  late final int categoryid;
  late final String status;
  late final String image;
  late final String image2;
  late final String image3;
  late final String image4;
  late final Null video;
  late final Null link;
  late final String delStatus;

  Product.fromJson(Map<String, dynamic> json){
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
    video = null;
    link = null;
    delStatus = json['del_status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['shopid'] = shopid;
    _data['name'] = name;
    _data['featured'] = featured;
    _data['popular'] = popular;
    _data['trending'] = trending;
    _data['desc'] = desc;
    _data['categoryid'] = categoryid;
    _data['status'] = status;
    _data['image'] = image;
    _data['image2'] = image2;
    _data['image3'] = image3;
    _data['image4'] = image4;
    _data['video'] = video;
    _data['link'] = link;
    _data['del_status'] = delStatus;
    return _data;
  }
}

class Units {
  Units({
    required this.id,
    required this.productid,
    required this.name,
    required this.price,
    required this.offerprice,
    required this.status,
    required this.dispOrder,
    required this.deliveryCharge,
    required this.cgst,
    required this.sgst,
    required this.delStatus,
  });
  late final int id;
  late final int productid;
  late final String name;
  late final int price;
  late final int offerprice;
  late final String status;
  late final int dispOrder;
  late final int deliveryCharge;
  late final int cgst;
  late final int sgst;
  late final String delStatus;

  Units.fromJson(Map<String, dynamic> json){
    id = json['id'];
    productid = json['productid'];
    name = json['name'];
    price = json['price'];
    offerprice = json['offerprice'];
    status = json['status'];
    dispOrder = json['disp_order'];
    deliveryCharge = json['delivery_charge'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    delStatus = json['del_status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['productid'] = productid;
    _data['name'] = name;
    _data['price'] = price;
    _data['offerprice'] = offerprice;
    _data['status'] = status;
    _data['disp_order'] = dispOrder;
    _data['delivery_charge'] = deliveryCharge;
    _data['cgst'] = cgst;
    _data['sgst'] = sgst;
    _data['del_status'] = delStatus;
    return _data;
  }
}

class RelatedProducts {
  RelatedProducts({
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
    this.video,
    this.link,
    required this.delStatus,
  });
  late final int id;
  late final int shopid;
  late final String name;
  late final String featured;
  late final String popular;
  late final String trending;
  late final String desc;
  late final int categoryid;
  late final String status;
  late final String image;
  late final String image2;
  late final String image3;
  late final String image4;
  late final Null video;
  late final Null link;
  late final String delStatus;

  RelatedProducts.fromJson(Map<String, dynamic> json){
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
    video = null;
    link = null;
    delStatus = json['del_status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['shopid'] = shopid;
    _data['name'] = name;
    _data['featured'] = featured;
    _data['popular'] = popular;
    _data['trending'] = trending;
    _data['desc'] = desc;
    _data['categoryid'] = categoryid;
    _data['status'] = status;
    _data['image'] = image;
    _data['image2'] = image2;
    _data['image3'] = image3;
    _data['image4'] = image4;
    _data['video'] = video;
    _data['link'] = link;
    _data['del_status'] = delStatus;
    return _data;
  }
}