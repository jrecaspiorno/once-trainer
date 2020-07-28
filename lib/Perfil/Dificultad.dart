import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dificultad extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  SharedPreferences _prefs;
  _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  _setDiff(int d) {
    _prefs.setInt('Diff', d);
    _navigationService.goBack();
  }

  SizedBox diff(int d, String text) {
    return SizedBox(
      width: 200,
      height: 80,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onPressed: () => _setDiff(d),
        autofocus: true,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        color: Colors.indigo,
        padding: EdgeInsets.all(15.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _init();
    return Scaffold(
      appBar: AppBar(
        title: Text('Dificultad'),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        child: Center(
          child: Flex(
            mainAxisAlignment: MainAxisAlignment.center,
            direction: Axis.vertical,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(30.0),
              ),
              diff(-1, 'Fácil'),
              Padding(
                padding: EdgeInsets.all(30.0),
              ),
              diff(0, 'Normal'),
              Padding(
                padding: EdgeInsets.all(30.0),
              ),
              diff(1, 'Difícil'),
              Padding(
                padding: EdgeInsets.all(30.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
