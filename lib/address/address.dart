import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tegnloge_app/address/toolsaddress/bottem.dart';
import 'package:tegnloge_app/address/toolsaddress/pay.dart';
import 'package:tegnloge_app/model/addressmodel.dart';
import 'package:tegnloge_app/tools/dielog/serclprogres.dart';
import 'package:tegnloge_app/tools/provideraddress.dart';
import 'package:tegnloge_app/tools/shortinfo.dart';
import 'addadress.dart';

// ignore: must_be_immutable
class Address extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final double totalAmount;
  // ignore: non_constant_identifier_names
  Address({this.totalAmount});
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'اختار عنوان الشحن',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              Consumer<AddressChanger>(builder: (context, address, c) {
                return Flexible(
                    child: StreamBuilder<QuerySnapshot>(
                  stream: EcommerceApp.firestore
                      .collection(EcommerceApp.collectionUser)
                      .document(EcommerceApp.sharedPreferences
                          .getString(EcommerceApp.userUID))
                      .collection(EcommerceApp.subCollectionAddress)
                      .snapshots(),
                  builder: (context, snapShot) {
                    return !snapShot.hasData
                        ? Center(
                            child: circularProgress(),
                          )
                        : snapShot.data.documents.length == 0
                            ? noAddressCard()
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapShot.data.documents.length,
                                itemBuilder: (context, index) {
                                  return AddressCard(
                                    currentIndex: address.cont,
                                    value: index,
                                    addressId: snapShot
                                        .data.documents[index].documentID,
                                    totalAmount: widget.totalAmount,
                                    model: AddressModel.fromJson(
                                        snapShot.data.documents[index].data),
                                  );
                                });
                  },
                ));
              })
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Route route = MaterialPageRoute(builder: (c) => AddAddress());
            Navigator.pushReplacement(context, route);
          },
          label: Text('اضف عنوان'),
          backgroundColor: Colors.pink,
          icon: Icon(Icons.add_location),
        ),
      ),
    );
  }

  noAddressCard() {
    return Card(
      color: Colors.pink.withOpacity(0.5),
      child: Container(
        height: 100.0,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_location),
            Text('لم يتم حفظ عنوان الشحن',style: TextStyle(color: Colors.white),),
            Text('الرجاء إضافة عنوان الشحن',style: TextStyle(color: Colors.white),),
          ],
        ),
      ),
    );
  }
}

class AddressCard extends StatefulWidget {
  final AddressModel model;
  final double totalAmount;
  final String addressId;
  final int currentIndex;
  final int value;

  AddressCard(
      {Key key,
      this.totalAmount,
      this.model,
      this.addressId,
      this.currentIndex,
      this.value})
      : super(key: key);
  @override
  _AddressCardState createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Provider.of<AddressChanger>(context, listen: false)
            .disPleyResult(widget.value);
      },
      child: Card(
        color: Colors.pinkAccent.withOpacity(0.4),
        child: Column(
          children: [
            Row(
              children: [
                Radio(
                  value: widget.value,
                  groupValue: widget.currentIndex,
                  onChanged: (val) {
                    Provider.of<AddressChanger>(context, listen: false)
                        .disPleyResult(val);
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      width: screenWidth * 0.8,
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              KeyText(
                                mas: 'اسم المستلم',
                              ),
                              Text(widget.model.name),
                            ],
                          ),
                          TableRow(
                            children: [
                              KeyText(
                                mas: 'رقم الهاتف',
                              ),
                              Text(widget.model.phoneNumber),
                            ],
                          ),
                          TableRow(
                            children: [
                              KeyText(
                                mas: 'المنطقه',
                              ),
                              Text(widget.model.city),
                            ],
                          ),
                          TableRow(
                            children: [
                              KeyText(
                                mas: 'الرمز البريدي',
                              ),
                              Text(widget.model.pincode),
                            ],
                          ),
                          TableRow(
                            children: [
                              KeyText(
                                mas: 'رقم الدار',
                              ),
                              Text(widget.model.flatNumber),
                            ],
                          ),
                          TableRow(
                            children: [
                              KeyText(
                                mas: 'اسم الشارع',
                              ),
                              Text(widget.model.state),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            widget.value ==
                    Provider.of<AddressChanger>(context, listen: false).cont
                ? WideButton(
                    message: 'متابعه',
                    function: () {
                      Route route = MaterialPageRoute(
                          builder: (c) => PaymentPage(
                                totalAmount: widget.totalAmount,
                                model: widget.model,
                              ));
                      Navigator.pushReplacement(context, route);
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class KeyText extends StatelessWidget {
  final String mas;

  KeyText({Key key, this.mas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      mas,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
