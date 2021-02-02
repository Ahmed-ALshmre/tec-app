import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tegnloge_app/tools/shortinfo.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenter extends StatefulWidget {
  @override
  _HelpCenterState createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  String text = "يمكنك التواصل معنا عن طريق كتابة رساله لنا  ";
  String title1 = " او تواصل مباشرة عن طريق الايميل";
  TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          launchUrl("mailto:sl3online4qa@gmail.com");
        },
        child: SvgPicture.asset("assets/icons/Mail.svg",height: 28,),
      ),
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                title1,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 100,
              ),
              Center(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      controller: _controller,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "ادخل الرسالة",
                      ),
                    )),
              ),
              SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  if (_controller.text.isEmpty) {
                    Fluttertoast.showToast(msg: "هذه الحقل فارغ");
                  } else {
                    Firestore.instance.collection('help').document().setData({
                      "mas": _controller.text,
                      "email": EcommerceApp.sharedPreferences
                          .getString(EcommerceApp.userEmail)
                          .toString(),
                    });
                    _controller.clear();
                    Fluttertoast.showToast(
                        msg:
                            "لقد تم ارسال رسالتك بنجاح سوف يتم التواصل معك قريبا");
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red),
                  child: Text(
                    "ارسل الطلب",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw "Could not launch $url";
    }
  }
}
