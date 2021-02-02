import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tegnloge_app/cart/cartscreen.dart';
import 'package:tegnloge_app/model/addressmodel.dart';
import 'package:tegnloge_app/tools/shortinfo.dart';

import 'address.dart';

class AddAddress extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<FormState>();
  final cName = TextEditingController();
  final cPhoneNumber = TextEditingController();
  final cFlatHome = TextEditingController();
  final cCity = TextEditingController();
  final cState = TextEditingController();
  final cPineCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (formKey.currentState.validate()) {
              final mode = AddressModel(
                name: cName.text.trim(),
                state: cState.text.trim(),
                phoneNumber: cPhoneNumber.text.trim(),
                pincode: cPineCode.text.trim(),
                city: cCity.text.trim(),
                flatNumber: cFlatHome.text.trim(),
              ).toJson();
              // coll to the Firebase here
              EcommerceApp.firestore
                  .collection(EcommerceApp.collectionUser)
                  .document(EcommerceApp.sharedPreferences
                  .getString(EcommerceApp.userUID))
                  .collection(EcommerceApp.subCollectionAddress)
                  .document(DateTime.now().millisecond.toString())
                  .setData(mode)
                  .then((value) {
                Fluttertoast.showToast(msg: 'تم اضافة العنوان بنجاح .');
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Address()));
                Text(' ');

                FocusScope.of(context).requestFocus(FocusNode());
                formKey.currentState.reset();
              });
            }
          },
          label: Text('تم'),
          backgroundColor: Colors.pink,
          icon: Icon(Icons.check),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'عنوان جديد',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    MyTextField(
                      hint: 'اسم المستلم',
                      controller: cName,
                    ),
                    MyTextField(
                      hint: 'رقم الهاتف',
                      controller: cPhoneNumber,
                    ),
                    MyTextField(
                      hint: '  الشارع',
                      controller: cFlatHome,
                    ),
                    MyTextField(
                      hint: 'المنطقة',
                      controller: cCity,
                    ),
                    MyTextField(
                      hint: 'رقم الدار',
                      controller: cState,
                    ),
                    MyTextField(
                      hint: 'الرمز البريدي',
                      controller: cPineCode,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  MyTextField({this.controller, this.hint});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration.collapsed(hintText: hint),
        validator: (val) => val.isEmpty ? 'هماك حقل فارغ' : null,
      ),
    );
  }
}
