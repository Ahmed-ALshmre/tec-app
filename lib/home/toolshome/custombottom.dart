
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tegnloge_app/darkmode/models_providers/theme_provider.dart';
import 'package:tegnloge_app/home/toolshome/fiver.dart';
import 'package:tegnloge_app/sitting/profilsitting.dart';
import 'package:tegnloge_app/tools/textstyle.dart';
import '../../meu.dart';
import '../homescreen.dart';
import 'package:tegnloge_app/tools/sized.dart';

import '../masseg.dart';
class CustomBottomNavBar extends StatefulWidget {
   CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);
  final MenuState selectedMenu;

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(14)),
      decoration: BoxDecoration(
        color: themeProvider.isLightTheme ? Colors.white:Color(0xFF1E1F28),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: themeProvider.isLightTheme ?Color(0xFFDADADA).withOpacity(0.15):Color(0xFF1E1F28).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg",
                  color: MenuState.home == widget.selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()))
              ),

              IconButton(
                icon: SvgPicture.asset("assets/icons/Heart Icon.svg"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Fiv.routeName);
                },

              ),
              IconButton(
                icon: SvgPicture.asset("assets/icons/Chat bubble Icon.svg"),
                onPressed: () {
                  Navigator.pushNamed(context, Naessige.routeName);
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: MenuState.profile == widget.selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>ProfileScreen()))
              ),
            ],
          )),
    );
  }
}
