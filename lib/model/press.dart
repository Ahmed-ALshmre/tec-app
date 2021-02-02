
class Po {
  String title;
  String title2;
  Po(
      {
        this.title,this.title2,

      });

  Po.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    title2 =json["title2"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['title2'] = this.title2;
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
