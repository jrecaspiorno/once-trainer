import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutterapp/NavigationTools/RouteManager.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';

import 'package:flutterapp/Registro/SignUpState.dart';

import 'package:flutterapp/ejercicios/EjerciciosState.dart';


import 'package:provider/provider.dart';

import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutter_localizations/flutter_localizations.dart';



Future<void> main() async {
  debugPrint = (String message, {int wrapWidth}) {};
  developer.log('log me', name: 'once_trainer');
  setup();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override // Sobrescribir para indicar que creamos nuestro widget
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [
        Provider<AppDatabase>(create: (_) => AppDatabase(),),
        ChangeNotifierProvider<LoginState>(create: (BuildContext context) => LoginState(),),
        ChangeNotifierProvider<EjercicioState>(create: (BuildContext context) => EjercicioState(),)

      ],
        child: MaterialApp(
           localizationsDelegates: [
             GlobalMaterialLocalizations.delegate,
             GlobalWidgetsLocalizations.delegate,
             GlobalCupertinoLocalizations.delegate,
           ],
          supportedLocales: [
            const Locale('es','ES'),
          ],
          navigatorKey: locator<NavigationService>().navigatorkey,
          title: 'App actividad física',
          initialRoute: '/',
          onGenerateRoute: RouteGenerator.generateRoute,
          
        ),
      );
  }
}



