import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tegnloge_app/darkmode/models_providers/theme_provider.dart';
import 'package:tegnloge_app/darkmode/pages/home_page.dart';
import 'package:tegnloge_app/login/sinin.dart';
import 'package:tegnloge_app/order/orderpage.dart';
import 'package:tegnloge_app/tools/shortinfo.dart';
import 'package:tegnloge_app/tools/textstyle.dart';
import 'package:tegnloge_app/tools/sized.dart';
import 'package:tegnloge_app/widget/helpcenter.dart';
import 'package:tegnloge_app/widget/users.dart';
class SettingProfile extends StatefulWidget {
  final bool  tru;

  const SettingProfile({Key key, this.tru}) : super(key: key);

  @override
  _SettingProfileState createState() => _SettingProfileState();
}

class _SettingProfileState extends State<SettingProfile> {
  File imag;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          sizedBox(),
          SizedBox(height: getProportionateScreenWidth(20)),
          profileMenu(
            text: "حسابي",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>ProfileSevenPage()))
            },
          ),
          profileMenu(
            text: "طلبي",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              Navigator.pushNamed(context, MyOrders.routeName),
            },
          ),
          profileMenu(
            text: "الوضع المظلم",
            icon: "assets/icons/m1.svg",
            press: () => {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>HomePage()))
            },
          ),
          profileMenu(
            text: "مركز المساعدة",
            icon: "assets/icons/Question mark.svg",
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>HelpCenter()));
            },
          ),
          profileMenu(
            text: "تسجيل خروج",
            icon: "assets/icons/Log out.svg",
            press: ()  {
              EcommerceApp.auth.signOut().then((value) {
                Route route = MaterialPageRoute(
                    builder: (context) => SignInScreen());
                Navigator.pushReplacement(context, route);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget profileMenu({String text, icon,VoidCallback press }){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20), vertical: getProportionateScreenWidth(10)),
      child: FlatButton(
        padding: EdgeInsets.all(getProportionateScreenWidth(20)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: widget.tru ?Color(0xFFF5F6F9):Colors.grey,
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: kPrimaryColor,
              width: getProportionateScreenWidth(22),
            ),
            SizedBox(width: getProportionateScreenWidth(20)),
            Expanded(child: Text(text)),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }

  Widget sizedBox(){
    return SizedBox(
      height: getProportionateScreenHeight(115),
      width: getProportionateScreenWidth(115),
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          CircleAvatar(
            backgroundImage: imag !=null?FileImage(imag):AssetImage("assets/asset/m898.gif"),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: getProportionateScreenHeight(46),
              width: getProportionateScreenWidth(46),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.white),
                ),
                color: Color(0xFFF5F6F9),
                onPressed: () async{
                  final File image = await ImagePicker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    imag=image;
                  });
                },
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
