import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tegnloge_app/home/homescreen.dart';
import 'package:tegnloge_app/model/prodcut.dart';
import 'package:tegnloge_app/tools/provider.dart';
import 'package:tegnloge_app/tools/shortinfo.dart';
import 'package:tegnloge_app/tools/textstyle.dart';
import 'package:tegnloge_app/tools/totelamont.dart';
class CartCard extends StatefulWidget {
  const CartCard({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final ItemModel cart;

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  double totalAmount;
  @override
  void initState() {
    super.initState();
    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false).disPley(0);
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(widget.cart.images[0]),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.cart.title}",
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "\QAR${widget.cart.price}",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
                children: [
                  TextSpan(
                      text: "   1x",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            )
          ],
        ),
        IconButton(icon:Icon(Icons.delete) , onPressed:(){
          removeItemUserCart( widget.cart.description,context);
        }),
      ],
    );
  }
  removeItemUserCart(String shortInfoId , BuildContext context) {
    List teampCartList =
    EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
    teampCartList.remove(shortInfoId);
    var firebaseUser = FirebaseAuth.instance;
    firebaseUser.currentUser().then((value) {
      Firestore.instance
          .collection(EcommerceApp.collectionUser)
          .document(
          EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
          .updateData({'userCart': teampCartList}).then((v) async {
        Fluttertoast.showToast(msg: 'تم حذف المنتج بنجاح .');
        EcommerceApp.sharedPreferences
            .setStringList(EcommerceApp.userCartList, teampCartList);
        // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
        Provider.of<CartItemCounter>(context, listen: false).displayedResult();
        totalAmount = 0;
        setState(() {});
        Navigator.pushNamed(context, HomeScreen.routeName);
      });
    });
  }
}
