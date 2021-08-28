import 'package:flutter/cupertino.dart';

class Total extends ChangeNotifier{
  double tot =0;

  ResetTotal(){
    tot=0;
  }

  Increment(String price){
    tot += double.parse(price);
    notifyListeners();
  }

  Decrement(String price){
    tot -= double.parse(price);
    notifyListeners();
  }
}