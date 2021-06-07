import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/Alertas/Alertas.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';



class LoginPage extends StatelessWidget {
  Future<bool> _onBackPressed(BuildContext context) {
    Alerts alert = Alerts(
        context: context,
        firstButtonText: "No",
        secondButtonText: "Si",
        fun1: () => Navigator.pop(context, false),
        fun2: () => SystemNavigator.pop(),
        title: "¿Quieres salir de la aplicación?",
        message: "");
    return alert.showAlertDialog2();
  }



  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);

    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        body: Center(
          child: Consumer<LoginState>(
            builder: (BuildContext context, LoginState value, Widget child) {
              return value.isLoading() ? CircularProgressIndicator() : child;
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RaisedButton(
                    padding: EdgeInsets.all(24.0),
                    color: Colors.indigo,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.google,
                          color: Colors.white,
                          size: 35,
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                        ),
                        Text(
                          'Registro Google',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      var state = context.read<LoginState>();
                      try {
                        state.login(database, context);
                      } catch (e) {}
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30),
                  ),
                  if (Platform.isIOS)
                    Padding(
                      padding: EdgeInsets.all(30),
                      child: SignInWithAppleButton(
                        text: "Registro AppleID",
                        style: SignInWithAppleButtonStyle.black,
                        iconAlignment: IconAlignment.center,
                        borderRadius: BorderRadius.circular(35),
                        height: 70,
                        onPressed: () async {
                          var state = context.read<LoginState>();
                          try {
                            state.loginApple(database, context);
                          } catch (e) {}
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
