
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tegnloge_app/home/homescreen.dart';
import 'package:tegnloge_app/tools/provider.dart';
import 'package:tegnloge_app/tools/shortinfo.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final PreferredSizeWidget bottom;
  MyAppBar({this.bottom});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      title: Text(
        'سلع اونلاين',
        style: TextStyle(
          color: Colors.white,
          fontSize: 35.0,
          fontFamily: 'Signatra',
        ),
      ),
      centerTitle: true,
      bottom: bottom,
      actions: [
      ],
    );
  }

  Size get preferredSize => bottom == null
      ? Size(56, AppBar().preferredSize.height)
      : Size(56, 80 + AppBar().preferredSize.height);
}
