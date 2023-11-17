class Order {
  final int? id;
  final int? shopid;
  final int? customerid;
  final int? addressid;
  final int? deliveryboy;
  final dynamic? amount;
  final String? paytype;
  final String? paystatus;
  final String? adminstatus;
  final String? customer_status;
  final String? txnid;
  final String? details;
  final String? promocode;
  final int? discount;
  final int? deliverycharge;
  final dynamic gst;
  final String? order_on;
  final dynamic total_distance;

  Order({
    this.id,
    this.shopid,
    this.customerid,
    this.addressid,
    this.deliveryboy,
    this.amount,
    this.paytype,
    this.paystatus,
    this.adminstatus,
    this.customer_status,
    this.txnid,
    this.details,
    this.promocode,
    this.discount,
    this.deliverycharge,
    this.gst,
    this.order_on,
    this.total_distance,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      shopid: json['shopid'],
      customerid: json['customerid'],
      addressid: json['addressid'],
      deliveryboy: json['deliveryboy'],
      amount: json['amount'] + json['deliverycharge'] +json['gst'] - json['discount'],
      paytype: json['paytype'],
      paystatus: json['paystatus'],
      adminstatus: json['adminstatus'],
      customer_status: json['customer_status'],
      txnid: json['txnid'],
      details: json['details'],
      promocode: json['promocode'],
      discount: json['discount'],
      deliverycharge: json['deliverycharge'],
      gst: json['gst'],
      order_on: json['order_on'],
      total_distance: json['total_distance'],
    );
  }
}

class OrderResponse {
  final String? sts;
  final String? msg;
  final List<Order>? orders;

  OrderResponse({
    this.sts,
    this.msg,
    this.orders,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> orderList = json['orders'];
    List<Order> orders = orderList.map((item) => Order.fromJson(item)).toList();
    return OrderResponse(
      sts: json['sts'],
      msg: json['msg'],
      orders: orders,
    );
  }
}
