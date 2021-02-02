import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tegnloge_app/cart/botumcart.dart';
import 'package:tegnloge_app/login/toolsforgetbody.dart';
import 'package:tegnloge_app/regster/regsterhome.dart';
import 'package:tegnloge_app/tools/dielog/errordielog.dart';
import 'package:tegnloge_app/tools/sized.dart';
import 'package:tegnloge_app/tools/textstyle.dart';
import 'erroretextfeld.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "نسيت الرمز ",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("الرجاء إدخال بريدك الإلكتروني وسنرسل لك \n ارتباطًا للعودة إلى حسابك",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController foCont = TextEditingController();
  List<String> errors = [];
  String email;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: foCont,
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                setState(() {
                  errors.remove(kEmailNullError);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.remove(kInvalidEmailError);
                });
              }
              return null;
            },
            validator: (value) {
              if (value.isEmpty && !errors.contains(kEmailNullError)) {
                setState(() {
                  errors.add(kEmailNullError);
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.add(kInvalidEmailError);
                });
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "ايميل",
              hintText: "ادخل البريد الكترونيه",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
            text: "متابعه",
            press: () {
              if (_formKey.currentState.validate()) {
                showDialog(
                    context: context,
                    builder: (c) {
                      return ErrorAlertDialog(
                        message: 'تم ارسال التاكيد الى ايميلك',
                      );
                    });
                FirebaseAuth auth= FirebaseAuth.instance;
                auth.sendPasswordResetEmail(email: foCont.text);
                // Do what you want to do
              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          noAccountText(),
        ],
      ),
    );
  }
  Widget noAccountText(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "ليس لديك حساب ؟",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
            "سجل",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }

}
