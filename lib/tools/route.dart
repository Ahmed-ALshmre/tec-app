import 'package:flutter/widgets.dart';
import 'package:tegnloge_app/cart/cartscreen.dart';
import 'package:tegnloge_app/game/combeotr.dart';
import 'package:tegnloge_app/game/cppon.dart';
import 'package:tegnloge_app/game/game.dart';
import 'package:tegnloge_app/game/gift.dart';
import 'package:tegnloge_app/home/homescreen.dart';
import 'package:tegnloge_app/home/listGema.dart';
import 'package:tegnloge_app/home/masseg.dart';
import 'package:tegnloge_app/home/toolshome/fiver.dart';
import 'package:tegnloge_app/home/toolshome/search.dart';
import 'package:tegnloge_app/login/forgetpassword.dart';
import 'package:tegnloge_app/login/sinin.dart';
import 'package:tegnloge_app/loginsec/secssfly.dart';
import 'package:tegnloge_app/order/orderpage.dart';
import 'package:tegnloge_app/reddata/reid.dart';
import 'package:tegnloge_app/regster/combletedprofile.dart';
import 'package:tegnloge_app/regster/regsterhome.dart';
import 'package:tegnloge_app/sitting/profilsitting.dart';
import 'package:tegnloge_app/veiwallproducts/viewall.dart';

import '../main.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName: (context) => SignInScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  GameList.routeName: (context) => GameList(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  DetailsScreen.routeName: (context) =>  DetailsScreen(),
   CartScreen.routeName: (context) =>  CartScreen(),
   CartScreen.routeName: (context) =>  CartScreen(),
  SearchProduct.routeName: (context) =>  SearchProduct(),
  ViewAllPro.routeName: (context) =>  ViewAllPro(),
  MyOrders.routeName: (context) =>  MyOrders(),
  SplashScreen.routeName: (context) =>  SplashScreen(),
  Gift.routeName: (context) =>  Gift(),
  Game.routeName: (context) =>  Game(),
  Coppon.routeName: (context) =>  Coppon(),
  Comp.routeName: (context) =>  Comp(),
  Fiv.routeName: (context) =>  Fiv(),
  Naessige.routeName: (context) =>  Naessige(),

};
