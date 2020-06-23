import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/Historial/EntradaBuild.dart';
import 'package:flutterapp/Historial/HistorialBuild.dart';
import 'package:flutterapp/Menu/Menu.dart';
import 'package:flutterapp/Perfil/Dolencias.dart';
import 'package:flutterapp/Perfil/EditarPerfil.dart';
import 'package:flutterapp/Perfil/Perfil.dart';
import 'package:flutterapp/Perfil/historialClinico.dart';
import 'package:flutterapp/Registro/DatePicker/DatePicker.dart';
import 'package:flutterapp/Registro/Registro.dart';
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:flutterapp/ejercicios/BuildEjercicio.dart';
import 'package:flutterapp/ejercicios/lista_ejer.dart';
import 'package:flutterapp/pulsera/datosHistorial/sacaImprimeSemana.dart';
import 'package:flutterapp/recomendados.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as routes;


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;

    switch(settings.name){
      case routes.MainPage:
        return MaterialPageRoute(builder: (_) {
          var state = Provider.of<LoginState>(_);
              if(state.isLogedIn()){
                return Menu();
              }else{
                return state.getFecha() ? DatePicker() : LoginPage();

              }
        });
      case routes.RecomendaosPage:
        return MaterialPageRoute(builder: (_) => MyRecomList());
      
      case routes.ListaEjerciciosPage:
        return MaterialPageRoute(builder: (_) => MyList());
      
      case routes.PerfilPage :
        return MaterialPageRoute(builder: (_) => MyProfile());

      case routes.HistorialActividadesPage:
        return MaterialPageRoute(builder: (_)=> MyHistory());

      case routes.DolenciasPage:
        return MaterialPageRoute(builder: (_)=> Dolencias(id: args,)); 
      case routes.EditarFechaPage:
        return MaterialPageRoute(builder: (_) => EditProfile(id: args,));
      case routes.HistorialClinicoPage :
        return MaterialPageRoute(builder: (_) => MyHistorial());
      case routes.EjercicioPage:
        return MaterialPageRoute(builder: (_) =>BuildEjercicio(ejercicio: args ,));
      case routes.SacaDatosPage:
        return MaterialPageRoute(builder: (_) => MySaca(args));
      case routes.ActividadPage :{
        var a = args as List<dynamic>;
        return MaterialPageRoute(builder: (_) => BuildHistEntry(dao: a.first, entry: a.last,));     
      
      }

    }
  }



}

