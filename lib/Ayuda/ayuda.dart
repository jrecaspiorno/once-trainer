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

      body: Container(
        margin: EdgeInsets.only(left: 10,top:5,right:5),

        child: ListView(

          children:  <Widget>[
            Text('1. Instrucciones generales: Es necesario conexión a internet solo la primera vez hasta que se inicie sesión con una cuenta válida, '
                  'tener instalado en el dispositivo Google Fit y aceptar los permisos de Google.\n', style: TextStyle(fontSize: 17)),
            Text( '2. Menú principal: Se compone de cuatro botones, recomendador, lista de ejercicios, perfil y ayuda.\n', style: TextStyle(fontSize: 17)),
            Text( '3. Perfil: Dispone de otros cuatro botones, el historial de actividades, historial clínico, los ajustes y desconectarse.\n', style: TextStyle(fontSize: 17)),
            Text( '4. Historial Actividades: Se muestra la información de la actividad fisica registrad por la aplicación.\n', style: TextStyle(fontSize: 17)),
            Text(  '5. Historial clínico: Hay disponible información sobre el peso, el ritmo cardiaco y las energias quemadas. La información se mostrará en forma de gráfica y escrita para que sea accesible para el usuario.\n', style: TextStyle(fontSize: 17)),
            Text('6. Ajustes: En la ventana ajustes se compone de cinco botones para poner las dolencias del usuario, modificar la fecha de nacimiento, cambiar el nivel de dificultad, '
                   'crear una copia de seguridad asi como recuperar los datos.\n', style: TextStyle(fontSize: 17)),
            Text(  '7. Lista de ejercicios: En esta ventana se encuentran todos los ejercicios de la aplicación. Si el usuario entra en un ejercicio podra realizarlo y cuando terminé pulsará el botón de hecho.\n', style: TextStyle(fontSize: 17)),
            Text( '8. Recomendador: Muestra ejercicios personalizados diferentes cada día para que el usuario realize sesiones de entrenamiento equilibradas.\n', style: TextStyle(fontSize: 17)),
            Text( '9. Alerta ritmo cárdiaco: Al realizar cualquier ejercicio si el usuario supera su frecuencia máxima cardiaca saltará una alerta, tanto visual como sonora, para que el usuario reduzca la actividad física.\n', style: TextStyle(fontSize: 17)),
          ]
        ),
      )
    );
  }
}
