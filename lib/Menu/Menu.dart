import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/Alertas/Alertas.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  _prepareVariables() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (!preferences.containsKey('Diff')) preferences.setInt('Diff', 0);
  }

  final NavigationService _navigationService = locator<NavigationService>();
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
    _prepareVariables();
    final uDao = context.watch<AppDatabase>().usuarioDAO;
    var state = Provider.of<LoginState>(context, listen: false);
    String id = state.getId();
    var user = uDao.getUser(id);
    user.then((value) => state.setDate(value.edad));
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Menu"),
          backgroundColor: Colors.indigo,
        ),
        body: menuView(context),
      ),
    );
  }

  Widget menuView(BuildContext context) {
    final database = context.watch<AppDatabase>();
    return Container(
      alignment: Alignment.center,

      //height: double.infinity,
      child: Center(
        heightFactor: double.infinity,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            _buildButton('Recomendador', route.RecomdadorPage, Colors.indigo ),
            _buildButton('Lista Ejercicios', route.ListaEjerciciosPage, Colors.indigo),
            _buildButton('Sesiones', route.SessionPage, Colors.indigo),
            _buildButton('Perfil', route.PerfilPage, Colors.deepPurple),
            _buildButton('Ayuda', route.AyudaPage, Colors.green),


          ],
        ),
      ),
    );
  }

  Flex _buildButton(String label, String route, Color color) {
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
              _navigationService.navigateTo(route);
            },
            color: color,
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
