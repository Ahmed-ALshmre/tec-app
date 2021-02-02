import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tegnloge_app/regster/toolstetfeld.dart';
import 'package:tegnloge_app/tools/textstyle.dart';
import 'package:tegnloge_app/tools/sized.dart';
class RegBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.04), // 4%
                Text("تسجيل حساب", style: headingStyle),
                Text(
                  "أكمل التفاصيل الخاصة بك",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                SignUpForm(),
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
                SizedBox(height: getProportionateScreenWidth(20)),
                Text(
                  'من خلال الاستمرار في التأكيد على موافقت  \n على البنود والشروط الخاصة بنا',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
      ),
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
