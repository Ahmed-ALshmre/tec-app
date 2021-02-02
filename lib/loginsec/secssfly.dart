import 'package:flutter/material.dart';

import 'loginsuccesbody.dart';


class LoginSuccessScreen extends StatefulWidget {
  static String routeName = "/login_success";

  @override
  _LoginSuccessScreenState createState() => _LoginSuccessScreenState();
}

class _LoginSuccessScreenState extends State<LoginSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("تم التسجيل بنجاح"),
      ),
      body: SueccBody(),
    );
  }
}
