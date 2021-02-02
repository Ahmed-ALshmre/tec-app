import 'package:flutter/material.dart';
import 'package:tegnloge_app/tools/textstyle.dart';
import 'package:tegnloge_app/tools/sized.dart';
import 'completeform.dart';
import 'package:tegnloge_app/tools/sized.dart';
class CompleteBodyProfile extends StatelessWidget {
  final String email;
  final String password;
  const CompleteBodyProfile({Key key, this.email, this.password}) : super(key: key);
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Text("اكمل الملف الشخصي", style: headingStyle),
                Text(
                  "أكمل التفاصيل الخاصة بك",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height:  MediaQuery.of(context).size.height * 0.06),
                CompleteProfileForm(email:email, password: password, ),
                SizedBox(height: getProportionateScreenHeight(30)),
                Text(
                  "من خلال الاستمرار في التأكيد على موافقتك \n على البنود والشروط الخاصة بنا",
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
}
