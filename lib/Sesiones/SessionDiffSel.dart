import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;
import 'package:flutterapp/Sesiones/Session.dart';

class SesionsSelDiffPage extends StatefulWidget {
  Session session;

  SesionsSelDiffPage({@required this.session});

  @override
  _SesionsSelDiffPageState createState() => _SesionsSelDiffPageState();
}

class _SesionsSelDiffPageState extends State<SesionsSelDiffPage> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Widget con app prediseñada, esquema
        appBar: AppBar(
          leading: BackButton(
            onPressed: _navigationService.goBack,
          ),
          title: Text('Seleción de nivel'),
          backgroundColor: Colors.indigo,
        ),
        extendBodyBehindAppBar: false,
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Text("Seleccione su nivel", style: TextStyle(fontSize: 30),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,20,0,20),
                  child: SizedBox(
                    width: 250,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(15)),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.indigo),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            textStyle:
                                MaterialStateProperty.all<TextStyle>(TextStyle(
                              color: Colors.white,
                            ))),
                        child: Text('Iniciación',
                            style: TextStyle(fontSize: 35)),
                        onPressed: () =>
                            _navigationService.navigateTo(route.SessionMenuPage, arguments: [widget.session, "i"])),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: SizedBox(
                    width: 250,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(15)),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.indigo),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            textStyle:
                                MaterialStateProperty.all<TextStyle>(TextStyle(
                              color: Colors.white,
                            ))),
                        child: Text('Avanzado', style: TextStyle(fontSize: 35)),
                        onPressed: () =>
                            _navigationService.navigateTo(route.SessionMenuPage, arguments: [widget.session, "a"])),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
