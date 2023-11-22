class ShopInformationResponse {
  String sts;
  String msg;
  bool  isFavourite;
  ShopDetails shopDetails;

  ShopInformationResponse({
    required this.sts,
    required this.msg,
    required this.isFavourite,
    required this.shopDetails,

  });

  factory ShopInformationResponse.fromJson(Map<String, dynamic> json) {
    return ShopInformationResponse(
      sts: json['sts'],
      msg: json['msg'],
      isFavourite:json['favourite_status'],
      shopDetails: ShopDetails.fromJson(json['shop_details']),
    );
  }
}

class ShopDetails {
  int id;
  String name;
  String shopType;
  String website;
  dynamic domainType;
  int shopCategoryId;
  String adStatus;
  String orderCancelOption;
  String orderReturnOption;
  String returnExpiry;
  int agentId;
  String slugName;
  String number;
  String whatsappNumber;
  String password;
  String desc;
  String address;
  String pinCode;
  String district;
  String state;
  String deliveryTime;
  int plan;
  int limit;
  String from;
  String to;
  String gstNumber;
  String fssaiLicenseNumber;
  String notes;
  String status;
  String deliveryType;
  String paymentDetails;
  String upiId;
  String accNo;
  String ifscCode;
  String instamojoApiKey;
  String instamojoAuthToken;
  String primaryColor;
  String backColor;
  String textColor;
  String logo;
  String banner;
  String banner2;
  String banner3;
  String banner4;
  int agentId2;
  String selectedTheme;
  DateTime createdAt;
  DateTime updatedAt;
  int indexVisibility;
  dynamic visibleTo;
  String latitude;
  String longitude;
  int locStatus;

  ShopDetails({
    required this.id,
    required this.name,
    required this.shopType,
    required this.website,
    required this.domainType,
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
    required this.desc,
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
    required this.accNo,
    required this.ifscCode,
    required this.instamojoApiKey,
    required this.instamojoAuthToken,
    required this.primaryColor,
    required this.backColor,
    required this.textColor,
    required this.logo,
    required this.banner,
    required this.banner2,
    required this.banner3,
    required this.banner4,
    required this.agentId2,
    required this.selectedTheme,
    required this.createdAt,
    required this.updatedAt,
    required this.indexVisibility,
    required this.visibleTo,
    required this.latitude,
    required this.longitude,
    required this.locStatus,
  });

  factory ShopDetails.fromJson(Map<String, dynamic> json) {
    return ShopDetails(
      id: json['id'],
      name: json['name'],
      shopType: json['shop_type'],
      website: json['website'],
      domainType: json['domain_type'],
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
      desc: json['desc'],
      address: json['address'],
      pinCode: json['pin_code'],
      district: json['district'],
      state: json['state'],
      deliveryTime: json['deliverytime'],
      plan: json['plan'],
      limit: json['limit'],
      from: json['from'],
      to: json['to'],
      gstNumber: json['gstnumber'],
      fssaiLicenseNumber: json['fssailiscencenumber'],
      notes: json['notes'],
      status: json['status'],
      deliveryType: json['delivery_type'],
      paymentDetails: json['payment_details'],
      upiId: json['upi_id'],
      accNo: json['acc_no'],
      ifscCode: json['ifsc_code'],
      instamojoApiKey: json['instamojo_api_key'],
      instamojoAuthToken: json['instamojo_auth_token'],
      primaryColor: json['primarycolor'],
      backColor: json['backcolor'],
      textColor: json['textcolor'],
      logo: json['logo'],
      banner: json['banner'],
      banner2: json['banner2'],
      banner3: json['banner3'],
      banner4: json['banner4'],
      agentId2: json['agent_id'],
      selectedTheme: json['selectedtheme'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      indexVisibility: json['index_visibility'],
      visibleTo: json['visible_to'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      locStatus: json['loc_status'],
    );
  }
}
