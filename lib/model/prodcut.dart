import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class ItemModel {
  bool isFavourite =true;
   String id;
   String title, description;
   List<String> images;
   double rating, price;
    List<Color> colors =[Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,];

  ItemModel(
      {
        this.isFavourite,
        this.colors,
        this.title,
        this.description,
        this.id,
        this.images,
        this.rating,
        this.price,
      });

  ItemModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['shortInfo'];
    id = json['publishedTaim'];
    images = List.from(json['thumbnailUrl']);
    price = json['longDescription'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['shortInfo'] = this.description;
    data['price'] = this.price;
    data['thumbnailUrl'] = this.images;
    data['id'] = this.id;
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
