import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Alertas/Alertas.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/DriveBackup/Backup.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:provider/provider.dart';

class RestoreButton extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    var state = context.watch<LoginState>();
    final database = context.watch<AppDatabase>();

    Backup backup = Backup(
        header: state.getHeader(),
        id: state.getId(),
        database: database,
        state: state);
    Alerts alerta = Alerts(
        context: context,
        firstButtonText: "Cancelar",
        secondButtonText: "Ok",
        fun1: () => _navigationService.goBack(),
        fun2: () {
          _navigationService.goBack();
          backup.restoreData().then((_) {
            Alerts a = Alerts(
                firstButtonText: "Ok",
                context: context,
                message: "Datos recuperados con exito",
                title: "Recuperacion Correcta",
                fun1: () => _navigationService.goBack());
            a.showAlertDialog();
          }, onError: (e) {
            Alerts a = Alerts(
                firstButtonText: "Ok",
                context: context,
                message: "Ha habido un error",
                title: "Error",
                fun1: () => _navigationService.goBack());
            a.showAlertDialog();
          });
        },
        title: "Recuperar Datos",
        message:
            "¿Desea recuperar sus datos de Google Drive? Perdera todos sus datos actuales.");

    return Center(
      child: SizedBox(
        width: 330,
        child: RaisedButton(
          child: Text('Recuperar Datos', style: TextStyle(fontSize: 30)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: () => alerta.showAlertDialog2(),
          color: Colors.indigo,
          textColor: Colors.white,
          padding: EdgeInsets.all(24.0),
        ),
      ),
    );
  }
}
