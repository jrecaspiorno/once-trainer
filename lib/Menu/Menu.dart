import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/Historial/HistorialBuild.dart';
import 'package:flutterapp/Alertas/Alertas.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/DriveBackup/Backup.dart';
import 'package:flutterapp/Perfil/Perfil.dart';

import 'package:flutterapp/Perfil/historialClinico.dart';
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:flutterapp/pulsera/datosHistorial/sacaImprimeSemana.dart';
import 'package:flutterapp/pulsera/datosHistorial/tablaDatos.dart';
import 'package:flutterapp/pulsera/datosRitmoTR/sacaDatosRitmoCardiaco.dart';
import 'package:provider/provider.dart';

import '../ejercicios/lista_ejer.dart';
import '../recomendados.dart';

class Menu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    final uDao = context.watch<AppDatabase>().usuarioDAO;
    var state = Provider.of<LoginState>(context, listen: false);
    String  id = state.getId();
    var user =  uDao.getUser(id);
    user.then((value) => state.setDate(value.edad));
    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(

          title: Text("Menu"),
          backgroundColor: Colors.indigo,
        ),
        body: MenuView(context),
      ),
    );
  }

  Widget MenuView(BuildContext context) {
    return Center(
      child: Container(
          child: ListView(
        padding: EdgeInsets.all(30),
        children: <Widget>[
          _buildButton('Recomendaciones', MyRecomList(), context),
          _buildButton('Lista Ejercicios', MyList(), context),
          _buildButton('Perfil', MyProfile(), context),
          //_buildButton('Prueba pulsera', MySaca("HEART_RATE"), context),
          //_buildButton('Prueba Ritmo', MyRitmo(), context),
          botonBackup(context)
        ],
      )),
    );
  }

  Widget botonBackup(BuildContext context) {
    var state = Provider.of<LoginState>(context, listen: false);
    final database = Provider.of<AppDatabase>(context);
    Backup backup = Backup(header:state.getHeader(),id:state.getId(), database: database);
    Alerts alertOK = Alerts(context: context, firstButtonText: "Ok", fun1: ()=> MaterialPageRoute(builder: (context) => Menu()), title: "Backup", message: "El bakcup ha sido realizado correctamente");
    Alerts alertKO = Alerts(context: context, firstButtonText: "Ok", fun1: ()=> Navigator.pop(context), title: "Backup Error", message: "Ha habido un error realizando el backup");
    Alerts alerta = Alerts(context: context, firstButtonText: "Cancelar",
      secondButtonText: "Ok" ,
      fun1: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => Menu())),
      fun2: (){backup.uploadDataToDrive(); Navigator.pop(context);},
      title: "Backup", message: "¿Desea realizar un backup?"
    );

    return Center(
      child: RaisedButton(
        child: Text('Backup', style: TextStyle(fontSize: 30)),
        shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

        onPressed: () => alerta.showAlertDialog2(),
        color: Colors.indigo,
        textColor: Colors.white,
        padding: EdgeInsets.all(24.0),
        ),
    );
  }

  Column _buildButton(String label, Widget funcion, BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => funcion),
            );
          },
          color: Colors.indigo,
          textColor: Colors.white,
          padding: EdgeInsets.all(24.0),
          child: Text(label, style: TextStyle(fontSize: 30)),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
