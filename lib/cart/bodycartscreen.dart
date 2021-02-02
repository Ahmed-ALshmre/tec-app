import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tegnloge_app/cart/cart.dart';
import 'package:tegnloge_app/model/prodcut.dart';
import 'package:tegnloge_app/tools/shortinfo.dart';
import 'package:tegnloge_app/tools/totelamont.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double totalAmount;
  @override
  void initState() {
    super.initState();
    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false).disPley(0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: StreamBuilder<QuerySnapshot>(
          stream: EcommerceApp.firestore
              .collection('all')
              .where('shortInfo',
                  whereIn: EcommerceApp.sharedPreferences
                      .getStringList(EcommerceApp.userCartList))
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      ItemModel mode = ItemModel.fromJson(
                          snapshot.data.documents[index].data);
                      if (index == 0) {
                        totalAmount = 0;
                        totalAmount = mode.price + totalAmount;
                      } else {
                        totalAmount = mode.price + totalAmount;
                      }
                      if (snapshot.data.documents.length - 1 == index) {
                        WidgetsBinding.instance.addPostFrameCallback((t) {
                          EcommerceApp.sharedPreferences.setDouble("tot", totalAmount);
                          Provider.of<TotalAmount>(context, listen: false)
                              .disPley(totalAmount);
                        });
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: CartCard(cart: mode),
                      );
                    });
            }
          }),
    );
  }

  beginbuilng() {
    return Center(
      child: SliverToBoxAdapter(
        child: Card(
          color: Theme.of(context).primaryColor.withOpacity(0.5),
          child: Container(
            height: 100.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.insert_emoticon,
                  color: Colors.white,
                ),
                Text('Cart is empty .'),
                Text('Start adding items to your Cart '),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
