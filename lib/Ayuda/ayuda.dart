import 'package:flutter/material.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';

class MyHelp extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: _navigationService.goBack,
        ),
        title: Text("Historial Clinico"),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Text('1. Instrucciones generales: Es necesario conexión a internet solo la primera vez hasta que se inicie sesión con una cuenta valida, '
              'tener instalado en el dispositivo Google Fit y aceptar los permisos de Google.\n'
            '2. Menú principal: Se compone de cuatro botones, recomendador, lista de ejercicios, perfil y ayuda\n'
            '3. Perfil: '),
      )
    );
  }
}
