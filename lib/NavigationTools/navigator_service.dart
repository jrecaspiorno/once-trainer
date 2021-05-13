import 'dart:ffi';

import 'package:flutter/widgets.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();
  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) => navigatorkey.currentState.pushNamed(routeName, arguments: arguments);
  
  Future<dynamic> replaceView(String routeName, {dynamic arguments}) => navigatorkey.currentState.pushReplacementNamed(routeName, arguments: arguments);

  Future<dynamic> removeUntilAndPush(String routeName, {dynamic arguments}) => navigatorkey.currentState.pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false, arguments: arguments);
  void popUntil(String routeName) => navigatorkey.currentState.popUntil(ModalRoute.withName(routeName));

  void goBack()=> navigatorkey.currentState.pop();
}