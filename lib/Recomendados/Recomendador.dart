import 'package:flutter/material.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/Recomendados/BodyParts.dart';
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/ejercicios/Ejercicio.dart';
import 'package:flutterapp/ejercicios/FactoriaEj.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart' as xml;
import 'package:quiver/collection.dart';
import 'dart:convert';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'dart:math';

class RecomendadorView extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();


  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    var state = context.watch<LoginState>();
    Future<List<Ejercicio>> getEjercicios(BuildContext context) async {
      await database.recomendadosDAO.deleteAll();
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      final manifestContent =
          await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
      final Map<String, dynamic> manifesMap = json.decode(manifestContent);
      List<String> xmls = manifesMap.keys
          .where((key) => key.contains('todos_ejercicios'))
          .toList();
      List<Ejercicio> ejerciciosf = List();
      List<String> names = List();
      var ejercicios = Multimap<String, Ejercicio>();
      for (int i = 0; i < xmls.length; ++i) {
        String xmlS = await DefaultAssetBundle.of(context).loadString(xmls[i]);
        var file = xml.parse(xmlS);
        //logica para seleccionar ej's
        var ej = FactoriaEj.GenerateEj(file);
        ejercicios.add(ej.grupoprincipal, ej);
      }
      if(!_prefs.containsKey('hayCambio')) _prefs.setBool('hayCambio', false);
      if (!_prefs.getBool('hayCambio')) {
        ejercicios.asMap().forEach((key, value) async{
          
          int r = value.length;
          var rng = Random();
          int pos;
          List<Ejercicio> l = value.toList();
          bool ok = false;
          while(!ok){
            pos = rng.nextInt(r);
            List<Recomendado> rec = await database.recomendadosDAO.getRecsbyid(l[pos].name);
            int v = 0;
            if(rec.isNotEmpty){
              for(Recomendado recomendado in rec){
                

                if(recomendado.idUser == state.getId()){
                  ok = true;
                  break;
                }
                if(v == rec.length) break;
                v++;
              }
            }
            //Recomendado re = Recomendado(id:, grupo:l[pos].grupoprincipal , idUser:  state.getId(), fecha: )
            //if(!database.recomendadosDAO.isInRecom(re))
            
          }
          
          ejerciciosf.add(l[pos]);
          names.add(l[pos].name);
        });
         _prefs.setBool('hayCambio', true);
        _prefs.setStringList("recomendados", names);
      }
      else{
        List<Ejercicio> val = ejercicios.values.toList();
        names = _prefs.getStringList('recomendados');
        names.forEach((element) {
          for (Ejercicio ej in val){
            if(ej.name == element){
              ejerciciosf.add(ej);
              break;
            }
          }
          
        });
      }
      return ejerciciosf;
    }

    return Scaffold(
      body: FutureBuilder(
          future: getEjercicios(context),
          builder: (_, data) {
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
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 3),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        width: 270,
                        height: 10,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          autofocus: true,
                          onPressed: () async {
                            SharedPreferences _prefs = await SharedPreferences.getInstance();
                            ejercicios.forEach((element) {
                              Recomendado rec = Recomendado(
                                  id: element.name,
                                  grupo: element.grupoprincipal,
                                  idUser: state.getId(),
                                  fecha: DateTime.now());
                              database.recomendadosDAO.insertRecomendado(rec);
                              
                            });
                            _prefs.setBool('hayCambio', false);
                          },
                          color: Colors.indigo,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(24.0),
                          child: Text(
                            'Sesion Completada',
                            style: TextStyle(fontSize: 30),
                            textAlign: TextAlign.center,
                          ),
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
