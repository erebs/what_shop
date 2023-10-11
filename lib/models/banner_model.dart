class BannerList {
  final List<Banner>? firstad;
  final List<Banner>? secondad;

  BannerList({this.firstad, this.secondad});

  factory BannerList.fromJson(Map<String, dynamic> json) {
    print('Creating BannerList...');
    final firstAds = (json['mainbanners'] as List<dynamic>?)
        ?.map((e) => Banner.fromJson(e as Map<String, dynamic>))
        .toList();
    final secondAds = (json['footerbanners'] as List<dynamic>?)
        ?.map((e) => Banner.fromJson(e as Map<String, dynamic>))
        .toList();
    print('First ads: $firstAds');
    print('Second ads: $secondAds');
    return BannerList(firstad: firstAds, secondad: secondAds);
  }
}

  class Banner {
  final int? id;
  final String? type;
  final String? image;
  final String? title;
  final String? url;

  Banner({this.id, this.type, this.image, this.title, this.url});

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['id'] as int?,
      type: json['type'] as String?,
      image: json['image'] as String?,
      title: json['title'] as String?,
      url: json['url'] as String?,
    );
  }
}
