import 'package:flutter/foundation.dart';

class MyProvider with ChangeNotifier {
 bool _exceso = false;
 get exceso{
   return _exceso;
 }
 set exceso(bool n){
   this._exceso = n;
   notifyListeners();
 }

}