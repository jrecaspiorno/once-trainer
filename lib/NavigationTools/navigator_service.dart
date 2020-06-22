import 'package:flutter/widgets.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}){
    return navigatorkey.currentState.pushNamed(routeName, arguments: arguments);
  }
  Future<dynamic> removeUntilAndPush(String routeName, {dynamic arguments}) {
    return navigatorkey.currentState.pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false, arguments: arguments);
  }
  void goBack(){
    return navigatorkey.currentState.pop();
  }
}