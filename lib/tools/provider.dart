
import 'package:flutter/foundation.dart';
import 'package:tegnloge_app/tools/shortinfo.dart';

class CartItemCounter extends ChangeNotifier {
  int _counter = EcommerceApp.sharedPreferences
      .getStringList(EcommerceApp.userCartList).length - 1;
  int get count => _counter;
  Future<void> displayedResult() async {
    int _counter = EcommerceApp.sharedPreferences
        .getStringList(EcommerceApp.userCartList).length -1;
    await Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}