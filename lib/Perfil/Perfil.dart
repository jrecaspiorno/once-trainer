import 'package:flutter/material.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/Perfil/Dolencias.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatelessWidget {

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
                    const SizedBox(height: 20),
                      MyData(usuarioData: mainUser ),
                      MyButtonType(

                     ),
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
          _buildButton('Historial Actividades', MyProfile(), context),
          _buildButton('Historial Clínico', MyProfile(), context),
          _buildButton(
              'Dolencias',
              Dolencias(

              ),
              context),
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


  const MyData({Key key, @required this.usuarioData}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            'images/avatar.jpg',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Text(usuarioData.nombre + " "+ usuarioData.apellido, style: TextStyle(fontSize: 30)),
        ],
      ),
    );
  }
}
