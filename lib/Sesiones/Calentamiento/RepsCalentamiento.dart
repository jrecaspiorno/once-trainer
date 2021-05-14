import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Sesiones/Transfers/EjCalentamiento.dart';



class RepcountCal extends StatefulWidget {
  final EjCalentamiento ejCalentamiento;

  RepcountCal({@required this.ejCalentamiento });
  @override
  _RepCountCalState createState() =>  _RepCountCalState();
}

class _RepCountCalState extends State<RepcountCal> {

  int repcount;
  int sercount;
  int reptot;
  int sertot;

  void _rmrep() {
    setState(() {
      if(repcount > 0){
        repcount--;

      }
    });
  }

  void _resetrep() {
    setState(() {

      repcount = reptot;
    });
  }

  void _rmser() {
    setState(() {
      if(sercount > 0){
        sercount--;
        repcount = reptot;
      }
    });

  }

  void _resetser() {
    setState(() {
      sercount = sertot;
    });
  }

  void initState() {


    repcount = widget.ejCalentamiento.reps;
    reptot = widget.ejCalentamiento.reps;
    sercount = widget.ejCalentamiento.series;
    sertot = widget.ejCalentamiento.series;


  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      child:  Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Series",style:  TextStyle(fontSize: 30.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Semantics(
                  button: true,
                  excludeSemantics: true,
                  label: "Resetear series",
                  child:FloatingActionButton(
                      heroTag: "reset series",
                      backgroundColor: Colors.indigo,
                      onPressed: _resetser,
                      child:  Icon(
                        Icons.refresh,
                        color:Colors.white,
                      )
                  ),
                ),
                Text('$sercount', semanticsLabel: '$sercount series' ,style:  TextStyle(fontSize: 60.0)),
                Semantics(
                  button: true,
                  excludeSemantics: true,
                  label: "serie realizada",
                  child:FloatingActionButton(
                      heroTag: "add series",
                      backgroundColor: Colors.indigo,
                      onPressed: _rmser,
                      child:  Icon(
                        Icons.remove_circle,
                        color:Colors.white,
                      )
                  ),
                ),

              ],
            ),
            Text("Repeticiones",style:  TextStyle(fontSize: 30.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Semantics(
                  button: true,
                  excludeSemantics: true,
                  label: "resetear repeticiones",
                  child:FloatingActionButton(
                      heroTag: "reset rep",
                      backgroundColor: Colors.indigo,
                      onPressed: _resetrep,
                      child:  Icon(
                        Icons.refresh,
                        color:Colors.white,
                      )
                  ),
                ),
                Text('$repcount', semanticsLabel: '$repcount repeticiones', style:  TextStyle(fontSize: 60.0)),
                Semantics(
                  label: "repetición realizada",
                  excludeSemantics: true,
                  button: true,
                  child:FloatingActionButton(
                      heroTag: "add rep",
                      backgroundColor: Colors.indigo,
                      onPressed: _rmrep,
                      child:  Icon(
                          Icons.remove_circle,
                          color:Colors.white
                      )
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}