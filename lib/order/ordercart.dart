import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tegnloge_app/model/prodcut.dart';

import 'orderdelect.dart';
int counter = 0;

class OrderCard extends StatelessWidget {
  final int itemCount;
  final List<DocumentSnapshot> data;
  final String orderId;

  const OrderCard({Key key, this.itemCount, this.data, this.orderId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: Color(0xFF1E1F28),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        height: itemCount * 190.0,
        child: ListView.builder(
          itemCount: itemCount,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            ItemModel model = ItemModel.fromJson(data[index].data);
            return sourceOrderInfo(model, context);
          },
        ),
      ),
    );
  }
}

Widget sourceOrderInfo(ItemModel model, BuildContext context,
    {Color background}) {
 double width = MediaQuery.of(context).size.width;

  return Container(
    height: 180.0,
    width: width,
    child: Row(
      children: [
        Image.network(
          model.images[0],
          width: 180,
          fit: BoxFit.fill,
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.0,
              ),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        model.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        model.description,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 0.0),
                        child: Row(
                          children: [
                            Text(
                              "المجموع",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              r'QAR',
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                            Text(
                              (model.price).toString(),
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Flexible(child: Container()),
            ],
          ),
        ),
      ],
    ),
  );
}
