import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tegnloge_app/model/prodcut.dart';
import 'package:tegnloge_app/reddata/roundicon.dart';
import 'package:tegnloge_app/tools/pinter.dart';
import 'package:tegnloge_app/tools/shortinfo.dart';
import 'package:tegnloge_app/tools/textstyle.dart';
import '../modelprodext.dart';


class ColorDots extends StatefulWidget {
  const ColorDots({
    Key key,
    @required this.product,
  }) : super(key: key);

  final ItemModel product;

  @override
  _ColorDotsState createState() => _ColorDotsState();
}

class _ColorDotsState extends State<ColorDots> {

  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo
    int selectedColor = 3;
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ...List.generate(
            widget.product.colors.length,
                (index) => ColorDot(
              color: widget.product.colors[index],
              isSelected: index == selectedColor,
            ),
          ),
          Spacer(),
          RoundedIconBtn(
            icon: Icons.add,
            press: () {
              Fluttertoast.showToast(msg: "1");
            },
          ),
          SizedBox(width: 20),
          RoundedIconBtn(
            icon: Icons.remove,
            showShadow: true,
            press: () {},
          ),
        ],
      ),
    );
  }

}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key key,
    @required this.color,
    this.isSelected = false,
  }) : super(key: key);

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2),
      padding: EdgeInsets.all(8),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border:
        Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
