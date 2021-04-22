import 'package:flutter/material.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:provider/provider.dart';

class MyHistory extends StatefulWidget {
  @override
  _MyHistoryState createState() => _MyHistoryState();
}

class _MyHistoryState extends State<MyHistory> {
  @override
  Widget build(BuildContext context) {
    final daoHist =
        Provider.of<AppDatabase>(context, listen: false).historialDAO;
    final NavigationService _navigationService = locator<NavigationService>();

    final id = context.watch<LoginState>().getId();

    bool show = true;
    bool notNull(Object o) => o != null;
    SizedBox mySizedBox() {
      if (show) {
        show = false;
        return SizedBox(height: 40);
      } else
        return null;
    }

    return WillPopScope(
      onWillPop: () {
        print(
            'Backbutton pressed (device or appbar button), do whatever you want.');
        _navigationService.goBack();
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: _navigationService.goBack,
            ),
            title: Text('Tu historial'),
            backgroundColor: Colors.deepPurple,
          ),
          extendBodyBehindAppBar: false,
          body: Container(
            child: StreamBuilder(
                stream: daoHist.watchallHistFromUser(id),
                builder: (context, data) {
                  show = true;
                  if (data.hasData) {
                    List<Historial> hist = data.data;
                    return ListView.builder(
                      padding: EdgeInsets.fromLTRB(15, 1, 15, 1),
                      itemCount: hist.length,
                      itemBuilder: (context, index) {
                        Padding(
                          padding: EdgeInsets.only(bottom: 30),
                        );
                        return Flex(
                          direction: Axis.vertical,
                          textDirection: TextDirection.ltr,
                          verticalDirection: VerticalDirection.down,
                          children: [
                            mySizedBox(),

                            SizedBox(
                              width: 270,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                autofocus: true,
                                onPressed: () {
                                  final Historial entry = hist[index];
                                  List<dynamic> l = [daoHist, entry];
                                  _navigationService.navigateTo(
                                      route.ActividadPage,
                                      arguments: l);
                                },
                                color: Colors.deepPurple,
                                textColor: Colors.white,
                                padding: EdgeInsets.all(24.0),
                                child: Text(
                                  hist[index].ejercicio,
                                  style: TextStyle(fontSize: 30),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
                            //const SizedBox(height: 20),
                          ].where(notNull).toList(),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )),
    );
  }
}
