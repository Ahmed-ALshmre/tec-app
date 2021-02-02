
class Post {
  List<String> images;
  Post(
      {
        this.images,

      });

  Post.fromJson(Map<String, dynamic> json) {
    images = List.from(json['thumbnailUrl']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumbnailUrl'] = this.images;
    return data;
  }
}
class PublishedDate {
  String date;
  PublishedDate({this.date});
  PublishedDate.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }
}
