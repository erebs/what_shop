class OrderDetailsResponse {
  String status;
  OrderDetails orderDetails;
  ShopDetails shopDetails;

  OrderDetailsResponse({
    required this.status,
    required this.orderDetails,
    required this.shopDetails,
  });

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    return OrderDetailsResponse(
      status: json['status'],
      orderDetails: OrderDetails.fromJson(json['orderDetails']),
      shopDetails: ShopDetails.fromJson(json['shopDetails']),
    );
  }
}

class OrderDetails {
  Order order;
  List<OrderItem> orderItems;

  OrderDetails({
    required this.order,
    required this.orderItems,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      order: Order.fromJson(json['order']),
      orderItems: (json['orderItems'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
    );
  }
}

class Order {
  int id;
  int shopid;
  int customerid;
  int addressid;
  int deliveryboy;
  dynamic amount;
  String paytype;
  String paystatus;
  String adminstatus;
  String customerStatus;
  String txnid;
  String details;
  String promocode;
  dynamic discount;
  dynamic deliverycharge;
  dynamic gst;
  String orderOn;
  String totalDistance;

  Order({
    required this.id,
    required this.shopid,
    required this.customerid,
    required this.addressid,
    required this.deliveryboy,
    required this.amount,
    required this.paytype,
    required this.paystatus,
    required this.adminstatus,
    required this.customerStatus,
    required this.txnid,
    required this.details,
    required this.promocode,
    required this.discount,
    required this.deliverycharge,
    required this.gst,
    required this.orderOn,
    required this.totalDistance,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      shopid: json['shopid'],
      customerid: json['customerid'],
      addressid: json['addressid'],
      deliveryboy: json['deliveryboy'],
      amount: json['amount'],
      paytype: json['paytype'],
      paystatus: json['paystatus'],
      adminstatus: json['adminstatus'],
      customerStatus: json['customer_status'],
      txnid: json['txnid'],
      details: json['details'],
      promocode: json['promocode'],
      discount: json['discount'],
      deliverycharge: json['deliverycharge'],
      gst: json['gst'],
      orderOn: json['order_on'],
      totalDistance: json['total_distance'],
    );
  }
}

class OrderItem {
  OrderItemDetails orderItem;
  Product product;
  Unit unit;
  Category category;

  OrderItem({
    required this.orderItem,
    required this.product,
    required this.unit,
    required this.category,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      orderItem: OrderItemDetails.fromJson(json['orderItem']),
      product: Product.fromJson(json['product']),
      unit: Unit.fromJson(json['unit']),
      category: Category.fromJson(json['category']),
    );
  }
}

class OrderItemDetails {
  int id;
  int orderid;
  int productid;
  int unitid;
  int quantity;
  dynamic amount;

  OrderItemDetails({
    required this.id,
    required this.orderid,
    required this.productid,
    required this.unitid,
    required this.quantity,
    required this.amount,
  });

  factory OrderItemDetails.fromJson(Map<String, dynamic> json) {
    return OrderItemDetails(
      id: json['id'],
      orderid: json['orderid'],
      productid: json['productid'],
      unitid: json['unitid'],
      quantity: json['quantity'],
      amount: json['amount'],
    );
  }
}

class Product {
  int id;
  int shopid;
  String name;
  String featured;
  String popular;
  String trending;
  String desc;
  int categoryid;
  String status;
  String image;
  String image2;
  String image3;
  String image4;
  String? video;
  String? link;
  String delStatus;

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
      delStatus: json['del_status'],
    );
  }
}

class Unit {
  int id;
  int productid;
  String name;
  dynamic price;
  dynamic offerprice;
  String status;
  int dispOrder;
  dynamic deliveryCharge;
  dynamic cgst;
  dynamic sgst;
  String delStatus;

  Unit({
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

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json['id'],
      productid: json['productid'],
      name: json['name'],
      price: json['price'],
      offerprice: json['offerprice'],
      status: json['status'],
      dispOrder: json['disp_order'],
      deliveryCharge: json['delivery_charge'],
      cgst: json['cgst'],
      sgst: json['sgst'],
      delStatus: json['del_status'],
    );
  }
}

class Category {
  String name;

  Category({
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
    );
  }
}

class ShopDetails {
  String name;

  ShopDetails({
    required this.name,
  });

  factory ShopDetails.fromJson(Map<String, dynamic> json) {
    return ShopDetails(
      name: json['name'],
    );
  }
}
