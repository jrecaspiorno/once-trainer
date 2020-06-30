import 'package:flutter/material.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/ejercicios/Ejercicio.dart';
import 'package:flutterapp/ejercicios/FactoriaEj.dart';
import 'package:xml/xml.dart' as xml;
import 'dart:convert';

class Recomendados extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    Future<List<Ejercicio>> getEjercicios(BuildContext context) async {
      final manifestContent =
      await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
      final Map<String, dynamic> manifesMap = json.decode(manifestContent);
      List<String> xmls = manifesMap.keys
          .where((key) => key.contains('todos_ejercicios'))
          .toList();
      List<Ejercicio> ejercicios = List();
      for (int i = 0; i < xmls.length; ++i) {
        String xmlS = await DefaultAssetBundle.of(context).loadString(xmls[i]);
        var file = xml.parse(xmlS);
        //logica para seleccionar ej's
        ejercicios.add(FactoriaEj.GenerateEj(file));
      }
    }
  }
}