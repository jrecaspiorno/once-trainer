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
            '3. Perfil: Dispone de otros cuatro botones, el historial de actividades, historial clínico, los ajustes y desconectarse.\n'
            '4. Historial Actividades: Se muestra la información de la actividad fisica registrad por laa aplicación.\n'
            '5. Historial clinico: Hay disponible información sobre el peso, el ritmo cardiaco y las energias quemadas. La información se mostrara en forma de grafica y escrita para que sea accesible para el usuario.\n'
            '6. Ajustes: En la ventana ajustes se compone de 5 botones para poner las dolencias del usuario, modificar la fecha de nacimiento, cambiar el nivel de dificultad, crear una copia de seguridad asi como recuperar los datos.\n'
            '7. Lista de ejercicios: En esta ventana se encuentran todos los ejercicios de la aplicación. Si el usuario entra en un ejercicio podra realizarlo y cuando terminé pulsara el boton de hecho.\n'
            '8. Recomendador: El recomendador recomienda ejercicios diferentes cada día para que el usuario realize sesiones de entrenamiento equilibradas.\n'
            '9. Alerta ritmo cárdiaco: Al realizar cualquier ejercicio si el usuario supera su frecuencia maxima cardiaca saltará una alerta, tanto visual como sonora, para que el usuaro reduzca la actividad física.\n'),
      )
    );
  }
}
