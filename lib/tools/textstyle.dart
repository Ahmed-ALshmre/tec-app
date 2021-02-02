import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "رجاءا أدخل بريدك الإلكتروني";
const String kInvalidEmailError = "الرجاء إدخال بريد إلكتروني صحيح";
const String kPassNullError = "من فضلك أدخل رقمك السري";
const String kShortPassError = "كلمة المرور قصيرة جدا";
const String kMatchPassError = "كلمات المرور غير متطابقة";
const String kNamelNullError = "من فضلك أدخل إسمك";
const String kPhoneNumberNullError = "يرجى إدخال رقم الهاتف الخاص بك";
const String kAddressNullError = "الرجاء إدخال عنوانك";

final otpInputDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: 15),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: kTextColor),
  );
}
