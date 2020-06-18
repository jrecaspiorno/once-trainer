import 'package:flutter/material.dart';
import 'package:flutterapp/Menu/Menu.dart';
import 'package:flutterapp/Perfil/Perfil.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/Data/moor_database.dart';

import 'EntradaBuild.dart';



class MyHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final daoHist = Provider.of<AppDatabase>(context, listen: false).historialDAO;

    Future<List<Historial>> getHist(BuildContext context) async {
      
      List<Historial> hist = await daoHist.getallHist();
      return hist;
    }



    return MaterialApp(
      title: 'App actividad física',
      home: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => MyProfile()));
              },
            ),
            title: Text('Tu historial'),
            backgroundColor: Colors.indigo,
          ),
          extendBodyBehindAppBar: false,
          body: Container(
            child: FutureBuilder(
                future: getHist(context),
                builder: (context,data){
                  if(data.hasData){
                    List<Historial> hist = data.data;
                    return ListView.builder(
                      padding: EdgeInsets.fromLTRB(15, 1, 15, 1),
                      itemCount: hist.length,
                      itemBuilder: (context,index){
                        Padding(
                          padding: EdgeInsets.only(bottom: 30),
                        );
                        return Flex(
                          direction: Axis.vertical,
                          textDirection: TextDirection.ltr,
                          verticalDirection: VerticalDirection.down,
                          children: [
                            SizedBox(height: 40),
                            SizedBox(
                              width: 270,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                autofocus: true,
                                onPressed: () {
                                  final Historial entry = hist[index];
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => (BuildHistEntry(dao: daoHist,entry: entry,)),
                                  ));
                                },
                                color: Colors.indigo,
                                textColor: Colors.white,
                                padding: EdgeInsets.all(24.0),
                                child: Text(hist[index].ejercicio, style: TextStyle( fontSize: 30),
                                  textAlign: TextAlign.center, ),
                              ),
                            ),


                            //const SizedBox(height: 20),
                          ],
                        );
                      },

                    );
                  }
                  else{
                    return Center(child: CircularProgressIndicator(),);
                  }
                }

            ),
          )
      ),
    );
  }
}








