import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tegnloge_app/home/homescreen.dart';
import 'package:tegnloge_app/loginsec/secssfly.dart';
import 'package:tegnloge_app/tools/dielog/dieloglogin.dart';
import 'package:tegnloge_app/tools/dielog/errordielog.dart';
import 'package:tegnloge_app/tools/shortinfo.dart';
import 'package:tegnloge_app/tools/textstyle.dart';
import '../main.dart';
import 'erroretextfeld.dart';
import 'forgetpassword.dart';
import 'kebord.dart';
import 'package:tegnloge_app/tools/sized.dart';
class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
 _emailController.dispose();
 _passwordController.dispose();
  }
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("تذكرنى"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "هل نسيت كلمة المرور",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          sized(
            text: "متابعه",
            press: () {
              if (_formKey.currentState.validate()) {
               userLogin();
               _formKey.currentState.save();
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
              }
            },
          ),
        ],
      ),
    );
  }
  TextFormField buildPasswordFormField() {
    return TextFormField(
    controller: _passwordController,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 6) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 6) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "الرمز",
        hintText: "أدخل كلمة المرور",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: custemImage(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "ايميل",
        hintText: "أدخل بريدك الإلكتروني",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: custemImage(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
  Widget sized({String text , Function press}){
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: kPrimaryColor,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  Widget custemImage({String svgIcon }){
    return Padding(
      padding: EdgeInsets.fromLTRB(
        getProportionateScreenWidth(10),
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(7),
        getProportionateScreenWidth(20),
      ),
      child: SvgPicture.asset(
        svgIcon,
        height: getProportionateScreenHeight(18),
      ),
    );
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void userLogin() async {
    FirebaseUser firebaseUser;
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            message: 'Pless awaet for th',
          );
        });
    await _auth
        .signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim())
        .then((userAuth) {
      firebaseUser = userAuth.user;
    }).catchError((error) {
      showDialog(
          context: context,
          builder: (context) {
            Navigator.pop(context);
            return ErrorAlertDialog(
              message: error.message.toString(),
            );
          });
    });
    print('ahmea1');
    if (firebaseUser != null) {
      print('ahmea2');
      readData(firebaseUser).then((value) {
        setState(() {

        });
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) =>LoginSuccessScreen ()));
      });
    }
  }

  // ignore: missing_return
  Future readData(FirebaseUser fusre) async {
    Firestore.instance
        .collection('users')
        .document(fusre.uid)
        .get()
        .then((dataSnapShot) async {
      await EcommerceApp.sharedPreferences
          .setString('uid', dataSnapShot.data['uid']);
      await EcommerceApp.sharedPreferences.setString(
          EcommerceApp.userEmail, dataSnapShot.data['email']);
      await EcommerceApp.sharedPreferences.setString(
          EcommerceApp.userName, dataSnapShot.data['name']);
      await EcommerceApp.sharedPreferences.setString(
          EcommerceApp.userPhotoUrl, dataSnapShot.data['phone']);
      await EcommerceApp.sharedPreferences
          .setString('uid', dataSnapShot.data['address']);
      List<String> cartList =
      dataSnapShot.data['userCart'].cast<String>();
      await EcommerceApp.sharedPreferences
          .setStringList(EcommerceApp.userCartList, cartList);
    });
    setState(() {
    });
  }
}
