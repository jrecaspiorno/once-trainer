import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/Alertas/Alertas.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final NavigationService _navigationService = locator<NavigationService>();
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
    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(30),
        children: <Widget>[
          _buildButton('Recomendaciones',route.RecomendaosPage),
          _buildButton('Lista Ejercicios', route.ListaEjerciciosPage),
          _buildButton('Perfil',  route.PerfilPage),
          _buildButton('Recomendador', route.RecomdadorPage),
          
        ],
      ),
    );
  }

  Flex _buildButton(String label, String route) {
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
              //Navigator.of(context).pushNamed(route);
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
}
