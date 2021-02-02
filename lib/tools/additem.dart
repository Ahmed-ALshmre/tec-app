// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:provider/provider.dart';
// import 'package:tegnloge_app/tools/shortinfo.dart';
//
//
// addItemTotheCart(String productID, BuildContext context) {
//   List teampCartList =
//   EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
//   teampCartList.add(productID);
//   var firebaseUser = FirebaseAuth.instance;
//   firebaseUser.currentUser().then((value) {
//     Firestore.instance
//         .collection(EcommerceApp.collectionUser)
//         .document(
//         EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
//         .updateData({'userCart': teampCartList}).then((v) async {
//       Fluttertoast.showToast(msg: 'Item Added to Cart Successfully .');
//       EcommerceApp.sharedPreferences
//           .setStringList(EcommerceApp.userCartList, teampCartList);
//       // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
//       Provider.of<CartItemCounter>(context, listen: false).displayedResult();
//     });
//   });
