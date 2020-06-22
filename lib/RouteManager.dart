import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/Historial/EntradaBuild.dart';
import 'package:flutterapp/Historial/HistorialBuild.dart';
import 'package:flutterapp/Menu/Menu.dart';
import 'package:flutterapp/Perfil/Dolencias.dart';
import 'package:flutterapp/Perfil/EditarPerfil.dart';
import 'package:flutterapp/Perfil/historialClinico.dart';
import 'package:flutterapp/Registro/DatePicker/DatePicker.dart';
import 'package:flutterapp/Registro/Registro.dart';
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:flutterapp/ejercicios/BuildEjercicio.dart';
import 'package:flutterapp/ejercicios/lista_ejer.dart';
import 'package:flutterapp/recomendados.dart';
import 'package:provider/provider.dart';

import 'Perfil/Perfil.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;

    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) {
          var state = Provider.of<LoginState>(_);
              if(state.isLogedIn()){
                return Menu();
              }else{
                return state.getFecha() ? DatePicker() : LoginPage();

              }
        });
      case '/Recomendaciones':
        return MaterialPageRoute(builder: (_) => MyRecomList());
      
      case '/Lista Ejercicios':
        return MaterialPageRoute(builder: (_) => MyList());
      
      case '/Perfil':
        return MaterialPageRoute(builder: (_) => MyProfile());

      case '/Historial Actividades':
        return MaterialPageRoute(builder: (_)=> MyHistory());

      case '/Dolencias':
        return MaterialPageRoute(builder: (_)=> Dolencias(id: args,)); 
      case '/Editar Fecha':
        return MaterialPageRoute(builder: (_) => EditProfile(id: args,));
      case '/Historial Clínico' :
        return MaterialPageRoute(builder: (_) => MyHistorial());
      case '/Ejercicio':
        return MaterialPageRoute(builder: (_) =>BuildEjercicio(ejercicio: args ,));
      case '/Actividad' :
        if(args is List<dynamic>)
          return MaterialPageRoute(builder: (_) => BuildHistEntry(dao: args.first, entry: args.last,));     
      
      

    }
  }



}