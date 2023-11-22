class UserResponse {
  final User user;

  UserResponse({ required this.user});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String? address;
  final String? pincode;
  final String? area;
  final String? district;
  final String? state;
  final String? latitude;
  final String? longitude;
  final String joinOn;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    this.address,
    this.pincode,
    this.area,
    this.district,
    this.state,
    this.latitude,
    this.longitude,
    required this.joinOn,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      password: json['password'] ?? '',
      address: json['address'] ?? '',
      pincode: json['pincode'] ?? '',
      area: json['area'] ?? '',
      district: json['district'] ?? '',
      state: json['state'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      joinOn: json['join_on'] ?? '',
    );
  }
}
