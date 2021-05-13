import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;
import 'dart:convert';

import 'package:xml/xml.dart' as xml;
import 'EjCalentamiento.dart';
import 'FactoriaCalentamiento.dart';

class WarmUpList extends StatefulWidget {
  final List<EjCalentamiento> ejs;

  WarmUpList({@required this.ejs});

  @override
  State<StatefulWidget> createState() => _WarmUpListState();
}

class _WarmUpListState extends State<WarmUpList> {
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

  List<EjCalentamiento> newOrder() {
    List<EjCalentamiento> l1 = [];
    List<EjCalentamiento> l2 = [];
    l1.addAll(widget.ejs);
    l2.addAll(widget.ejs);
    l1.removeWhere((element) {
      return !element.marcado;
    }
    );

    l2.retainWhere((element) => !element.marcado);
    l2.addAll(l1);
    return l2;
    
  }

  @override
  Widget build(BuildContext context) {
    show = true;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: _navigationService.goBack,
        ),
        title: Text("Lista Calentamiento"),
        backgroundColor: Colors.indigo,
      ),
      extendBodyBehindAppBar: false,
      body: Container(
        child: ListView.builder(
            padding: EdgeInsets.fromLTRB(15, 1, 15, 1),
            itemCount: widget.ejs.length,
            itemBuilder: (context, index) {
              List<EjCalentamiento> myEjs = newOrder();
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
                      child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(15)),
                              backgroundColor: (myEjs[index].marcado)
                                  ? MaterialStateProperty.all<Color>(
                                      Colors.blueGrey)
                                  : MaterialStateProperty.all<Color>(
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

                            myEjs[index].name,
                            style: TextStyle(fontSize: 35,),
                            textAlign: TextAlign.center,
                            semanticsLabel:(myEjs[index].marcado) ?
                                "Ejercicio hecho, boton desactivado" : null,
                          ),
                          onPressed: () => (myEjs[index].marcado)
                              ? null
                              : _navigationService.navigateTo(
                                  route.EjCalentaminetoBuildPage,
                                  arguments: [myEjs, index, myEjs.length])),
                    ),
                    const SizedBox(height: 40),
                  ].where(notNull).toList(),
              );
            }),
      ),
    );
  }
}
