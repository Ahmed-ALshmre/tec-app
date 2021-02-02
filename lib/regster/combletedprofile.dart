import 'package:flutter/material.dart';
import 'completebody.dart';
import 'package:tegnloge_app/tools/sized.dart';
class CompleteProfileScreen extends StatefulWidget {
  final  String email;
  final String  password;
  static String routeName = "/complete_profile";
  const CompleteProfileScreen({Key key, this.email, this.password}) : super(key: key);
  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('سجل'),
      ),
      body: CompleteBodyProfile(email: widget.email,password: widget.password,),
    );
  }
}
