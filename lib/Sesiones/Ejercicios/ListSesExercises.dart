import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;

import 'package:flutterapp/Sesiones/Transfers/Session.dart';
import 'package:flutterapp/Sesiones/Transfers/SessionsExercise.dart';

import 'dart:convert';

import 'package:xml/xml.dart' as xml;

class SessionExList extends StatefulWidget {
  final List<EjSesion> ejs;
  final Tarea tarea;
  final String name;
  final int sesid;
  @override
  State<StatefulWidget> createState() => _SessionExListState();

  SessionExList(
      {@required this.ejs, @required this.tarea, @required this.name, @required this.sesid});
}

class _SessionExListState extends State<SessionExList> {
  final NavigationService _navigationService = locator<NavigationService>();
  bool show = true;

  bool notNull(Object o) => o != null;

  SizedBox mySizedBox() {
    if (show) {
      show = false;
      return SizedBox(height: 40);
    } else
      return null;
  }

  Future<List<EjSesion>> newOrder() async {
    List<EjSesion> l1 = [];
    List<EjSesion> l2 = [];
    l1.addAll(widget.ejs);
    l2.addAll(widget.ejs);
    l1.removeWhere((element) {
      return !element.marcado;
    });

    l2.retainWhere((element) => !element.marcado);
    l2.addAll(l1);
    return l2;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        leading: BackButton(
          onPressed: _navigationService.goBack,
        ),
        title: Text(widget.name),
        backgroundColor: Colors.indigo,

      ),


      body: FutureBuilder(
          future: newOrder(),
          builder: (context, data) {
            if (data.hasData) {
              return ListView.builder(
                semanticChildCount:  widget.ejs.length,
                addSemanticIndexes: false,
                  shrinkWrap: true,
                  padding: EdgeInsets.fromLTRB(15, 1, 15, 1),
                  itemCount: widget.ejs.length,
                  itemBuilder: (context, i) {
                    List<EjSesion> myEjs = data.data;

                    return IndexedSemantics(
                          index: i,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              EdgeInsets.all(15)),
                                      backgroundColor: (myEjs[i].marcado)
                                          ? MaterialStateProperty.all<Color>(
                                              Colors.blueGrey)
                                          : MaterialStateProperty.all<Color>(
                                              Colors.indigo),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      ),
                                      textStyle:
                                          MaterialStateProperty.all<TextStyle>(
                                              TextStyle(
                                        color: Colors.white,
                                      ))),
                                  child: Text(
                                    myEjs[i].name,
                                    style: TextStyle(
                                      fontSize: 35,
                                    ),
                                    textAlign: TextAlign.center,
                                    semanticsLabel: (myEjs[i].marcado)
                                        ? "Ejercicio hecho, boton desactivado"
                                        : null,
                                  ),
                                  onPressed: () => (myEjs[i].marcado)
                                      ? null
                                      : _navigationService.navigateTo(
                                          route.SessionEjBuildPage,
                                          arguments: [
                                              myEjs,
                                              i,
                                              widget.tarea,
                                            widget.name,
                                            widget.sesid
                                            ])),



                    ),
                          ),
                        );
                  });
            }else{
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
