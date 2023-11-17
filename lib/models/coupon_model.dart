class CouponModel {
  final String name;
  final int discount;
  final String msg;
  final String sts;

  CouponModel({
    required this.name,
    required this.discount,
    required this.msg,
    required this.sts,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      name: json['name'],
      discount: json['discount'],
      msg: json['msg'],
      sts: json['sts'],
    );
  }
}
