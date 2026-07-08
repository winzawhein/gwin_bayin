class VideoModel {
  final int id;
  final String title;
  final String des;
  final String categories;
  // final String local;

  final String url;
  final String downloadUrl;
  final String thumbnail;
  final int isVip;
  final int views;
  final String createdAt;

  VideoModel({
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnail,
    required this.isVip,
    required this.des,
    required this.categories,
    // required this.local,
    required this.downloadUrl,
    required this.views,
    required this.createdAt,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: (json['id'] ?? 0) as int,
      title: (json['title'] ?? '') as String,
      url: (json['url'] ?? '') as String,
      thumbnail: (json['thumbnail'] ?? '') as String,
      isVip: json['is_vip'] ?? 0,
      des: json['description'],
      categories: json['category'],
      // local: '',
      downloadUrl: '',
      views: json['views'],
      createdAt: json['created_at'],
    );
  }
}
