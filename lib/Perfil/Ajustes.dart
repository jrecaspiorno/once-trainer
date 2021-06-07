import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/DriveBackup/BackupView.dart';
import 'package:flutterapp/DriveBackup/RestoreView.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ajustes extends StatelessWidget {
  SharedPreferences _prefs;
  Future<SharedPreferences> _getLogInType() async {
    return SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder(
          future: _getLogInType(),
          builder: (context, prefs) {
            if (prefs.hasData) {
              return Center(
                child: ListView(
                  shrinkWrap: true,
//        direction: Axis.vertical,
                  children: <Widget>[
                    MyButtonType(),
                    if (prefs.data.getString('logType') == 'google')
                      BackupButton(),
                    if (prefs.data.getString('logType') == 'google')
                      Padding(
                        padding: EdgeInsets.all(24.0),
                      ),
                    if (prefs.data.getString('logType') == 'google')
                      RestoreButton(),
                    if (prefs.data.getString('logType') == 'google')
                      Padding(
                        padding: EdgeInsets.all(24.0),
                      ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class MyButtonType extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  Flex _buildButton(String label, String route, Object args) {
    return Flex(
      direction: Axis.vertical,
      // mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 330,
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: () {
              if (args != null)
                _navigationService.navigateTo(route, arguments: args);
              else
                _navigationService.navigateTo(route);
            },
            color: Colors.deepPurple,
            textColor: Colors.white,
            padding: EdgeInsets.all(24.0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<LoginState>();
    String id = state.getId();
    return Center(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          _buildButton('Dolencias', route.DolenciasPage, id),
          _buildButton('Fecha Nacimiento', route.EditarFechaPage, id),
          _buildButton('Cambiar nombre', route.EditarNombrePage, id),
          _buildButton('Dificultad', route.DificultadPage, null),
          _buildButton('Nivel', route.NivelPage, null),

        ],
      ),
    );
  }
}
