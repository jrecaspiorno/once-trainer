import 'package:flutter/material.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/Recomendados/BodyParts.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/ejercicios/Ejercicio.dart';
import 'package:flutterapp/ejercicios/FactoriaEj.dart';
import 'package:xml/xml.dart' as xml;
import 'package:quiver/collection.dart';
import 'dart:convert';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/NavigationTools/locator.dart';

class RecomendadorView extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  void aniadirPrueba(RecomendadosDAO dao) async {
    await dao.deleteAll();
    Recomendado rec1 =
        Recomendado(id: "a", grupo: "d", idUser: "1", fecha: createDate(1999));
    Recomendado rec2 =
        Recomendado(id: "b", grupo: "d", idUser: "1", fecha: createDate(1998));
    Recomendado rec3 =
        Recomendado(id: "c", grupo: "d", idUser: "1", fecha: createDate(1997));
    Recomendado rec4 =
        Recomendado(id: "d", grupo: "d", idUser: "1", fecha: createDate(1996));
    Recomendado rec5 =
        Recomendado(id: "e", grupo: "d", idUser: "1", fecha: createDate(1995));
    Recomendado rec6 =
        Recomendado(id: "f", grupo: "d", idUser: "1", fecha: createDate(1994));
    Recomendado rec7 =
        Recomendado(id: "g", grupo: "d", idUser: "1", fecha: createDate(1993));
    Recomendado rec8 =
        Recomendado(id: "h", grupo: "d", idUser: "1", fecha: createDate(1992));
    dao.insertRecomendado(rec1);
    dao.insertRecomendado(rec2);
    dao.insertRecomendado(rec3);
    dao.insertRecomendado(rec4);
    dao.insertRecomendado(rec5);
    dao.insertRecomendado(rec6);
    dao.insertRecomendado(rec7);
    dao.insertRecomendado(rec8);
    List<Recomendado> ls = await dao.getallRec();
    ls.length;
    List<Recomendado> l = await dao.getNRecomendado();

    l.forEach((element) async {
      await dao.deleteRecomendado(element);
    });
    ls = await dao.getallRec();
    ls.length;
  }

  DateTime createDate(int y) {
    return DateTime(y);
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    //aniadirPrueba(database.recomendadosDAO);
    Future<List<Ejercicio>> getEjercicios(BuildContext context) async {
      final manifestContent =
          await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
      final Map<String, dynamic> manifesMap = json.decode(manifestContent);
      List<String> xmls = manifesMap.keys
          .where((key) => key.contains('todos_ejercicios'))
          .toList();
      //List<Ejercicio> ejercicios = List();
      var ejercicios = Multimap<String, Ejercicio>();
      for (int i = 0; i < xmls.length; ++i) {
        String xmlS = await DefaultAssetBundle.of(context).loadString(xmls[i]);
        var file = xml.parse(xmlS);
        //logica para seleccionar ej's
        var ej = FactoriaEj.GenerateEj(file);
        ejercicios.add(ej.grupoprincipal, ej);
      }
      var l = ejercicios.asMap()[Cuello];
      return l;
    }

    return Scaffold(
      body: FutureBuilder(
          future: getEjercicios(context),
          builder: (_, data) {
            List<Ejercicio> ejercicios = data.data;
            if(ejercicios != null){
            return ListView.builder(
              itemCount: ejercicios.length,
              itemBuilder: (_, int index) {
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                );
                return Flex(
                  mainAxisSize: MainAxisSize.min,
                  direction: Axis.vertical,
                  textDirection: TextDirection.ltr,
                  verticalDirection: VerticalDirection.down,
                  children: [
                    SizedBox(height: 40),
                    SizedBox(
                      width: 270,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        autofocus: true,
                        onPressed: () => _navigationService.replaceView(
                            route.EjercicioPage,
                            arguments: ejercicios[index]),
                        color: Colors.indigo,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(24.0),
                        child: Text(
                          ejercicios[index].name,
                          style: TextStyle(fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    //const SizedBox(height: 20),
                  ],
                );
              },
            );}
            else {
              
              return Center(child: CircularProgressIndicator());
            } 
          }),
    );
  }
}
