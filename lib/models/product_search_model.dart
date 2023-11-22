class SearchProduct {
  final int id;
  final int shopId;
  final String name;
  final String featured;
  final String popular;
  final String trending;
  final String desc;
  final int categoryId;
  final String status;
  final String image;
  final String image2;
  final String image3;
  final String image4;
  final String video;
  final String link;
  final String delStatus;

  SearchProduct({
    required this.id,
    required this.shopId,
    required this.name,
    required this.featured,
    required this.popular,
    required this.trending,
    required this.desc,
    required this.categoryId,
    required this.status,
    required this.image,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.video,
    required this.link,
    required this.delStatus,
  });

  factory SearchProduct.fromJson(Map<String, dynamic> json) {
    return SearchProduct(
      id: json['id'],
      shopId: json['shopid'],
      name: json['name'],
      featured: json['featured'],
      popular: json['popular'],
      trending: json['trending'],
      desc: json['desc'],
      categoryId: json['categoryid'],
      status: json['status'],
      image: json['image'],
      image2: json['image2'] ?? '',
      image3: json['image3'] ?? '',
      image4: json['image4'] ?? '',
      video: json['video'] ?? '',
      link: json['link'] ?? '',
      delStatus: json['del_status'],
    );
  }
}
