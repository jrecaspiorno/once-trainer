import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;
import 'package:flutterapp/Sesiones/Session.dart';
import 'package:flutterapp/Sesiones/SessionsFactory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart' as xml;
import 'dart:convert';

class SesionsPage extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  SharedPreferences _prefs;
  Future<List<Session>> getSessions(BuildContext context) async {
    _prefs = await SharedPreferences.getInstance();
    final manifestContent =
    await DefaultAssetBundle.of(context).loadString('assets/Sesiones.xml');
    var raw = xml.parse(manifestContent);
    List<Session> ses = [];
    var sesions = raw.findAllElements("sesion");
    sesions.forEach((s) {
      ses.add(FactoriaSesion.GenerateSession(s));
    });
    print(ses);
    return ses;
  }

  bool show = true;

  bool notNull(Object o) => o != null;

  SizedBox mySizedBox() {
    if (show) {
      show = false;
      return SizedBox(height: 40);
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Widget con app prediseñada, esquema
        appBar: AppBar(
          leading: BackButton(
            onPressed: _navigationService.goBack,
          ),
          title: Text('Sesiones'),
          backgroundColor: Colors.indigo,
        ),
        extendBodyBehindAppBar: false,
        body: Container(
          child: FutureBuilder(
            future: getSessions(context),
            builder: (_, data) {
              show = true;
              if (data.hasData) {
                List<Session> sessions = data.data;
                return ListView.builder(
                  padding: EdgeInsets.fromLTRB(15, 1, 15, 1),
                  itemCount: sessions.length,
                  itemBuilder: (context, index) {
                    Padding(
                      padding: EdgeInsets.only(bottom: 30),);
                    return Flex(
                      mainAxisSize: MainAxisSize.min,
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
                            onPressed: () {
                              _navigationService.navigateTo(route.SessionMenuPage,
                                  arguments: [sessions[index], _prefs.getString('nivel')]);



                            },
                            color: Colors.indigo,
                            textColor: Colors.white,
                            padding: EdgeInsets.all(24.0),
                            child: Text(
                              sessions[index].name,
                              style: TextStyle(fontSize: 30),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ].where(notNull).toList(),
                    );

                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        )
    );
  }
}
