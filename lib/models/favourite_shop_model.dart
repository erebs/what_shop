class FavouriteShop {
  final String sts;
  final List<Favorite> fav;

  FavouriteShop({required this.sts, required this.fav});

  factory FavouriteShop.fromJson(Map<String, dynamic> json) {
    return FavouriteShop(
      sts: json['sts'] as String,
      fav: (json['fav'] as List<dynamic>)
          .map((favJson) => Favorite.fromJson(favJson))
          .toList(),
    );
  }
}

class Favorite {
  final int favId;
  final int shopId;
  final String name;
  final String logo;

  Favorite({
    required this.favId,
    required this.shopId,
    required this.name,
    required this.logo,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      favId: json['fav_id'] as int,
      shopId: json['shopid'] as int,
      name: json['name'] as String,
      logo: json['logo'] as String,
    );
  }
}
