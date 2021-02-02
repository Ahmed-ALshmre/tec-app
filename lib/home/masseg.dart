import 'package:flutter/material.dart';
import 'package:tegnloge_app/home/toolshome/custombottom.dart';

import '../meu.dart';


class Naessige extends StatefulWidget {
  static String routeName = "/naessige";
  @override
  _NaessigeState createState() => _NaessigeState();
}

class _NaessigeState extends State<Naessige> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.message),
      appBar: AppBar(),
      body: Center(child: Text("لا يوجد رسال"),),
    ));
  }
}
