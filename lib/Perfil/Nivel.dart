import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Nivel extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  SharedPreferences _prefs;
  _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  _setDiff(String d) {
    _prefs.setString('nivel', d);
    _navigationService.goBack();
  }

  SizedBox diff(String d, String text) {
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
        color: Colors.deepPurple,
        padding: EdgeInsets.all(15.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _init();
    return Scaffold(
      appBar: AppBar(
        title: Text('Nivel'),
        backgroundColor: Colors.deepPurple,
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
              diff("i", 'Iniciacion'),
              Padding(
                padding: EdgeInsets.all(30.0),
              ),
              diff('a', 'Avanzado'),
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
