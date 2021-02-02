import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tegnloge_app/home/homescreen.dart';
import 'package:tegnloge_app/model/addressmodel.dart';
import 'package:tegnloge_app/tools/provider.dart';
import 'package:tegnloge_app/tools/shortinfo.dart';

class PaymentPage extends StatefulWidget {
  final String addressId;
  final double totalAmount;
final AddressModel model;
  PaymentPage({Key key, this.addressId, this.totalAmount, this.model}) : super(key: key);
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String productId = DateTime.now().microsecondsSinceEpoch.toString();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Image.asset('assets/asset/m100.png'),
              ),

              SizedBox(
                height: 10.0,
              ),
              InkWell(
                onTap: () => addOrderData(),

                child: Container(
                  width: 250,
                  height: 60,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      'ارسال الطلب',
                      style: TextStyle(fontSize: 20.0,color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addOrderData() {
    writeOrderDetailsForUser({
      EcommerceApp.addressID: widget.addressId,
      EcommerceApp.totalAmount: EcommerceApp.sharedPreferences.getDouble("tot"),
      'orderBy': EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID),
      EcommerceApp.productID: EcommerceApp.sharedPreferences
          .getStringList(EcommerceApp.userCartList),
      EcommerceApp.orderTime: DateTime.now().microsecond.toString(),
    });
    writeOrderDetailsForAdmin({
      EcommerceApp.totalAmount: widget.totalAmount.toString(),
      'orderBy': EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID),
      EcommerceApp.productID: EcommerceApp.sharedPreferences
          .getStringList(EcommerceApp.userCartList),
      EcommerceApp.orderTime: DateTime.now().hour.toString(),
      "dele":productId,
      "state":widget.model.state,
      "homeId":widget.model.flatNumber,
      "pincode":widget.model.pincode,
      "ctey":widget.model.city,
      "phone":widget.model.phoneNumber,
      "name":widget.model.name,
      "email":EcommerceApp.sharedPreferences.getString(EcommerceApp.userEmail),
      "cont":EcommerceApp.sharedPreferences
          .getStringList(EcommerceApp.userCartList.toString())
          .length -
          1,
    }).whenComplete(() {
      emptyCartNew();
    });
  }

  emptyCartNew() {
    EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartList, ['garbageValue']);
    List tempList =
        EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .updateData({
      EcommerceApp.userCartList: tempList,
    }).then((value) {
      EcommerceApp.sharedPreferences
          .setStringList(EcommerceApp.userCartList, tempList);
      Provider.of<CartItemCounter>(context, listen: false).displayedResult();
      Fluttertoast.showToast(
          msg: 'لقد تم ارسال طلبك بنجاح سوف ');
      Route route = MaterialPageRoute(builder: (context) => HomeScreen());
      Navigator.pushReplacement(context, route);
    }).catchError((error) {});
  }

  // ignore: missing_return
  Future writeOrderDetailsForUser(Map<String, dynamic> data) async {
    await EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .collection(EcommerceApp.collectionOrders)
        .document(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID) +
                data['orderTime'])
        .setData(data);
  }

  Future writeOrderDetailsForAdmin(Map<String, dynamic> data) async {
    await EcommerceApp.firestore
        .collection(EcommerceApp.collectionOrders)
        .document(productId)
        .setData(data);

  }
}
