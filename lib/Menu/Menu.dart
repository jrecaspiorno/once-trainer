import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/Historial/HistorialBuild.dart';
import 'package:flutterapp/Alertas/Alertas.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/DriveBackup/Backup.dart';
import 'package:flutterapp/Perfil/Perfil.dart';

import 'package:flutterapp/Perfil/historialClinico.dart';
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:flutterapp/RouteManager.dart';
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

  Future<bool> _onBackPressed(BuildContext context) {
    Alerts alert = Alerts(
        context: context,
        firstButtonText: "No",
        secondButtonText: "Si",
        fun1: () => Navigator.pop(context, false),
        fun2: () => SystemNavigator.pop(),
        title: "Quieres salir de la aplicacion?",
        message: "");
        return alert.showAlertDialog2();
  }
  @override
  Widget build(BuildContext context) {
    final uDao = context.watch<AppDatabase>().usuarioDAO;
    var state = Provider.of<LoginState>(context, listen: false);
    String  id = state.getId();
    var user =  uDao.getUser(id);
    user.then((value) => state.setDate(value.edad));
    return MaterialApp(
      onGenerateRoute:  RouteGenerator.generateRoute,
      home: WillPopScope(

        onWillPop:() => _onBackPressed(context),
        child: Scaffold(
          appBar: AppBar(

            title: Text("Menu"),
             backgroundColor: Colors.indigo,
          ),
          body: menuView(context),
        ),
      ),
      
    );
  }

  Widget menuView(BuildContext context) {
    return Center(

      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(30),
        children: <Widget>[
          _buildButton('Recomendaciones' , context,'/Recomendaciones'),
          _buildButton('Lista Ejercicios', context, '/Lista Ejercicios'),
          _buildButton('Perfil', context,'/Perfil'),
      //_buildButton('Prueba pulsera', MySaca("HEART_RATE"), context),
      //_buildButton('Prueba Ritmo', MyRitmo(), context),
         
        ],
      ),
    );
  }

  

  Flex _buildButton(String label,BuildContext context, String route) {
    return Flex(
      direction: Axis.vertical,
      
      // mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 300,
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: () {
              Navigator.of(context).pushNamed( route);
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
}
