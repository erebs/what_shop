import 'dart:convert';

class ShopsNearUserData {
  final String sts;
  final String msg;
  final List<Category> categories;
  List<Advertisement>? firstad;
  List<Advertisement>? secondad;
  ShopsNearUserData({
    required this.sts,
    required this.msg,
    required this.categories,
    this.firstad,
    this.secondad,
  });

  factory ShopsNearUserData.fromJson(Map<String, dynamic> json) {
    return ShopsNearUserData(
      sts: json['sts'],
      msg: json['msg'],
      categories: (json['categories'] as List)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      firstad: (json['firstad'] as List).map((ad) => Advertisement.fromJson(ad)).toList(),
      secondad:
      (json['secondad'] as List).map((ad) => Advertisement.fromJson(ad)).toList(),

    );
  }
}
class Advertisement {
  final int id;
  final String type;
  final String image;
  final String title;
  final String url;

  Advertisement({
    required this.id,
    required this.type,
    required this.image,
    required this.title,
    required this.url,
  });

  factory Advertisement.fromJson(Map<String, dynamic> json) {
    return Advertisement(
      id: json['id'],
      type: json['type'],
      image: json['image'],
      title: json['title'],
      url: json['url'],
    );
  }
}
class Category {
  final int categoryId;
  final String categoryName;
  final List<UserShop> shops;

  Category({
    required this.categoryId,
    required this.categoryName,
    required this.shops,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      shops: (json['shops'] as List)
          .map((e) => UserShop.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
class UserShop {
  final int id;
  final String name;
  final String? website;
  final int shopCategoryId;
  final String adStatus;
  final String orderCancelOption;
  final String orderReturnOption;
  final String returnExpiry;
  final int agentId;
  final String slugName;
  final String number;
  final String whatsappNumber;
  final String password;
  final String description;
  final String address;
  final String pinCode;
  final String district;
  final String state;
  final String deliveryTime;
  final int plan;
  final int limit;
  final DateTime from;
  final DateTime to;
  final String gstNumber;
  final String fssaiLicenseNumber;
  final String notes;
  final String status;
  final String deliveryType;
  final String paymentDetails;
  final String upiId;
  final String accountNumber;
  final String ifscCode;
  final String instamojoApiKey;
  final String instamojoAuthToken;
  final String primaryColor;
  final String backColor;
  final String textColor;
  final String logo;
  final List<String> banners;
  final String selectedTheme;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int indexVisibility;
  final dynamic visibleTo;

  UserShop({
    required this.id,
    required this.name,
    this.website,
    required this.shopCategoryId,
    required this.adStatus,
    required this.orderCancelOption,
    required this.orderReturnOption,
    required this.returnExpiry,
    required this.agentId,
    required this.slugName,
    required this.number,
    required this.whatsappNumber,
    required this.password,
    required this.description,
    required this.address,
    required this.pinCode,
    required this.district,
    required this.state,
    required this.deliveryTime,
    required this.plan,
    required this.limit,
    required this.from,
    required this.to,
    required this.gstNumber,
    required this.fssaiLicenseNumber,
    required this.notes,
    required this.status,
    required this.deliveryType,
    required this.paymentDetails,
    required this.upiId,
    required this.accountNumber,
    required this.ifscCode,
    required this.instamojoApiKey,
    required this.instamojoAuthToken,
    required this.primaryColor,
    required this.backColor,
    required this.textColor,
    required this.logo,
    required this.banners,
    required this.selectedTheme,
    required this.createdAt,
    required this.updatedAt,
    required this.indexVisibility,
    this.visibleTo,
  });

  factory UserShop.fromJson(Map<String, dynamic> json) {
    return UserShop(
        id: json['id'],
        name: json['name'],
        website: json['website'],
        shopCategoryId: json['shopcategoryid'],
        adStatus: json['ad_status'],
        orderCancelOption: json['order_cancel_option'],
        orderReturnOption: json['order_return_option'],
        returnExpiry: json['return_expiry'],
        agentId: json['agentid'],
        slugName: json['slugname'],
        number: json['number'],
        whatsappNumber: json['whatsappnumber'],
        password: json['password'],
        description: json['desc'],
        address: json['address'],
        pinCode: json['pin_code'],
        district: json['district'],
        state: json['state'],
        deliveryTime: json['deliverytime'],
        plan: json['plan'],
        limit: json['limit'],
        from: DateTime.parse(json['from']),
    to: DateTime.parse(json['to']),
    gstNumber: json['gstnumber'],
    fssaiLicenseNumber: json['fssailiscencenumber'],
    notes: json['notes'],
    status: json['status'],
    deliveryType: json['delivery_type'],
    paymentDetails: json['payment_details'],
    upiId: json['upi_id'],
    accountNumber: json['acc_no'],
    ifscCode: json['ifsc_code'],
    instamojoApiKey: json['instamojo_api_key'],
    instamojoAuthToken: json['instamojo_auth_token'],
    primaryColor: json['primarycolor'],
    backColor: json['backcolor'],
    textColor: json['textcolor'],
    logo: json['logo'],
      banners: [
        json['banner'],
        json['banner2'],
        json['banner3'],
        json['banner4'],
      ]
          .where((banner) => banner != null && banner.isNotEmpty)
          .map((banner) => banner.toString())
          .toList(),
      selectedTheme: json['selectedtheme'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      indexVisibility: json['index_visibility'],
      visibleTo: json['visible_to'],
    );
  }}

