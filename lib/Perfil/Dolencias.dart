import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:provider/provider.dart';
import 'package:xml/xml.dart' as xml;

class Dolencias extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StateDolencias();
}

class _StateDolencias extends State<Dolencias> {
  Map<String, bool> Dolencias = {
    "Rodilla": false,
    "Cadera": false,
    "Tobillo": false,
    "Brazo": false,
    "Muñeca": false
  };

//  Widget build(BuildContext context) {
//    return Expanded(
//      child: StreamBuilder<List<Restricciones>>(
//        stream: restriccionesDao.findAllRestFromUser(),
//        builder: (_, snapshot) {
//          if (snapshot.hasData) return Container();
//          final restricciones = snapshot.data;
//          return ListView.builder(
//              itemCount: restricciones.length,
//              itemBuilder: (_, index) {
//                return Card(
//                  child: Container(),
//                );
//              });
//        },
//      ),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    Future<void> getRestricciones(BuildContext context) async {
      //database.restriccionesDAO.deleteAllRes();
      List<Restriccione> rests = await database.restriccionesDAO.getAllRest();
      List<String> tags;
      if (rests.isEmpty) {
        String xmlS =
            await DefaultAssetBundle.of(context).loadString("Tags/tags.xml");
        var file = xml.parse(xmlS);
        var elements = file.findAllElements('tag');

        rests = elements.map((elements) {
          return Restriccione(tipo: elements.text, activo: false, idUser: 0);
        }).toList();
        rests.length;
        for (int i = 0; i < rests.length; ++i) {
          database.restriccionesDAO.insertRest(rests[i]);
        }
      }
    }

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            leading: BackButton(onPressed: () {
              Navigator.pop(context);
            }),
            title: Text("Dolencias"),
            backgroundColor: Colors.indigo,
          ),
          body: FutureBuilder(
              future: getRestricciones(context),
              builder: (context, data) {
                return StreamBuilder(
                    stream: database.restriccionesDAO.wachAllRest(),
                    builder:
                        (context, AsyncSnapshot<List<Restriccione>> snapshot) {
                      final rests = snapshot.data ?? List();

                      return ListView.builder(
                        itemCount: rests.length,
                        itemBuilder: (_, int index) {
                          Map<int, Pair> map = ListtoMap(rests);
                          int key = map.keys.elementAt(index);
                          String s = map.values.elementAt(index).s;
                          return Card(
                            child: Container(
                              padding: EdgeInsets.all(1),
                              child: Column(
                                children: <Widget>[
                                  CheckboxListTile(
                                    value: map[key].b,
                                    title: Text(
                                      "$s",
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    onChanged: (bool dolencia) {
                                      setState(() {
                                        database.restriccionesDAO.updateRes(Restriccione(id: key,idUser: 0,activo: dolencia, tipo: s ));
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    });
              })),
    );
  }

  Map<int,Pair> ListtoMap(List<Restriccione> restwuser){
    if(restwuser.length > 0) {
      Map<int, Pair> res = Map();
      Map<int, Pair> aux;
      for (int i = 0; i < restwuser.length; ++i) {
        Restriccione r = restwuser[i];
        Pair pr = Pair(s: r.tipo, b: r.activo);
        res[r.id]= pr;
      }
      return res;
    }
    else return null;
  }
}

class Pair{
  final String s;
  final bool b;
  const Pair({@required this.s, @required  this.b}) ;
}
