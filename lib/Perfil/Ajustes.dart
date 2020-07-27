import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/DriveBackup/BackupView.dart';
import 'package:flutterapp/DriveBackup/RestoreView.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:provider/provider.dart';

class Ajustes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);

    var state = context.watch<LoginState>();
    String id = state.getId();
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
        backgroundColor: Colors.indigo,
      ),
      body: Flex(
        mainAxisAlignment: MainAxisAlignment.center,
        direction: Axis.vertical,
        children: <Widget>[
          MyButtonType(),
          BackupButton(),
          Padding(
            padding: EdgeInsets.all(24.0),
          ),
          RestoreButton(),
        ],
      ),
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
            color: Colors.indigo,
            textColor: Colors.white,
            padding: EdgeInsets.all(24.0),
            child: Text(label, style: TextStyle(fontSize: 30)),
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
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 20),
          _buildButton('Dolencias', route.DolenciasPage, state.getId()),
          _buildButton(
              'Fecha Nacimiento', route.EditarFechaPage, state.getId()),
        ],
      ),
    );
  }
}
