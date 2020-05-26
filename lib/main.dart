import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutterapp/Login/GoogleLogin.dart';

import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:provider/provider.dart';

import 'package:flutterapp/Data/moor_database.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';

import 'Menu/Menu.dart';
import 'Registro/DatePicker/DatePicker.dart';

import 'Registro/Registro.dart';

Future<void> main() async {
  debugPrint = (String message, {int wrapWidth}) {};
  developer.log('log me', name: 'once_trainer');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override // Sobrescribir para indicar que creamos nuestro widget
  Widget build(BuildContext context) {


    return Provider(
      create: (_) => AppDatabase(),
      child: ChangeNotifierProvider<LoginState>(
        create: (BuildContext context) => LoginState() ,
        child: MaterialApp(
//            localizationsDelegates: [
//              GlobalMaterialLocalizations.delegate,
//              GlobalWidgetsLocalizations.delegate,
//              GlobalCupertinoLocalizations.delegate,
//            ],
          supportedLocales: [
            const Locale('es','ES'),
          ],

          title: 'App actividad física',
          routes: {
            '/':(BuildContext context){
              //var state = context.watch<LoginState>();
              var state = Provider.of<LoginState>(context);
              if(state.isLogedIn()){
                return Menu();
              }else{
                if(state.getFecha()) {
                  return LoginPage();
                }
                else{
                  return DatePicker();
                }


              }
            }
          },
//        home: Scaffold(
//          // Widget con app prediseñada, esquema
//          appBar: AppBar(
//            title: Text('Home'),
//            backgroundColor: Colors.indigo,
//          ),
//          body: Home(),
//        ),
        ),
      ),
    );
  }
}

//class Home extends StatefulWidget{
//  @override
//  State<StatefulWidget> createState() => _Home();
//
//}
//
//class _Home extends State<Home> {
//  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);
//  GoogleSignInAccount _currentUser;
//  void initState() {
//
//    super.initState();
//    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
//      setState(() {
//        _currentUser = account;
//      });
//    });
//    _googleSignIn.signInSilently();
//  }
//  @override
//  Widget build(BuildContext context) {
//    final database = Provider.of<AppDatabase>(context);
//    get(database);
//    return Center(
//      child: _buildHome(context, database.usuarioDAO)
//    );
//  }
//  Future<void> get(AppDatabase data) async{
//    List<UsuarioData> users = await data.usuarioDAO.getUsers();
//    users.length;
//    var u = users.length;
//  }
//  Widget _buildHome(BuildContext context, UsuarioDAO usuarioDAO){
//    if(_currentUser != null){
//      return Center(
//        child: Column(
//          mainAxisSize: MainAxisSize.min,
//          children: <Widget>[
//            _buildButton('Menu', Menu() , context)
//          ],
//        ),
//      );
//    }
//    else{
//      //usuarioDAO.deleteAllUsers();
//      return Provider(
//          create: (_) => GoogleSignIn(scopes: ['profile', 'email']),
//          child:Center(
//            child: Column(
//              mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
//
//              _buildButton('Registro', GoogleSingUp( usuarioDAO: usuarioDAO,) , context),
//              _buildButton('Login', GoogleLogin(usuarioDAO) , context)
//          ],
//        ),
//      ));
//    }
//  }
//
//  Column _buildButton(String label, Widget funcion, BuildContext context) {
//    return Column(
//      // mainAxisSize: MainAxisSize.min,
//      children: [
//        RaisedButton(
//          onPressed: () {
//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => funcion),
//            );
//          },
//          color: Colors.indigo,
//          textColor: Colors.white,
//          padding: EdgeInsets.all(24.0),
//          child: Text(label, style: TextStyle(fontSize: 30)),
//        ),
//        const SizedBox(height: 40),
//      ],
//    );
//  }



//}





