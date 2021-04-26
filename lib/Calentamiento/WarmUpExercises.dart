import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Calentamiento/BuildEjCalentamiento.dart';
import 'package:flutterapp/Calentamiento/EjCalentamiento.dart';
import 'package:flutterapp/Calentamiento/FactoriaCalentamiento.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;


import 'package:xml/xml.dart' as xml;

class WarmUpExercises extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => _WarmUpExercisesState();


}

class _WarmUpExercisesState extends State<WarmUpExercises>{
  final NavigationService _navigationService = locator<NavigationService>();
  int nEjCal;
  int max;
  String name;

  void initState(){
    super.initState();
    nEjCal = 0;
    max = 12;
    name = "Rotaciones de Tobillos";

  }
  void _next(EjCalentamiento e){
    setState(() {
      name = e.name;
      if(nEjCal < max ) ++nEjCal;
    });
  }
  void _previous(EjCalentamiento e){
    setState(() {
      name = e.name;
      if(nEjCal > 0) --nEjCal;
    });
  }
  void _changeName(){
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    Future<List<EjCalentamiento>> getCalentamiento(BuildContext context) async {

      final manifestContent =
      await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
      final Map<String, dynamic> manifesMap = json.decode(manifestContent);
      List<String> xmls = manifesMap.keys
          .where((key) => key.contains('ejercicios_calentamiento'))
          .toList();
      List<EjCalentamiento> ejercicios = List();
      for (int i = 0; i < xmls.length; ++i) {
        String xmlS = await DefaultAssetBundle.of(context).loadString(xmls[i]);
        var file = xml.parse(xmlS);
        ejercicios.add(FactoriaCalentamiento.GenerateEjC(file));
      }
      ejercicios.sort((a , b) => a.id.compareTo(b.id));
      print(ejercicios);
      return ejercicios;
    }

    bool show = true;
    bool notNull(Object o) => o != null;
    SizedBox mySizedBox() {
      if (show) {
        show = false;
        return SizedBox(height: 40);
      } else
        return null;
    }


    return Scaffold(
      // Widget con app prediseñada, esquema
      appBar: AppBar(
        leading: BackButton(
          onPressed: _navigationService.goBack,
        ),
        title: Text(name),
        backgroundColor: Colors.indigo,
      ),
      extendBodyBehindAppBar: false,
      body: Container(
        child: FutureBuilder(
            future: getCalentamiento(context),
            builder: (context, data) {
              show = true;
              if (data.hasData) {
                List<EjCalentamiento> ejercicios = data.data;
                return showEj(ejercicios[nEjCal]);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );

  }


  Widget showEj(EjCalentamiento ej) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: RepcountCal(ejCalentamiento: ej,),
            ),
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 19,
                ),
                child: Text("Descripcion: " + ej.description,
                    style: TextStyle(
                      fontSize: 27,
                    ))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 20, 20),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  autofocus: true,
                  color: Colors.pink,
                  onPressed: () => _previous(ej),
                  //addEjercicioBase(context, ejstatus),
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "Anterior",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 10, 20),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  autofocus: true,
                  color: Colors.pink,
                  onPressed: () => _next(ej),
                  //addEjercicioBase(context, ejstatus),
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "Siguiente",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )



        ],
      );
  }

}
