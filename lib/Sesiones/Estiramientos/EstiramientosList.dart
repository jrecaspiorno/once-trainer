import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;
import 'package:flutterapp/Sesiones/Transfers/Estiramiento.dart';





class EstiramientosList extends StatefulWidget {
  final List<EjEstiramiento> ejs;

  @override
  State<StatefulWidget> createState() => _EstiramientosListState();

  EstiramientosList(
      {@required this.ejs});
}

class _EstiramientosListState extends State<EstiramientosList> {
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

  Future<List<EjEstiramiento>> newOrder() async {
    List<EjEstiramiento> l1 = [];
    List<EjEstiramiento> l2 = [];
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
        title: Text("Estiramientos"),
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
                    List<EjEstiramiento> myEjs = data.data;

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
                                  route.EstiramientosBuildPage,
                                  arguments: [
                                    myEjs,
                                    i,
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
