import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tegnloge_app/tools/dielog/serclprogres.dart';
import 'package:tegnloge_app/tools/shortinfo.dart';

import 'ordercart.dart';

class MyOrders extends StatefulWidget {
  static String routeName = "/myOrders";
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
/*        drawer: MyDrawer(),*/
        appBar: AppBar(),
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection(EcommerceApp.collectionUser)
              .document(EcommerceApp.sharedPreferences
              .getString(EcommerceApp.userUID))
              .collection(EcommerceApp.collectionOrders)
              .snapshots(),
          builder: (context, snapShots) {
            return snapShots.hasData
                ? ListView.builder(
                itemCount: snapShots.data.documents.length,
                itemBuilder: (context, index) {
                  return FutureBuilder<QuerySnapshot>(
                      future: Firestore.instance
                          .collection('all')
                          .where('shortInfo',
                          whereIn: snapShots.data.documents[index]
                              .data[EcommerceApp.productID])
                          .getDocuments(),
                      builder: (context, snap) {
                        return snap.hasData
                            ? OrderCard(
                          itemCount: snap.data.documents.length,
                          data: snap.data.documents,
                          orderId: snapShots
                              .data.documents[index].documentID,
                        )
                            : Center(
                          child: circularProgress(),
                        );
                      });
                })
                : Center(
              child: circularProgress(),
            );
          },
        ),
      ),
    );
  }
}
