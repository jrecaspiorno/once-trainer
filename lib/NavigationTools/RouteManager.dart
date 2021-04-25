import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/Ayuda/ayuda.dart';
import 'package:flutterapp/Calentamiento/WarmUpExercises.dart';
import 'package:flutterapp/Calentamiento/WarmUpHome.dart';
import 'package:flutterapp/Historial/EntradaBuild.dart';
import 'package:flutterapp/Historial/HistorialBuild.dart';
import 'package:flutterapp/Menu/Menu.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as routes;
import 'package:flutterapp/Perfil/Ajustes.dart';
import 'package:flutterapp/Perfil/Dificultad.dart';
import 'package:flutterapp/Perfil/Dolencias.dart';
import 'package:flutterapp/Perfil/EditarNombre.dart';
import 'package:flutterapp/Perfil/EditarPerfil.dart';
import 'package:flutterapp/Perfil/Perfil.dart';
import 'package:flutterapp/Perfil/historialClinico.dart';
import 'package:flutterapp/Recomendados/Recomendador.dart';
import 'package:flutterapp/Registro/DatePicker/DatePicker.dart';
import 'package:flutterapp/Registro/Registro.dart';
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:flutterapp/ejercicios/BuildEjercicio.dart';
import 'package:flutterapp/ejercicios/lista_ejer.dart';
import 'package:flutterapp/pulsera/datosHistorial/sacaImprimeSemana.dart';
import 'package:provider/provider.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case routes.MainPage:
        return MaterialPageRoute(builder: (_) {
          var state = Provider.of<LoginState>(_);
          if (state.isLogedIn()) {
            return Menu();
          } else {
            return state.getFecha() ? DatePicker() : LoginPage();
          }
        });
      case routes.RecomdadorPage:
        return MaterialPageRoute(builder: (_) => RecomendadorView());
      case routes.ListaEjerciciosPage:
        return MaterialPageRoute(builder: (_) => MyList());

      case routes.PerfilPage:
        return MaterialPageRoute(builder: (_) => MyProfile());

      case routes.HistorialActividadesPage:
        return MaterialPageRoute(builder: (_) => MyHistory());

      case routes.DolenciasPage:
        return MaterialPageRoute(
            builder: (_) => Dolencias(
                  id: args,
                ));
      case routes.EditarFechaPage:
        return MaterialPageRoute(
            builder: (_) => EditProfile(
                  id: args,
                ));
      case routes.HistorialClinicoPage:
        return MaterialPageRoute(builder: (_) => MyHistorial());
      case routes.EjercicioPage:
        {
          var a = args as List<dynamic>;
          return MaterialPageRoute(
              builder: (_) => BuildEjercicio(
                    ejercicio: a.first,
                    route: a.last,
                  ));
        }
      case routes.SacaDatosPage:
        return MaterialPageRoute(builder: (_) => MySaca(args));
      case routes.ActividadPage:
        {
          var a = args as List<dynamic>;
          return MaterialPageRoute(
              builder: (_) => BuildHistEntry(
                    dao: a.first,
                    entry: a.last,
                  ));
        }
      case routes.AjustesPage:
        return MaterialPageRoute(builder: (_) => Ajustes());
      case routes.DificultadPage:
        return MaterialPageRoute(builder: (_) => Dificultad());

      case routes.AyudaPage:
        return MaterialPageRoute(builder: (_) => MyHelp());
      case routes.EditarNombrePage:
        return MaterialPageRoute(builder: (_) => EditName( id: args,));
      case routes.CalentamientoPage:
        return MaterialPageRoute(builder: (_) => WarmUpHome());
      case routes.EjsCalentamientoPage:
        return MaterialPageRoute(builder: (_) => WarmUpExercises());
    }
  }
}
