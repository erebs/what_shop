class DefaultShops {
  final String? sts;
  final String? msg;
  final List<HomeCategory>? categories;
  final List<Advertisement> firstad;
  final List<Advertisement>? secondad;
  final List<NewShops>? newshops;
  DefaultShops({
    this.sts,
    this.msg,
    this.categories,
    required this.firstad,
    this.secondad,
    this.newshops,
  });

  factory DefaultShops.fromJson(Map<String, dynamic> json) {
    return DefaultShops(
      sts: json['sts'],
      msg: json['msg'],
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => HomeCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      newshops: (json['newshops'] as List<dynamic>?)
          ?.map((e) => NewShops.fromJson(e as Map<String, dynamic>))
          .toList(),
      firstad: (json['firstad'] as List).map((ad) => Advertisement.fromJson(ad)).toList(),
      secondad:
      (json['secondad'] as List).map((ad) => Advertisement.fromJson(ad)).toList(),
    );
  }
}

class HomeCategory {
  final int? categoryId;
  final String? categoryName;
  final List<HomeShop>? shops;

  HomeCategory({this.categoryId, this.categoryName, this.shops});

  factory HomeCategory.fromJson(Map<String, dynamic> json) {
    return HomeCategory(
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      shops: (json['shops'] as List<dynamic>?)
          ?.map((e) => HomeShop.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class HomeShop {
  int? id;
  String? name;
  String? website;
  String? domainType;
  int? shopcategoryid;
  String? adStatus;
  String? orderCancelOption;
  String? orderReturnOption;
  String? returnExpiry;
  int? agentid;
  String? slugname;
  String? number;
  String? whatsappnumber;
  String? password;
  String? desc;
  String? address;
  String? pinCode;
  String? district;
  String? state;
  String? deliverytime;
  int? plan;
  int? limit;
  String? from;
  String? to;
  String? gstnumber;
  String? fssailiscencenumber;
  String? notes;
  String? status;
  String? deliveryType;
  String? paymentDetails;
  String? upiId;
  String? accNo;
  String? ifscCode;
  String? instamojoApiKey;
  String? instamojoAuthToken;
  String? primarycolor;
  String? backcolor;
  String? textcolor;
  String? logo;
  String? banner;
  String? banner2;
  String? banner3;
  String? banner4;
  int? agentId;
  String? selectedtheme;
  String? createdAt;
  String? updatedAt;
  int? indexVisibility;
  String? visibleTo;

  HomeShop(
      {this.id,
        this.name,
        this.website,
        this.domainType,
        this.shopcategoryid,
        this.adStatus,
        this.orderCancelOption,
        this.orderReturnOption,
        this.returnExpiry,
        this.agentid,
        this.slugname,
        this.number,
        this.whatsappnumber,
        this.password,
        this.desc,
        this.address,
        this.pinCode,
        this.district,
        this.state,
        this.deliverytime,
        this.plan,
        this.limit,
        this.from,
        this.to,
        this.gstnumber,
        this.fssailiscencenumber,
        this.notes,
        this.status,
        this.deliveryType,
        this.paymentDetails,
        this.upiId,
        this.accNo,
        this.ifscCode,
        this.instamojoApiKey,
        this.instamojoAuthToken,
        this.primarycolor,
        this.backcolor,
        this.textcolor,
        this.logo,
        this.banner,
        this.banner2,
        this.banner3,
        this.banner4,
        this.agentId,
        this.selectedtheme,
        this.createdAt,
        this.updatedAt,
        this.indexVisibility,
        this.visibleTo});

  HomeShop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    website = json['website'];
    domainType = json['domain_type'];
    shopcategoryid = json['shopcategoryid'];
    adStatus = json['ad_status'];
    orderCancelOption = json['order_cancel_option'];
    orderReturnOption = json['order_return_option'];
    returnExpiry = json['return_expiry'];
    agentid = json['agentid'];
    slugname = json['slugname'];
    number = json['number'];
    whatsappnumber = json['whatsappnumber'];
    password = json['password'];
    desc = json['desc'];
    address = json['address'];
    pinCode = json['pin_code'];
    district = json['district'];
    state = json['state'];
    deliverytime = json['deliverytime'];
    plan = json['plan'];
    limit = json['limit'];
    from = json['from'];
    to = json['to'];
    gstnumber = json['gstnumber'];
    fssailiscencenumber = json['fssailiscencenumber'];
    notes = json['notes'];
    status = json['status'];
    deliveryType = json['delivery_type'];
    paymentDetails = json['payment_details'];
    upiId = json['upi_id'];
    accNo = json['acc_no'];
    ifscCode = json['ifsc_code'];
    instamojoApiKey = json['instamojo_api_key'];
    instamojoAuthToken = json['instamojo_auth_token'];
    primarycolor = json['primarycolor'];
    backcolor = json['backcolor'];
    textcolor = json['textcolor'];
    logo = json['logo'];
    banner = json['banner'];
    banner2 = json['banner2'];
    banner3 = json['banner3'];
    banner4 = json['banner4'];
    agentId = json['agent_id'];
    selectedtheme = json['selectedtheme'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    indexVisibility = json['index_visibility'];
    visibleTo = json['visible_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['website'] = this.website;
    data['domain_type'] = this.domainType;
    data['shopcategoryid'] = this.shopcategoryid;
    data['ad_status'] = this.adStatus;
    data['order_cancel_option'] = this.orderCancelOption;
    data['order_return_option'] = this.orderReturnOption;
    data['return_expiry'] = this.returnExpiry;
    data['agentid'] = this.agentid;
    data['slugname'] = this.slugname;
    data['number'] = this.number;
    data['whatsappnumber'] = this.whatsappnumber;
    data['password'] = this.password;
    data['desc'] = this.desc;
    data['address'] = this.address;
    data['pin_code'] = this.pinCode;
    data['district'] = this.district;
    data['state'] = this.state;
    data['deliverytime'] = this.deliverytime;
    data['plan'] = this.plan;
    data['limit'] = this.limit;
    data['from'] = this.from;
    data['to'] = this.to;
    data['gstnumber'] = this.gstnumber;
    data['fssailiscencenumber'] = this.fssailiscencenumber;
    data['notes'] = this.notes;
    data['status'] = this.status;
    data['delivery_type'] = this.deliveryType;
    data['payment_details'] = this.paymentDetails;
    data['upi_id'] = this.upiId;
    data['acc_no'] = this.accNo;
    data['ifsc_code'] = this.ifscCode;
    data['instamojo_api_key'] = this.instamojoApiKey;
    data['instamojo_auth_token'] = this.instamojoAuthToken;
    data['primarycolor'] = this.primarycolor;
    data['backcolor'] = this.backcolor;
    data['textcolor'] = this.textcolor;
    data['logo'] = this.logo;
    data['banner'] = this.banner;
    data['banner2'] = this.banner2;
    data['banner3'] = this.banner3;
    data['banner4'] = this.banner4;
    data['agent_id'] = this.agentId;
    data['selectedtheme'] = this.selectedtheme;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['index_visibility'] = this.indexVisibility;
    data['visible_to'] = this.visibleTo;
    return data;
  }
}

class NewShops {
  int? id;
  String? name;
  String? slugname;
  String? deliverytime;
  String? logo;
  String? deliveryType;
  String? adStatus;

  NewShops(
      {this.id,
        this.name,
        this.slugname,
        this.deliverytime,
        this.logo,
        this.deliveryType,
        this.adStatus});

  NewShops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slugname = json['slugname'];
    deliverytime = json['deliverytime'];
    logo = json['logo'];
    deliveryType = json['delivery_type'];
    adStatus = json['ad_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slugname'] = this.slugname;
    data['deliverytime'] = this.deliverytime;
    data['logo'] = this.logo;
    data['delivery_type'] = this.deliveryType;
    data['ad_status'] = this.adStatus;
    return data;
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