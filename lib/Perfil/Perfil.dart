import 'package:flutter/material.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/Perfil/Dolencias.dart';
import 'package:flutterapp/Perfil/historialClinico.dart';
import 'package:flutterapp/Registro/GoogleSignUp.dart';
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'Historial.dart';

class MyProfile extends StatelessWidget {

  

  Widget LogoutButton(BuildContext context){
    return Column(
      children: <Widget>[
        RaisedButton(
          onPressed: (){
            
            context.read<LoginState>().logout();
            Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp()));
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);

    return MaterialApp(
      title: 'App actividad física',
      home: Scaffold(
          // Widget con app prediseñada, esquema
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            title: Text('Perfil'),
            backgroundColor: Colors.indigo,
          ),
          body: FutureBuilder(
            future: getData(database.usuarioDAO),
            builder: (context,data){
              if(data.hasData){
                List<UsuarioData> users = data.data;
                UsuarioData mainUser = users[0];
                return ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(25),
                    ),

                      MyData(usuarioData: mainUser ),
                      Padding(
                        padding: EdgeInsets.all(20),
                      ),
                      MyButtonType(),
                      LogoutButton(context),
                  ],
                );
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
//            ListView(children: [
//            const SizedBox(height: 20),
//            MyData(usuarioData: ),
//            MyButtonType(
//
//            ),
//          ])
          ),
    );
  }
  Future<List<UsuarioData>> getData(UsuarioDAO usuarioDAO) async {
    return usuarioDAO.getUsers();
  }

}

class MyButtonType extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 20),
          _buildButton('Historial Actividades', HistorialView(), context),
          _buildButton('Historial Clínico', MyHistorial(), context),
          _buildButton('Dolencias', Dolencias(),context),


        ],
      ),
    );
  }

  Column _buildButton(String label, Widget funcion, BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        RaisedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => funcion),
            );
          },
          color: Colors.indigo,
          textColor: Colors.white,
          padding: EdgeInsets.all(24.0),
          child: Text(label, style: TextStyle(fontSize: 30)),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class MyData extends StatelessWidget {
  final UsuarioData usuarioData;


  MyData({Key key, @required this.usuarioData}) : super(key: key);






  @override
  Widget build(BuildContext context) {

    return Center(
      widthFactor: 15,
      child: Row(

        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              usuarioData.photoUrl,
              width: 50,

            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Flexible(
            child: Text(usuarioData.nombre,
            style: TextStyle(
              fontSize: 25,
            ),),
          ),
          Flexible(
            child: Text(usuarioData.edad.toString(),
            style: TextStyle(
              fontSize: 25,
            ),),
          )
        ],
      ),
    );
  }
}
