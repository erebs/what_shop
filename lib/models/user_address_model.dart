class AddressResponse {
  final List<Address> addresses;

  AddressResponse({required this.addresses});

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    var addressList = json['address'] as List;
    List<Address> addressItems =
        addressList.map((i) => Address.fromJson(i)).toList();
    return AddressResponse(addresses: addressItems);
  }
}

class Address {
  final int id;
  final int customerid;
  String name;
  String email;
  String mobile;
  String? phone;
  String address;
  String landmark;
  String pincode;
  String city;
  String district;
  String state;
  String type;
  String default_address;

  Address(
      {required this.id,
      required this.customerid,
      required this.name,
      required this.email,
      required this.mobile,
      this.phone,
      required this.address,
      required this.landmark,
      required this.pincode,
      required this.city,
      required this.district,
      required this.state,
      required this.type,
      required this.default_address});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        id: json['id'],
        customerid: json['customerid'],
        name: json['name'],
        email: json['email'],
        mobile: json['mobile'],
        address: json['address'],
        landmark: json['landmark'],
        pincode: json['pincode'],
        city: json['city'],
        district: json['district'],
        state: json['state'],
        type: json['type'],
        default_address: json['default_address']);
  }
}
