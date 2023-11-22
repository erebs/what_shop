class CartSumModel {
  final String status;
  final String message;
  final double sumTotal;
  final double totalTax;
  final double productDeliveryCharge;
  final double deliveryCharge;

  CartSumModel({
    required this.status,
    required this.message,
    required this.sumTotal,
    required this.totalTax,
    required this.productDeliveryCharge,
    required this.deliveryCharge,
  });

  factory CartSumModel.fromJson(Map<String, dynamic> json) {
    return CartSumModel(
      status: json['sts'],
      message: json['msg'],
      sumTotal: json['sumtotal'].toDouble(),
      totalTax: json['totaltax'].toDouble(),
      productDeliveryCharge: json['productdeliverycharge'].toDouble(),
      deliveryCharge: double.parse(json['deliverycharge']),
    );
  }
}
