import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterapp/Data/HiveData/RecomendadorList/RecomList.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:flutterapp/ejercicios/Ejercicio.dart';
import 'package:flutterapp/ejercicios/FactoriaEj.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:quiver/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart' as xml;

class RecomendadorView extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  List<Ejercicio> ejerciciosf = List();

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    var state = context.watch<LoginState>();
    Multimap<String, String> auxmap = Multimap<String, String>();
    var ejercicios = Multimap<String, Ejercicio>();
    List<String> names = List();
    List<Restriccione> tags;
    Box recomListBox;
    SharedPreferences _prefs;

    Future init() async {
      recomListBox = await Hive.openBox('recomlists');
      _prefs = await SharedPreferences.getInstance();
      final manifestContent =
          await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
      final Map<String, dynamic> manifesMap = json.decode(manifestContent);
      tags = await database.restriccionesDAO.resActivas();
      List<String> xmls = manifesMap.keys
          .where((key) => key.contains('todos_ejercicios'))
          .toList();
      for (int i = 0; i < xmls.length; ++i) {
        String xmlS = await DefaultAssetBundle.of(context).loadString(xmls[i]);
        var file = xml.parse(xmlS);
        //logica para seleccionar ej's
        var ej = FactoriaEj.GenerateEj(file);

        ejercicios.add(ej.grupoprincipal, ej);
        auxmap.add(ej.grupoprincipal, ej.name);
      }

      if (!_prefs.containsKey('ListaEjers'))
        auxmap.forEachKey((key, value) {
          var aux = RecomList(key, value, 0, 0);
          recomListBox.add(aux);
        });

      if (!_prefs.containsKey('ListaEjers')) _prefs.setBool('ListaEjers', true);
    }

    Future<List<Ejercicio>> ejs() async {
      await init();
      int vueltas = 0;
      double media = 0;
      List<Ejercicio> ejerciciosf = List();
      var l = recomListBox.values;
      if (!_prefs.containsKey('hayCambio')) _prefs.setBool('hayCambio', false);
      if (!_prefs.getBool('hayCambio')) {
        l.forEach((element) {
          media += element.hechosTotales;
        });
        media /= l.length;
        while (vueltas < l.length) {
          int i = 0;
          l.forEach((element) {
            int resta = element.hechosTotales - 3;
            if (media >= (resta) && vueltas < l.length) {
              var rng = Random();
              var listAux = element.ejercicios;
              int auxhechosLista = element.hechosLista;
              if (listAux.length == auxhechosLista) auxhechosLista = 0;
              int pos = rng.nextInt(listAux.length - auxhechosLista);
              var name = listAux[pos];
              Ejercicio ej;

              var x = ejercicios.asMap()[element.tipo].toList();
              int j = 0;
              while (j < x.length && ej == null) {
                if (x[j].name == name) {
                  ej = x[j];
                }
                ++j;
              }
              j = 0;
              bool ok = true;
              while (ok && j < tags.length) {
                int k = 0;
                while (ok && k < ej.tags.length) {
                  if (tags[j].tipo == ej.tags[k]) ok = false;
                  ++k;
                }
                ++j;
              }
              listAux.removeAt(pos);
              listAux.add(name);
              auxhechosLista++;
              if (ok) {
                vueltas++;
                ejerciciosf.add(ej);
                names.add(ej.name);
              }
              recomListBox.putAt(
                  i,
                  RecomList(element.tipo, listAux, auxhechosLista,
                      element.hechosTotales));
            }
            ++i;
          });
        }
        _prefs.setBool('hayCambio', true);
        _prefs.setStringList("recomendados", names);
      } else {
        List<Ejercicio> val = ejercicios.values.toList();
        names = _prefs.getStringList('recomendados');
        names.forEach((element) {
          int i = 0;
          bool ok = false;
          while (i < val.length && !ok) {
            if (val[i].name == element) {
              ejerciciosf.add(val[i]);
              ok = true;
            }
            ++i;
          }
        });
      }
      return ejerciciosf;
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
      appBar: AppBar(
        title: Text('Recomendador'),
        backgroundColor: Colors.indigo,
      ),
      body: FutureBuilder(
          future: ejs(),
          builder: (_, data) {
            show = true;
            List<Ejercicio> ejercicios = data.data;
            if (ejercicios != null) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: ejercicios.length,
                      itemBuilder: (_, index) {
                        Padding(
                          padding: EdgeInsets.only(bottom: 30),
                        );
                        return Flex(
                          mainAxisSize: MainAxisSize.min,
                          direction: Axis.vertical,
                          textDirection: TextDirection.ltr,
                          verticalDirection: VerticalDirection.down,
                          children: [
                            mySizedBox(),
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
                            SizedBox(
                              height: 40,
                            ),
                          ].where(notNull).toList(),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      border: Border.all(color: Colors.black, width: 6),
                    ),
                    height: 80,
                    child: SizedBox.expand(
                      child: RaisedButton(
                        autofocus: true,

                        onPressed: () async {
                          _prefs.setBool('hayCambio', false);
                          recomListBox.close();
                          _navigationService.goBack();
                        },
                        color: Colors.pink,
                        textColor: Colors.white,
                        //padding: EdgeInsets.all(24.0),
                        child: Text(
                          'Sesion Completada',
                          style: TextStyle(fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
