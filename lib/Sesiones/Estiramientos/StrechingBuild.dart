import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/Sesiones/Transfers/Estiramiento.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;
import 'package:video_player/video_player.dart';

class EstiramientosBuild extends StatefulWidget {
  int sesid;
  int pos;
  List<EjEstiramiento> ejs;

  @override
  _EstiramientosBuildState createState() => _EstiramientosBuildState();

  EstiramientosBuild({@required this.pos, @required this.ejs, @required this.sesid});
}

class _EstiramientosBuildState extends State<EstiramientosBuild> {
  final NavigationService _navigationService = locator<NavigationService>();
  VideoPlayerController _controller;
  Future<void> _initVideoPlayer;
  bool pause;

  void initState() {

    pause = false;
    int sid = widget.sesid+1;
    int nej = widget.ejs[widget.pos].id;
    String ssid = "$sid";
    _controller =
        VideoPlayerController.asset('assets/videos/Estiramientos/E'+ssid+'/P'+ ssid + 'E'+ '$nej' +'.mp4');
    _initVideoPlayer = _controller.initialize();

    super.initState();
  }
  _end() {
    widget.ejs[widget.pos].setmarcado(true);
    _navigationService.goBack();
    _navigationService.replaceView(route.EstiramientosListPage,
        arguments: [widget.ejs, widget.sesid]);
  }
  _play() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        pause = false;
      } else {
        _controller.play();
        pause = true;
      }
    });
  }

  _reset() {
    setState(() {
      _controller.initialize();

      _controller.pause();
      pause = false;
    });
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

    w.add(
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.indigo),
                    shape:
                    MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    textStyle:
                    MaterialStateProperty.all<TextStyle>(TextStyle(
                      color: Colors.white,
                    ))),
                onPressed: _play,
                child: Icon((!pause) ? Icons.play_arrow : Icons.pause,
                  color: Colors.white, semanticLabel: (!pause) ? "Reproducir video" : "Pausar video",)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.indigo),
                    shape:
                    MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    textStyle:
                    MaterialStateProperty.all<TextStyle>(TextStyle(
                      color: Colors.white,
                    ))),
                onPressed: _reset,
                child: Icon(Icons.stop, color: Colors.white, semanticLabel: "Reiniciar video",)),
          ),
        ),
      ]),
    );
    w.add(
      SizedBox(
          height: 400,
          child: Semantics(
            label: "Video del ejercicio",
            focusable: true,
            child: AspectRatio(
              aspectRatio: 9 / 16,
              child: VideoPlayer(_controller),
            ),
          )),
    );
    return w;
  }
}
