import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/Alertas/Alertas.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/DriveBackup/Backup.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';

class BackupButton extends StatelessWidget{
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    var state = context.watch<LoginState>();
    final database = context.watch<AppDatabase>();
    Backup backup = Backup(
        header: state.getHeader(), id: state.getId(), database: database, state: state);
    // Alerts alertOK = Alerts(context: context, firstButtonText: "Ok", fun1: ()=> MaterialPageRoute(builder: (context) => Menu()), title: "Backup", message: "El bakcup ha sido realizado correctamente");
    // Alerts alertKO = Alerts(context: context, firstButtonText: "Ok", fun1: ()=> Navigator.pop(context), title: "Backup Error", message: "Ha habido un error realizando el backup");
    Alerts alerta = Alerts(
        context: context,
        firstButtonText: "Cancelar",
        secondButtonText: "Ok",
        fun1: () => _navigationService.goBack(),
        fun2: () {
          try {
            _navigationService.goBack();
            backup.uploadDataToDrive().then((_) {
              Alerts a = Alerts(firstButtonText: "Ok", context: context, message: "Backup realizado con exito", title: "Backup Correcto", fun1: () => _navigationService.goBack());
              a.showAlertDialog();
            });


          }catch(e){
            _navigationService.goBack();
            Alerts a = Alerts(firstButtonText: "Ok", context: context, message: "Backup realizado con exito", title: "Backup Correcto", fun1: () => _navigationService.goBack());
            a.showAlertDialog();
          }
        },
        title: "Backup",
        message: "¿Desea realizar un backup?");

    return Center(
      child: SizedBox(
        width: 330,
        child: RaisedButton(
          child: Text('Backup', style: TextStyle(fontSize: 30)),
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