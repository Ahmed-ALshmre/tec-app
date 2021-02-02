import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tegnloge_app/model/prodcut.dart';
import 'package:tegnloge_app/reddata/selsctcolore.dart';
import 'package:tegnloge_app/reddata/topreadbody.dart';
import 'package:tegnloge_app/tools/provider.dart';
import 'package:tegnloge_app/tools/shortinfo.dart';
import '../modelprodext.dart';
import 'botum.dart';
import 'dielogradebody.dart';
import 'imageread.dart';
import 'package:tegnloge_app/tools/sized.dart';
class ReadData extends StatefulWidget {
  final ItemModel product;
  final bool them;
  const ReadData({Key key, @required this.product, this.them}) : super(key: key);

  @override
  _ReadDataState createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {
  bool stet=false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductImages(product: widget.product),
          TopRoundedContainer(
            color: widget.them?Colors.white:Color(0xFF16242e),
            child: Column(
              children: [
                ProductDescription(
                  stet: stet,
                  product: widget.product,
                  pressOnSeeMore: () {
                    setState(() {
                      stet =stet?false:true;
                    });
                    if(stet==true){
                      Fluttertoast.showToast(msg: "لقد تم اضافة تقيمك");
                    }else{
                      Fluttertoast.showToast(msg: "لقد تم حذف التقيم");
                    }
                    print("dddddddsdsd");
                  },
                ),
                TopRoundedContainer(
                  color: widget.them ?Color(0xFFF6F7F9):Color(0xFF26242e),
                  child: Column(
                    children: [
                      ColorDots(product: widget.product),
                      TopRoundedContainer(
                        color:widget.them ? Colors.white: Color(0xFF16242e),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.15,
                            right: MediaQuery.of(context).size.width * 0.15,
                            bottom: getProportionateScreenWidth(40),
                            top: getProportionateScreenWidth(15),
                          ),
                          child: DefaultButton(
                            text: "أضف إلى السلة",
                            press: () {
                              checkItemInCart(widget.product.description, context);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }







  void checkItemInCart(String productID, BuildContext context) {
    EcommerceApp.sharedPreferences
            .getStringList(EcommerceApp.userCartList)
            .contains(productID)
        ? Fluttertoast.showToast(msg: 'هذه المنتج تم اضافة مسبقا في السلة')
        : addItemTotheCart(productID, context);
  }

  addItemTotheCart(String productID, BuildContext context) {
    List teampCartList =
        EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
    teampCartList.add(productID);
    var firebaseUser = FirebaseAuth.instance;
    firebaseUser.currentUser().then((value) {
      Firestore.instance
          .collection(EcommerceApp.collectionUser)
          .document(
              EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
          .updateData({'userCart': teampCartList}).then((v) async {
        Fluttertoast.showToast(msg: 'تم اضافة المنتج بنجاح');
        EcommerceApp.sharedPreferences
            .setStringList(EcommerceApp.userCartList, teampCartList);
        // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
        Provider.of<CartItemCounter>(context, listen: false).displayedResult();
      setState(() {

      });
          });
    });
  }
}
