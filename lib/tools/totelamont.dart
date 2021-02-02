import 'package:flutter/cupertino.dart';
import 'package:tegnloge_app/tools/shortinfo.dart';

class TotalAmount extends ChangeNotifier{
  double _totalAmount=0;
  double get total=>_totalAmount;
  disPley(double no)async{
    _totalAmount=no;
    await Future.delayed(const Duration(milliseconds: 100),(){
      notifyListeners();
    });
  }
}