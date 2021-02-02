import 'package:flutter/material.dart';
import 'package:tegnloge_app/regster/regsterbody.dart';
class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("سجل"),
      ),
      body: RegBody(),
    );
  }
}
