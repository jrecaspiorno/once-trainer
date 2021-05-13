

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'package:xml/xml.dart' as xml;

import 'EjCalentamiento.dart';
import 'RepsCalentamiento.dart';


class WarmupBuild extends StatefulWidget {

  WarmupBuild({@required this.ejs, this.pos, this.fin});
  int pos;
  int fin;
  List<EjCalentamiento> ejs;
  @override
  State<StatefulWidget> createState() => _WarmupBuildState();

}

class _WarmupBuildState extends State<WarmupBuild>{

  final NavigationService _navigationService = locator<NavigationService>();
  final focusNode = FocusNode();
  void _end(){
    _navigationService.goBack();
    _navigationService.goBack();
  }
  void _previous(EjCalentamiento e){
    focusNode.requestFocus();
    _navigationService.goBack();
    _navigationService.navigateTo(route.EjCalentaminetoBuildPage, arguments: [widget.ejs, widget.pos-1, widget.fin]);
  }
  void _next(EjCalentamiento e){
    focusNode.requestFocus();

    _navigationService.goBack();
    _navigationService.navigateTo(route.EjCalentaminetoBuildPage, arguments: [widget.ejs, widget.pos+1, widget.fin]);
  }
  @override
  void initState() {
    focusNode.requestFocus();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Widget con app prediseñada, esquema
      appBar: AppBar(
        leading: BackButton(
          onPressed: _navigationService.goBack,
        ),
        title: Text(widget.ejs[widget.pos].name),
        backgroundColor: Colors.indigo,
      ),
      extendBodyBehindAppBar: false,
      body: Container(
        child: showEj(widget.ejs),
      ),
    );
  }
  Widget showEj(List<EjCalentamiento> ej ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: RepcountCal(ejCalentamiento: ej[widget.pos],),
          ),
        ),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 19,
              ),
              child: Text("Descripcion: " + ej[widget.pos].description,
                  style: TextStyle(
                    fontSize: 27,
                  ))),
        ),
        SizedBox(
          width: 270,
          child: Padding(
            padding:  const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    backgroundColor:  MaterialStateProperty.all<Color>(
                        Colors.indigo),
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(
                          color: Colors.white,
                        ))),
                child: Text(
                  "Hecho",
                  style: TextStyle(fontSize: 35),
                ),
                onPressed: ()  {
                  widget.ejs[widget.pos].setmarcado(true);
                  _navigationService.goBack();
                  _navigationService.replaceView(route.EjCalentamientoListPage, arguments: widget.ejs);



              }
        ),
          ))





      ],
    );
  }
}

/*Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 20, 20),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                autofocus: true,
                color: Colors.pink,
                onPressed: () => (widget.pos > 0) ? _previous(ej[widget.pos-1]) : _previous(ej[widget.pos]),
                //addEjercicioBase(context, ejstatus),
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Anterior",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 20),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                autofocus: true,
                color: Colors.pink,
                onPressed: () => (widget.pos < widget.fin) ? _next(ej[widget.pos +1]) : _end(),
                //addEjercicioBase(context, ejstatus),
                padding: EdgeInsets.all(15.0),
                child: Text((widget.fin == widget.pos) ? "Terminar" :
                  "Siguiente",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        )*/