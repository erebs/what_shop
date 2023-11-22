class CartItemResponse {
  final String? sts;
  final String? msg;
  final List<CartItem>? cart;

  CartItemResponse({required this.sts, required this.msg, required this.cart});

  factory CartItemResponse.fromJson(Map<String, dynamic> json) {
    var cartList = json['cart'];

    return CartItemResponse(
      sts: json['sts'],
      msg: json['msg'],
      cart:cartList == null
          ? []
          : (cartList as List).map((item) => CartItem.fromJson(item)).toList(),
    );
  }
}

class CartItem {
  final int id;
  final String uniqueid;
  final int shopid;
  final int productid;
  final int unitid;
   int quantity;
  final String createdAt;
  final String shopname;
  final String productname;
  final String unitname;
  final int unitprice;
  final int unitofferprice;
  final image;
  final dynamic tax;
  final int deliveryCharge;
  CartItem({
    required this.id,
    required this.uniqueid,
    required this.shopid,
    required this.productid,
    required this.unitid,
    required this.quantity,
    required this.createdAt,
    required this.shopname,
    required this.productname,
    required this.unitname,
    required this.unitprice,
    required this.unitofferprice,
    this.image,
    required this.tax,
    required this.deliveryCharge,

  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      uniqueid: json['uniqueid'],
      shopid: json['shopid'],
      productid: json['productid'],
      unitid: json['unitid'],
      quantity: json['quantity'],
      createdAt: json['created_at'],
      shopname: json['shopname'],
      productname: json['productname'],
      unitname: json['unitname'],
      unitprice: json['unitprice'],
      unitofferprice: json['unitofferprice'],
      image: json['productimage'],
      tax: json['tax'],
      deliveryCharge: json['deliverycharge']
    );
  }
}
