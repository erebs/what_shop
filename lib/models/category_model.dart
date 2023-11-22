class CategoryResponse {
  final String sts;
  final String msg;
  final List<Category> categories;

  CategoryResponse({required this.sts, required this.msg, required this.categories});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    var categoryList = json['categories'] as List;
    List<Category> categoryItems = categoryList.map((i) => Category.fromJson(i)).toList();
    return CategoryResponse(
      sts: json['sts'],
      msg: json['msg'],
      categories: categoryItems,
    );
  }
}

class Category {
  final int id;
  final int shopid;
  final String name;
  final int disporder;
  final String image;
  final String status;

  Category({
    required this.id,
    required this.shopid,
    required this.name,
    required this.disporder,
    required this.image,
    required this.status,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      shopid: json['shopid'],
      name: json['name'],
      disporder: json['disporder'],
      image: json['image'],
      status: json['status'],
    );
  }
}
