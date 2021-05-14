import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/Sesiones/Transfers/Estiramiento.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;

class EstiramientosBuild extends StatefulWidget {
  int pos;
  List<EjEstiramiento> ejs;

  @override
  _EstiramientosBuildState createState() => _EstiramientosBuildState();

  EstiramientosBuild({@required this.pos, @required this.ejs});
}

class _EstiramientosBuildState extends State<EstiramientosBuild> {
  final NavigationService _navigationService = locator<NavigationService>();

  _end() {
    widget.ejs[widget.pos].setmarcado(true);
    _navigationService.goBack();
    _navigationService.replaceView(route.EstiramientosListPage,
        arguments: widget.ejs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: showEj(widget.ejs, context),
      ),
    );
  }

  Widget showEj(List<EjEstiramiento> ej, BuildContext context) {
    List<Widget> w = myWidgets(ej);

    return ListView.builder(
      reverse: false,
      semanticChildCount: w.length,
      addSemanticIndexes: false,
      itemCount: w.length,
      itemBuilder: (context, i) {
        return IndexedSemantics(
          index: i,
          child: Center(child: w[i]),
        );
      },
    );
  }

  List<Widget> myWidgets(List<EjEstiramiento> ej) {

    List<Widget> w = [];
    w.add(Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
      child: Center(
          child: Text(
            ej[widget.pos].name,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )),
    ),);
    w.add(Padding(
        padding: const EdgeInsets.fromLTRB(25, 10, 10, 5),
        child: Text(ej[widget.pos].desc,
            style: TextStyle(
              fontSize: 27,

            ))),);
    w.add(Padding(
        padding: const EdgeInsets.fromLTRB(25, 10, 10, 5),
        child: Text(ej[widget.pos].pasos,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 27,
            ))),);
    w.add(Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 20),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.pink,
        onPressed: () => _end(),
        //addEjercicioBase(context, ejstatus),
        padding: EdgeInsets.all(15.0),
        child: Text(
          "Terminar",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ));
    return w;
  }
}
