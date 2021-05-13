import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;
import 'package:flutterapp/ejercicios/Ejercicio.dart';
import 'package:flutterapp/ejercicios/FactoriaEj.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart' as xml;

class MyList extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  SharedPreferences _prefs;
  int diff;
  _init() async {
    _prefs = await SharedPreferences.getInstance();
    diff = _prefs.getInt('Diff');
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Ejercicio>> getEjercicios(BuildContext context) async {
      await _init();
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
        ejercicios.add(FactoriaEj.GenerateEj(file));
      }
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
            future: getEjercicios(context),
            builder: (context, data) {
              show = true;
              if (data.hasData) {
                List<Ejercicio> ejercicios = data.data;
                return ListView.builder(
                  padding: EdgeInsets.fromLTRB(15, 1, 15, 1),
                  itemCount: ejercicios.length,
                  itemBuilder: (context, index) {

                    return IndexedSemantics(
                      index: index,
                      child: Flex(
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
                              onPressed: () {
                                List<dynamic> arg = [];
                                ejercicios[index].setDiff(diff);
                                arg.add(ejercicios[index]);
                                arg.add('/Lista Ejercicios');
                                _navigationService.navigateTo(route.EjercicioPage,
                                    arguments: arg);
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
                      ),
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
