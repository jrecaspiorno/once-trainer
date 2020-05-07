import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/Data/moor_database.dart';

import 'Menu/Menu.dart';

class Login extends StatefulWidget {
  UsuarioDAO usuarioDAO;

  Login(this.usuarioDAO);

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final String labelNombre = 'Introduzca su nombre';
  final String labelApellido = 'Introduzca su apellido';
  final String labelEdad = 'Introduzca su edad';
  final _MycontrollerN = TextEditingController();
  final _MycontrollerA = TextEditingController();
  final _MycontrollerE = TextEditingController();
  
  String Nombre;
  String Apellido;
  int edad;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: LoginView(widget.usuarioDAO, context),
      ),
    );
  }

  Widget LoginView(UsuarioDAO usuarioDAO, BuildContext context) {
    estoyLogeado(usuarioDAO, context);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Center(
          child: Container(

            width: 400,
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CampoNombre(labelNombre),
                Padding(padding: const EdgeInsets.all(17),),
                CampoApellido(labelApellido),
                Padding(padding: const EdgeInsets.all(17),),
                CampoEdad(labelEdad),
                Padding(padding: const EdgeInsets.all(17),),
                AceptarCambios(usuarioDAO)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void estoyLogeado(UsuarioDAO dao, BuildContext context) async{
    List<UsuarioData> data = await dao.getUsers();
    if(data.length > 0){
      _showDialog();
    }

  }
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Login Error"),
          content: new Text("Usted ya esta logeado"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => (Menu()),
                      //fullscreenDialog: Navigator.of(context).pop()
                    ));

              },
            ),
          ],
        );
      },
    );
  }
  
  Widget AceptarCambios(UsuarioDAO usuarioDAO){
    return RaisedButton(
      color: Colors.indigo ,
      textColor: Colors.white,
      padding: EdgeInsets.all(24.0),
      child: Text('Login',
          style: TextStyle(fontSize: 30)),
      onPressed: (){
        usuarioDAO.insertUser(UsuarioData(nombre: _MycontrollerN.text, apellido: _MycontrollerA.text, edad: int.parse(_MycontrollerE.text) ));

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => (Menu()),
            ));
      },
    );
  }
  
  Widget CampoNombre(String text ){
    return Container(
      width: 300,
      child: Material(
          elevation: 5,
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.indigo,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _MycontrollerN,
                decoration: InputDecoration(
                  labelText: text,
                  fillColor: Colors.indigo,
                  filled: true,
                ),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),

              ),

            ],
          )
      ),
    );
  }
  Widget CampoApellido(String text ){
    return Container(
      width: 300,
      child: Material(
          elevation: 5,
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.indigo,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _MycontrollerA,
                decoration: InputDecoration(
                  labelText: text,
                  fillColor: Colors.indigo,
                  filled: true,
                ),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),

              ),

            ],
          )
      ),
    );
  }
  Widget CampoEdad(String text ){
    return Container(
      width: 300,
      child: Material(
          elevation: 5,
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.indigo,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _MycontrollerE,
                decoration: InputDecoration(
                  labelText: text,
                  fillColor: Colors.indigo,
                  filled: true,
                ),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),

              ),

            ],
          )
      ),
    );
  }
}
