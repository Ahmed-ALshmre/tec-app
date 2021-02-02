import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tegnloge_app/login/textfeld.dart';
import 'package:tegnloge_app/regster/regsterhome.dart';
import 'package:tegnloge_app/tools/textstyle.dart';
import 'package:tegnloge_app/tools/sized.dart';

class LoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Text(
                  "مرحبا بعودتك",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "قم بتسجيل الدخول باستخدام بريدك \n الإلكتروني وكلمة المرور",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                SignForm(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    secolCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () {},
                    ),
                    secolCard(
                      icon: "assets/icons/facebook-2.svg",
                      press: () {},
                    ),
                    secolCard(
                      icon: "assets/icons/twitter.svg",
                      press: () {},
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                noAccountText(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
  noAccountText(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "ليس لديك حساب ؟",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          child: Text(
            " سجل",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: kPrimaryColor),
          ),
          onTap: (){
            Route route =MaterialPageRoute(builder: (co)=>SignUpScreen());
        Navigator.push(context, route);
          },
        ),
      ],
    );
  }
  secolCard({String icon , Function press}){
    return GestureDetector(
      onTap: press,
      child: Container(
        margin:
        EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        padding: EdgeInsets.all(getProportionateScreenWidth(12)),
        height: getProportionateScreenHeight(40),
        width: getProportionateScreenWidth(40),
        decoration: BoxDecoration(
          color: Color(0xFFF5F6F9),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(icon),
      ),
    );
  }
}
