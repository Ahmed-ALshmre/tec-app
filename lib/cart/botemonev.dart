import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tegnloge_app/address/address.dart';
import 'package:tegnloge_app/tools/provider.dart';
import 'package:tegnloge_app/tools/shortinfo.dart';
import 'package:tegnloge_app/tools/textstyle.dart';
import 'package:tegnloge_app/tools/totelamont.dart';
import 'botumcart.dart';

class CheckoutCard extends StatefulWidget {
  const CheckoutCard({
    Key key,
  }) : super(key: key);
  @override
  _CheckoutCardState createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  double totalAmount;
  TextEditingController _controller=TextEditingController();
  @override
  void initState() {
    super.initState();
    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false).disPley(0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 30,
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset("assets/icons/receipt.svg"),
                  ),
                  Spacer(),
                  Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                      ),
                      child: TextFormField(
                        controller: _controller,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "أضف رمز القسيمة",
                          hintStyle: TextStyle(color: Colors.red)
                        ),
                      )),
                   SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: kTextColor,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer2<TotalAmount, CartItemCounter>(
                    builder: (context, amountProvider, cartProvider, c) {
                      return Text.rich(
                        TextSpan(
                          text: "مجموع:\n",
                          children: [
                            TextSpan(
                              text: EcommerceApp.sharedPreferences
                                          .getStringList(
                                              EcommerceApp.userCartList)
                                          .length == 1
                                  ? ""
                                  : "${amountProvider.total.toString()}",
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: 190,
                    child: DefaultButton(
                      text: "تمام الطلب",
                      press: () {
                        if (EcommerceApp.sharedPreferences
                                .getStringList(EcommerceApp.userCartList)
                                .length == 1) {
                          Fluttertoast.showToast(msg: 'عربة التسوق فارغة');
                        } else {
                          Route route = MaterialPageRoute(
                              builder: (context) => Address(
                                    totalAmount: EcommerceApp.sharedPreferences.getDouble("tot"),
                                  ));
                          Navigator.push(context, route);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
