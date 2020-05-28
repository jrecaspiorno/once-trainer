import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Alertas/Alertas.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  final database = Provider.of<AppDatabase>(context); 
   Alerts alert;   
   return Scaffold(
     body: Center(
       child: Consumer<LoginState>(
         builder: (BuildContext context, LoginState value, Widget child){
           return value.isLoading() ? CircularProgressIndicator() : child;
         },
         child: RaisedButton(
           child: Text("Registro"),
           onPressed: () async {
              var state = context.read<LoginState>();
              await state.login(database.usuarioDAO);
              if(state.getNoDateAlert()){
                alert = Alerts(context: context, firstButtonText: "Ok", fun1: () { state.logout();Navigator.pop(context);}, title: "Alerta", message: "No has introducido tu fecha de nacimiento y no tienes cuenta previa");
                alert.showAlertDialog();
             }
           },
         ),
       ),
     ),
   );
  }
}