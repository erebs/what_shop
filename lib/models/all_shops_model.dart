class AllShopResponse {
  final String sts;
  final String msg;
  final List<Shop> shops;

  AllShopResponse({required this.sts, required this.msg, required this.shops});

  factory AllShopResponse.fromJson(Map<String, dynamic> json) {
    return AllShopResponse(
      sts: json['sts'],
      msg: json['msg'],
      shops: (json['shops'] as List).map((i) => Shop.fromJson(i)).toList(),
    );
  }
}

class Shop {
  final int id;
  final String name;
  final String slugname;
  final String deliverytime;
  final String logo;
  final String delivery_type;
  final String ad_status;
  final String? category_name;

  Shop({
    required this.id,
    required this.name,
    required this.slugname,
    required this.deliverytime,
    required this.logo,
    required this.delivery_type,
    required this.ad_status,
    this.category_name,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      name: json['name'],
      slugname: json['slugname'],
      deliverytime: json['deliverytime'],
      logo: json['logo'],
      delivery_type: json['delivery_type'],
      ad_status: json['ad_status'],
      category_name: json['category_name'],
    );
  }
}
