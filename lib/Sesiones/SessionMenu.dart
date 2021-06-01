import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/Sesiones/Factorias/SessionExerciseFactory.dart';

import 'dart:convert';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;
import 'package:flutterapp/Sesiones/Transfers/Session.dart';
import 'package:flutterapp/Sesiones/Transfers/SessionsExercise.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:xml/xml.dart' as xml;

class SessionMenu extends StatefulWidget {
  Session session;
  String level;

  SessionMenu({@required this.session, @required this.level});

  @override
  _SessionMenuState createState() => _SessionMenuState();
}

class _SessionMenuState extends State<SessionMenu> {
  int n = 0;
  final NavigationService _navigationService = locator<NavigationService>();
  SharedPreferences _prefs;

  Future<List<EjSesion>> getEjs(BuildContext context) async {
    _prefs = await SharedPreferences.getInstance();
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifesMap = json.decode(manifestContent);
    List<String> xmls = manifesMap.keys
        .where((key) => key.contains(widget.session.nameid))
        .toList();
    List<EjSesion> ejercicios = [];
    for (int i = 0; i < xmls.length; ++i) {
      String xmlS = await DefaultAssetBundle.of(context).loadString(xmls[i]);
      var file = xml.parse(xmlS);
      ejercicios.add(FactoriaEjSesion.GenerateEjSesion(file, widget.level));
    }

    ejercicios.sort((a, b) => a.id.compareTo(b.id));
    return ejercicios;
  }

  int s = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Widget con app prediseñada, esquema
        appBar: AppBar(
          leading: BackButton(
            onPressed: _navigationService.goBack,
          ),
          title: Text(widget.session.name),
          backgroundColor: Colors.indigo,
        ),
        extendBodyBehindAppBar: false,
        body: Container(
          child: FutureBuilder(
            future: getEjs(context),
            builder: (_, data) {
              if (data.hasData) {
                List<EjSesion> ejs = data.data;
                return Container(
                  child: Center(
                    child: ListView(
                      addSemanticIndexes: true,
                      shrinkWrap: true,
                      children: [
                        IndexedSemantics(
                          index: s,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: SizedBox(
                                width: 270,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(EdgeInsets.all(15)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.indigo),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                        textStyle: MaterialStateProperty.all<
                                            TextStyle>(TextStyle(
                                          color: Colors.white,
                                        ))),
                                    child: Text("Calentamiento",
                                        style: TextStyle(fontSize: 35)),
                                    onPressed: () => _navigationService
                                        .navigateTo(route.CalentamientoPage))),
                          ),
                        ),
                        for (int i = 0; i < widget.session.list.length; ++i)
                          _sessionButton(i, ejs),
                        IndexedSemantics(
                          index: s+1,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: SizedBox(
                                width: 270,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(EdgeInsets.all(15)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.indigo),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                        textStyle: MaterialStateProperty.all<
                                            TextStyle>(TextStyle(
                                          color: Colors.white,
                                        ))),
                                    child: Text("Estiramientos",
                                        style: TextStyle(fontSize: 35)),
                                    onPressed: () => _navigationService
                                        .navigateTo(route.EstiramientosHomePage, arguments: [widget.session.estiramientosname, widget.session.id]))),
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
            },
          ),
        ));
  }

  Widget _sessionButton(int pos, List<EjSesion> ejs) {
    s = ++s;
    List<EjSesion> aux = [];
    aux.addAll(ejs);
    aux = aux.sublist(n, n + widget.session.list[pos].numero);
    n = widget.session.list[pos].numero;
    aux.sort((a, b) => a.id.compareTo(b.id));
    return IndexedSemantics(
      index: s,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: SizedBox(
          width: 270,
          child: ElevatedButton(
              style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.indigo),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                    color: Colors.white,
                  ))),
              child: Text(widget.session.list[pos].name,
                  style: TextStyle(fontSize: 35)),
              onPressed: () => _navigationService
                      .navigateTo(route.ListEjsSessionPage, arguments: [
                    aux,
                    (_prefs.getString('nivel') == "a")
                        ? widget.session.list[pos].avanzado
                        : widget.session.list[pos].principiante,
                    widget.session.list[pos].name,
                    widget.session.id
                  ])),
        ),
      ),
    );
  }
}
