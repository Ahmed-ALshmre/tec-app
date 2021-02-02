import 'package:flutter/material.dart';

import '../../meu.dart';
import 'custombottom.dart';

class Fiv extends StatefulWidget {
  static String routeName = "/fiv";
  @override
  _FivState createState() => _FivState();
}

class _FivState extends State<Fiv> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.favourite),
      appBar: AppBar(),
      body: Center(child: Text(
        "لا يوجد مفضلات"
      ),),
    ));
  }
}
