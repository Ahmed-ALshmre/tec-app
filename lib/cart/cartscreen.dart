import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tegnloge_app/cart/botemonev.dart';
import 'package:tegnloge_app/tools/provider.dart';
import 'package:tegnloge_app/tools/shortinfo.dart';
import 'package:tegnloge_app/tools/sized.dart';

import 'bodycartscreen.dart';
class CartScreen extends StatelessWidget {

  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "عربتك",
            style: TextStyle(color: Colors.red , fontWeight: FontWeight.bold,letterSpacing: 1,height: 1),
          ),
          Consumer<CartItemCounter>(builder: (context, counter, _) {
            return Text(
              " منتج ${EcommerceApp.sharedPreferences
                  .getStringList(EcommerceApp.userCartList)
                  .length -
                  1}",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,letterSpacing: 1,height: 1),
            );
          }),
        ],
      ),
    );
  }
}
