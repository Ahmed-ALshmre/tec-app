import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tegnloge_app/veiwallproducts/viewall.dart';

import '../listGema.dart';
import 'package:tegnloge_app/tools/sized.dart';
class ListGameApp extends StatelessWidget {
  final String icon , text;
  final  GestureTapCallback press;
  const ListGameApp({Key key, this.icon, this.text, this.press,}) : super(key: key);@override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,

      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(12)),
              height: getProportionateScreenHeight(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon),
            ),
            SizedBox(height: getProportionateScreenWidth(5)),
            Text(text, textAlign: TextAlign.center,style: TextStyle(fontSize:getProportionateScreenWidth(12) ),)
          ],
        ),
      ),
    );
  }
}



