class FavoriteProductModel {
  String? sts;
  List<FavoriteItem>? fav;

  FavoriteProductModel({this.sts, this.fav});

  FavoriteProductModel.fromJson(Map<String, dynamic> json) {
    sts = json['sts'];
    if (json['fav'] != null) {
      fav = [];
      json['fav'].forEach((v) {
        fav!.add(FavoriteItem.fromJson(v));
      });
    }
  }
}

class FavoriteItem {
  int? favId;
  int? productId;
  String? name;
  String? image;

  FavoriteItem({this.favId, this.productId, this.name, this.image});

  FavoriteItem.fromJson(Map<String, dynamic> json) {
    favId = json['fav_id'];
    productId = json['productid'];
    name = json['name'];
    image = json['image'];
  }
}
