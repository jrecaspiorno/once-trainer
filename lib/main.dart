import 'dart:developer' as developer;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutterapp/Data/HiveData/RecomendadorList/RecomList.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/NavigationTools/RouteManager.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;
import 'package:flutterapp/Registro/AppleLogin/Auth_Service.dart';
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:flutterapp/ejercicios/EjerciciosState.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'Registro/AppleLogin/apple_sign_in_available.dart';

Future<void> main() async {
  debugPrint = (String message, {int wrapWidth}) {};
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(RecomListAdapter());
  final appleSignInAvailable = await AppleSignInAvailable.check();
  developer.log('log me', name: 'once_trainer');
  setup();
  runApp(MultiProvider(providers: [
    Provider<AppDatabase>(
      create: (_) => AppDatabase(),
    ),
    ChangeNotifierProvider<LoginState>(
      create: (BuildContext context) => LoginState(),
    ),
    ChangeNotifierProvider<EjercicioState>(
      create: (BuildContext context) => EjercicioState(),
    ),
    Provider<AppleSignInAvailable>.value(value: appleSignInAvailable),
    Provider<AuthService>(create: ((_)=> AuthService()),)
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override // Sobrescribir para indicar que creamos nuestro widget
  Widget build(BuildContext context) {
    return  MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('es', 'ES'),
        ],
        navigatorKey: locator<NavigationService>().navigatorkey,
        title: 'App actividad física',
        initialRoute: route.MainPage,
        onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
