import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        title: Text('Lista Ejercicios'),
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
                return ListView.builder(
                  padding: EdgeInsets.fromLTRB(15, 1, 15, 1),
                  itemCount: ejercicios.length,
                  itemBuilder: (context, index) {
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
                            onPressed: () {

                            },
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
                        const SizedBox(height: 40),
                      ].where(notNull).toList(),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );

  }



}