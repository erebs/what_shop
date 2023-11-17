class UserDataModel {
  final String status;
  final UserDetails details;

  UserDataModel({required this.status, required this.details});

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      status: json['sts'],
      details: UserDetails.fromJson(json['details']),
    );
  }
}

class UserDetails {
  final int id;
  String name;
  String email;
  final String phone;
  final String password;
  final String address;
  final String pincode;
  final String area;
  final String district;
  final String state;
  final String latitude;
  final String longitude;
  final String joinOn;

  UserDetails({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.address,
    required this.pincode,
    required this.area,
    required this.district,
    required this.state,
    required this.latitude,
    required this.longitude,
    required this.joinOn,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      address: json['address'],
      pincode: json['pincode'],
      area: json['area'],
      district: json['district'],
      state: json['state'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      joinOn: json['join_on'],
    );
  }
}
