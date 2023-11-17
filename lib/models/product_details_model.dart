class ProductResponse {
  final String sts;
  final String msg;
  final Product product;
  final List<Unit> units;

  ProductResponse({required this.sts, required this.msg, required this.product, required this.units});

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      sts: json['sts'],
      msg: json['msg'],
      product: Product.fromJson(json['product']),
      units: List<Unit>.from(json['units'].map((x) => Unit.fromJson(x))),
    );
  }
}

class Product {
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
  final String? video;
  final String? link;

  Product({required this.id, required this.shopid, required this.name, required this.featured, required this.popular, required this.trending, required this.desc, required this.categoryid, required this.status, required this.image, required this.image2, required this.image3, required this.image4, this.video, this.link});

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
    );
  }
}

class Unit {
  final int id;
  final int productid;
  final String name;
  final int price;
  final int offerprice;
  final String status;
  final int disp_order;
  final int delivery_charge;
  final int cgst;
  final int sgst;

  Unit({required this.id, required this.productid, required this.name, required this.price, required this.offerprice, required this.status, required this.disp_order, required this.delivery_charge, required this.cgst, required this.sgst});

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json['id'],
      productid: json['productid'],
      name: json['name'],
      price: json['price'],
      offerprice: json['offerprice'],
      status: json['status'],
      disp_order: json['disp_order'],
      delivery_charge: json['delivery_charge'],
      cgst: json['cgst'],
      sgst: json['sgst'],
    );
  }
}
