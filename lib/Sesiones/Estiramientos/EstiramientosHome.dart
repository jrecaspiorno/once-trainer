import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;
import 'package:flutterapp/Sesiones/Factorias/EstiramientoFactory.dart';
import 'package:flutterapp/Sesiones/Transfers/Estiramiento.dart';
import 'dart:convert';

import 'package:xml/xml.dart' as xml;



class EstiramientosHome extends StatefulWidget {

  String lname;

  EstiramientosHome({@required this.lname});

  @override
  _EstiramientosHomeState createState() => _EstiramientosHomeState();
}

class _EstiramientosHomeState extends State<EstiramientosHome> {
  final NavigationService _navigationService = locator<NavigationService>();

  Future<List<EjEstiramiento>> getEstiramiento(BuildContext context) async {

    final manifestContent =
    await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifesMap = json.decode(manifestContent);
    List<String> xmls = manifesMap.keys
        .where((key) => key.contains(widget.lname))
        .toList();
    List<EjEstiramiento> ejercicios = [];
    for (int i = 0; i < xmls.length; ++i) {
      String xmlS = await DefaultAssetBundle.of(context).loadString(xmls[i]);
      var file = xml.parse(xmlS);
      ejercicios.add(FactoriaEstiramiento.GenerateEjS(file));
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
          title: Text('Estiramiento'),
          backgroundColor: Colors.indigo,
        ),
        extendBodyBehindAppBar: false,
        body: FutureBuilder(
            future: getEstiramiento(context),
            builder: (context, data) {

              if (data.hasData) {

                List<EjEstiramiento> ejercicios = data.data;
                return Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [



                        Padding(
                          padding: EdgeInsets.fromLTRB(35, 15, 20, 25),
                          child: Text("Mantener cada estiramiento 20-30 segundos, sin hacer rebotes.",
                            style: TextStyle(
                                fontSize: 30
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(35, 25, 20, 70),
                          child: Text("Al terminar el estiramiento volver a la posición inicial lentamente.",
                            style: TextStyle(

                                fontSize: 30
                            ),textAlign: TextAlign.center,
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
                              onPressed: () => _navigationService.navigateTo(route.EstiramientosListPage, arguments: ejercicios )
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
