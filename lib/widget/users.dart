import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tegnloge_app/tools/shortinfo.dart';

class ProfileSevenPage extends StatelessWidget {
  static final String path = "lib/src/pages/profile/profile7.dart";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Platform.isIOS?Icons.arrow_back_ios : Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromRGBO(255, 255, 255, .9),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 330,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage("assets/asset/m898.gif"),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  Column(
                    children: <Widget>[
                    SizedBox(height: 170,),
                      Padding(
                        padding: EdgeInsets.all(4),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 77),
                        padding: EdgeInsets.all(10),
                      ),
                      UserInfo()
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "المعلومات الشخصيه",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Divider(
                    color: Colors.black38,
                  ),
                  Container(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            leading: Icon(Icons.my_location),
                            title: Text("العنوان"),
                            subtitle: Text("${EcommerceApp.sharedPreferences.getString("address")}"),
                          ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text("الايميل"),
                            subtitle: Text("${EcommerceApp.sharedPreferences.getString(EcommerceApp.userEmail)}"),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text("رقم الهاتف"),
                            subtitle: Text("${EcommerceApp.sharedPreferences.getString("phone")}"),
                          ),
                          ListTile(
                            leading: Icon(Icons.perm_identity_rounded),
                            title: Text("اسم المستخدم"),
                            subtitle: Text(
                                "${EcommerceApp.sharedPreferences.getString(EcommerceApp.userName)}"),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}