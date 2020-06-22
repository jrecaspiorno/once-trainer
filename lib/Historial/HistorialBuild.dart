import 'package:flutter/material.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';

import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/Data/moor_database.dart';





class MyHistory extends StatefulWidget {
  @override
  _MyHistoryState createState() => _MyHistoryState();
}

class _MyHistoryState extends State<MyHistory> {
  @override
  Widget build(BuildContext context) {
    final daoHist = Provider.of<AppDatabase>(context, listen: false).historialDAO;
    final NavigationService _navigationService = locator<NavigationService>();

    final id = context.watch<LoginState>().getId();
    

    return WillPopScope(
        onWillPop:() {
          print('Backbutton pressed (device or appbar button), do whatever you want.');
         _navigationService.goBack();
          return Future.value(false);
        },
        child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed:_navigationService.goBack,
              ),
              title: Text('Tu historial'),
              backgroundColor: Colors.indigo,
            ),
            extendBodyBehindAppBar: false,

            body: Container(
              child: StreamBuilder(
                  stream: daoHist.watchallHistFromUser(id),
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
                                    List<dynamic> l = [daoHist, entry];
                                    _navigationService.navigateTo('/Actividad', arguments: l);
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








