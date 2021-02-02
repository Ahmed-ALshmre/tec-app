import 'package:flutter/material.dart';
import 'package:tegnloge_app/login/sininbody.dart';
import 'package:tegnloge_app/tools/sized.dart';
class SignInScreen extends StatefulWidget {
  static String routeName = "/sign_in";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("تسجيل الدخول"),
      ),
      body: LoginBody(),
    );
  }
}
