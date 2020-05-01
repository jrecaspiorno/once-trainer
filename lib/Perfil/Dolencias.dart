import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Dolencias extends StatefulWidget{
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

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () {
            Navigator.pop(context);
          }),
          title: Text("Dolencias"),
          backgroundColor: Colors.indigo,
        ),
        body: ListView.builder(
          itemCount: Dolencias.length,
          itemBuilder: (BuildContext context, int index) {
            String key = Dolencias.keys.elementAt(index);
            return Card(
              child: Container(
                padding: EdgeInsets.all(1),
                child: Column(
                  children: <Widget>[
                    CheckboxListTile(
                      value: Dolencias[key],
                      title: Text(
                        "$key",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      onChanged: (bool dolencia) {
                        setState(() {
                          Dolencias[key] = dolencia;
                        });
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
