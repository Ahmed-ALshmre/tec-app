import 'package:flutter/material.dart';
import 'package:tegnloge_app/home/homescreen.dart';
import 'package:tegnloge_app/tools/textstyle.dart';

import '../main.dart';

class SueccBody extends StatefulWidget {
  @override
  _SueccBodyState createState() => _SueccBodyState();
}

class _SueccBodyState extends State<SueccBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: MediaQuery.of(context).size.height * 0.4, //40%
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
        Text(
          "تم التسجيل بنجاح",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: sizedBox(
            context: context,
            text: "الذهاب الى تسوق",

          ),
        ),
        Spacer(),
      ],
    );
  }

  sizedBox({String text , BuildContext context}){
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: kPrimaryColor,
        onPressed:(){
          Route route =MaterialPageRoute(builder: (_)=>SplashScreen());
          Navigator.pushReplacement(context, route);
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
