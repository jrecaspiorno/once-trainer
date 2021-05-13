import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;
import 'dart:convert';

import 'package:xml/xml.dart' as xml;
import 'EjCalentamiento.dart';
import 'FactoriaCalentamiento.dart';


class WarmUpHome extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  Future<List<EjCalentamiento>> getCalentamiento(BuildContext context) async {

    final manifestContent =
    await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifesMap = json.decode(manifestContent);
    List<String> xmls = manifesMap.keys
        .where((key) => key.contains('ejercicios_calentamiento'))
        .toList();
    List<EjCalentamiento> ejercicios = [];
    for (int i = 0; i < xmls.length; ++i) {
      String xmlS = await DefaultAssetBundle.of(context).loadString(xmls[i]);
      var file = xml.parse(xmlS);
      ejercicios.add(FactoriaCalentamiento.GenerateEjC(file));
    }
    ejercicios.sort((a , b) => a.id.compareTo(b.id));
    print(ejercicios);
    return ejercicios;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Widget con app prediseñada, esquema
        appBar: AppBar(
          leading: BackButton(
            onPressed: _navigationService.goBack,
          ),
          title: Text('Calentamiento'),
          backgroundColor: Colors.indigo,
        ),
        extendBodyBehindAppBar: false,
        body: FutureBuilder(
          future: getCalentamiento(context),
          builder: (context, data) {

            if (data.hasData) {

              List<EjCalentamiento> ejercicios = data.data;
              return Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text("Posición Básica", textAlign: TextAlign.center ,style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        ),),
                      ),


                      Padding(
                        padding: EdgeInsets.fromLTRB(35, 25, 20, 70),
                        child: Text("La posición básica consiste en estar de pie, piernas separadas a la anchura de los hombros, brazos extendidos a los lados del cuerpo, cabeza ergida y mirada al frente.",
                          style: TextStyle(
                              fontSize: 30
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: RaisedButton(
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            textColor: Colors.white,
                            color: Colors.indigo,
                            padding: EdgeInsets.all(15.0),
                            child: Text('Empezar', style: TextStyle(fontSize: 30)),
                            onPressed: () => _navigationService.navigateTo(route.EjCalentamientoListPage, arguments: ejercicios)
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          })
        );
  }
}
