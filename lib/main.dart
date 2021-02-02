import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tegnloge_app/home/homescreen.dart';
import 'package:tegnloge_app/login/sinin.dart';
import 'package:tegnloge_app/tools/provider.dart';
import 'package:tegnloge_app/tools/provideraddress.dart';
import 'package:tegnloge_app/tools/route.dart';
import 'package:tegnloge_app/tools/shortinfo.dart';
import 'package:tegnloge_app/tools/totelamont.dart';
import 'darkmode/models_providers/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EcommerceApp.auth = FirebaseAuth.instance;
  EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();
  EcommerceApp.firestore = Firestore.instance;
  final appDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  final settings = await Hive.openBox('settings');
  bool isLightTheme = settings.get('isLightTheme') ?? false;
  print(isLightTheme);
  runApp( ChangeNotifierProvider(
    create: (_) => ThemeProvider(isLightTheme: isLightTheme),
    child: AppStart(),
  ));
}

// to ensure we have the themeProvider before the app starts lets make a few more changes.

class AppStart extends StatelessWidget {
  const AppStart({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MyApp(
      themeProvider: themeProvider,
    );
  }
}

class MyApp extends StatefulWidget with WidgetsBindingObserver {
  final ThemeProvider themeProvider;
  const MyApp({Key key, @required this.themeProvider}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => TotalAmount()),
        ChangeNotifierProvider(create: (c) => AddressChanger()),
        ChangeNotifierProvider(create: (c) => CartItemCounter()),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          //     const Locale('en', 'USA'),
          const Locale('ar', ''),
        ],
        debugShowCheckedModeBanner: false,
        title: 'E-shop',
        theme: widget.themeProvider.themeData(),
        initialRoute: SplashScreen.routeName,
        routes: routes,
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth user = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    displaySplash();
  }

  displaySplash() {
    Timer(Duration(seconds: 5), () async {
      if (await user.currentUser() != null) {
        print('ahmed');
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } else {
        Navigator.pushReplacementNamed(context, SignInScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xffF3F3F3),
            image: DecorationImage(
          image: ExactAssetImage("assets/asset/m898.gif"),

        )),
      ),
    );
  }
}

// Theme Data is saved on refresh or restart
// App bar color also changes with theme
