import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/ejercicios/AppTimer.dart';
import 'package:flutterapp/ejercicios/AppRepCount.dart';
import 'package:flutterapp/ejercicios/Ejercicio.dart';
import 'package:flutterapp/ejercicios/EjercicioTiempo.dart';
import 'package:flutterapp/pulsera/datosRitmoTR/alertaRitmo.dart';
import 'package:flutterapp/pulsera/datosRitmoTR/sacaDatosRitmoCardiaco.dart';

import 'package:flutterapp/Data/moor_database.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/Registro/SignUpState.dart';


class BuildEjercicio extends StatefulWidget {
  Ejercicio ejercicio;

  BuildEjercicio({Ejercicio ejercicio}) {
    this.ejercicio = ejercicio;
  }

  @override
  _BuildEjercicioState createState() => _BuildEjercicioState();
}

class _BuildEjercicioState extends State<BuildEjercicio> {
  
  bool exceso = false;
  
Future<bool> sacaSiExceso () async{
  DateTime endDate = DateTime.now();

  final database = Provider.of<AppDatabase>(context, listen: false);

  var state = context.read<LoginState>();
  String id = state.getId();
  var user = await database.usuarioDAO.getUser(id);
  var fecha_n = user.edad.year; // En teoria pasamos solo el año
  //print(fecha_n);
  var edad = endDate.year - fecha_n;
  bool aux = await getHealthRate(edad);

  print("aux");
  print(aux);
  return aux;
}

bool cambiaValor(){
  sacaSiExceso().then((valor) {exceso = valor; setState(() {
    print("En cambia");
    print(exceso);
  });});
}

void addEjercicio() async{
  final database = Provider.of<AppDatabase>(context, listen: false);
  final FirebaseUser user = await FirebaseAuth.instance.currentUser();
  final uid = user.uid;
  Historial hist = new Historial(id: null,
      dificultad: 0,
      ejercicio: widget.ejercicio.name,
      fecha: DateTime.now() ,
      duracion: 30,
      calorias: widget.ejercicio.calories,
      idUser: uid,
      activo: true
  );
  database.historialDAO.insertHistorial(hist);
  return;
}

  void initState() {
    super.initState();
    cambiaValor();
  }

  @override
  Widget build(BuildContext context) {
    Ejercicio ej = widget.ejercicio;

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
          title: Text(widget.ejercicio.name),
          backgroundColor: Colors.indigo,
        ),
        body: Container(
            child: Column(
              children: <Widget>[
                //*
                  !exceso
                  ? Text("", style: TextStyle(fontSize: 0))
                  : MyRitmo(),
                //*/
                //if(exceso) MyRitmo(),
                const SizedBox(height: 20,),
                widgetEj(ej),

                const SizedBox(height: 20,),

                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 19,
                      ),
                      child: Text("Descripcion: " + widget.ejercicio.description, style: TextStyle(
                        fontSize: 27,))
                  ),

                ),
              new RaisedButton(
                color:Colors.indigo,
                onPressed: addEjercicio,
                child: new Text("Hecho",style: TextStyle(
                color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),),

              ),
              ],
            )
        ),
      ),
    );
  }
  Widget widgetEj(Ejercicio ejercicio){
    if(ejercicio is EjercicioTiempo) {
      EjercicioTiempo ejt = widget.ejercicio;
      return Container(
        child: AppTimer(time: ejt.time),
      );
    }else{
      return Container(
          child: RepCounter(),
      );
    };
  }
}






