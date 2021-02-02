import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tegnloge_app/model/prodcut.dart';
import 'package:tegnloge_app/scroller/productCar.dart';
import 'package:tegnloge_app/tools/shortinfo.dart';

import 'package:tegnloge_app/tools/textstyle.dart';
import 'package:tegnloge_app/veiwallproducts/viewall.dart';
import 'package:tegnloge_app/tools/sized.dart';
class PopularProducts extends StatefulWidget {
  @override
  _PopularProductsState createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(950),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(10)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(10)),
            child: textSelect(
                title: "المنتجات الشائعة",
                press: () {
                  Navigator.pushNamed(context,ViewAllPro.routeName);
                }),
          ),
          Flexible(child: _drawProducts()),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: textSelect(
                title: "المنتجات الشائعة",
                press: () {
                 Navigator.pushNamed(context,ViewAllPro.routeName);
                }),
          ),
          Flexible(child: _drawroducts()),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: textSelect(
                title: "المخصص لك",
                press: () {
                  Navigator.pushNamed(context,ViewAllPro.routeName);
                }),
          ),
          Flexible(child: _rawroducts()),
        ],
      ),
    );
  }

  Widget _drawProducts() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('homeScreen1').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: CircularProgressIndicator(),
            );
          default:
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  print("dddddddddddddd${EcommerceApp.sharedPreferences.getDouble("tot")}");
                  ItemModel model =
                      ItemModel.fromJson(snapshot.data.documents[index].data);
                 print(model.images);
                  return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(children: [
                        ProductCar(product: model),
                        // here by default width and height is 0
                      ]));
                });
        }
      },
    );
  }

  Widget _drawroducts() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('homeScreen2').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: CircularProgressIndicator(),
            );
          default:
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  ItemModel model =
                      ItemModel.fromJson(snapshot.data.documents[index].data);
                  print("aaaaaaaaaaaa${model.images}");
                  return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(children: [
                        ProductCar(product: model),
                        // here by default width and height is 0
                      ]));
                });
        }
      },
    );
  }
  Widget _rawroducts() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('homeScreen3').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: CircularProgressIndicator(),
            );
          default:
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  ItemModel model =
                  ItemModel.fromJson(snapshot.data.documents[index].data);
                  print("111111111111111111111111111aaaaa${model.images}");
                  return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(children: [
                        ProductCar(product: model),
                        // here by default width and height is 0
                      ]));
                });
        }
      },
    );
  }
  Widget textSelect({String title, Function press}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(16),
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            "المزيد",
            style: TextStyle(color: Color(0xFFBBBBBB)),
          ),
        ),
      ],
    );
  }
}
