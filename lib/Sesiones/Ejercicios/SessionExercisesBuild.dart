import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;
import 'package:flutterapp/Sesiones/Transfers/Session.dart';
import 'package:flutterapp/Sesiones/Transfers/SessionsExercise.dart';

import 'package:flutterapp/Sesiones/VideoPlayer.dart';
import 'package:video_player/video_player.dart';

import 'SessionTimer.dart';

class SessionEjBuild extends StatefulWidget {
  SessionEjBuild({
    @required this.ejs,
    @required this.pos,
    @required this.tarea,
    @required this.name,
    @required this.sesid,
  });
  String name;
  int pos;
  List<EjSesion> ejs;
  Tarea tarea;
  int sesid;
  @override
  State<StatefulWidget> createState() => _SessionEjBuildState();
}

class _SessionEjBuildState extends State<SessionEjBuild> {
  final NavigationService _navigationService = locator<NavigationService>();
  VideoPlayerController _controller;
  Future<void> _initVideoPlayer;
  bool pause;
  int sercount;
  int sertot;

  @override
  void initState() {
    sercount = widget.tarea.series;
    sertot = widget.tarea.series;
    pause = false;
    int sid = widget.sesid+1;
    int nej = widget.ejs[widget.pos].id;
    String ssid = "$sid";
    _controller =
        VideoPlayerController.asset('assets/videos/S'+ssid+'/S'+ ssid + 'E'+ '$nej' +'.mp4');
    _initVideoPlayer = _controller.initialize();

    super.initState();
  }

  _resetseries() {
    setState(() {
      sercount = sertot;
    });
  }

  _rmseries() {
    if (sercount > 0) {
      sercount--;
    }
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

  void _end() {
    widget.ejs[widget.pos].setmarcado(true);
    _navigationService.goBack();
    _navigationService.replaceView(route.ListEjsSessionPage, arguments: [widget.ejs, widget.tarea, widget.name, widget.sesid]);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: showEj(widget.ejs, context),
      ),
    );
  }

  List<Widget> myWidgets(List<EjSesion> ej) {
    List<Widget> w = [];
    w.add(
      Padding(
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
      ),
    );
    w.add(
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
        child: Center(
            child: Text(
          widget.tarea.series.toString() +
              " Serie y " +
              widget.tarea.descanso.substring(3) +
              " segundos de descanso",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        )),
      ),
    );
    w.add(
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Container(
            child: AppSTimer(
          time: widget.tarea.trabajo,
        )),
      ),
    );
    w.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Series", style: TextStyle(fontSize: 40.0)),
      ),
    );
    w.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton(
              style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.indigo),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                    color: Colors.white,
                  ))),
              onPressed: _resetseries,
              child: Icon(
                Icons.refresh,
                color: Colors.white,
                semanticLabel: "Resetear series",
              )),
          Text('$sercount',
              semanticsLabel: '$sercount series',
              style: TextStyle(fontSize: 60.0)),
          ElevatedButton(
              style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.indigo),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                    color: Colors.white,
                  ))),
              onPressed: _rmseries,
              child: Icon(
                Icons.remove_circle,
                color: Colors.white,
                semanticLabel: "serie realizada",
              )),
        ],
      ),
    );
    w.add(
      Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 10, 5),
          child: Text(ej[widget.pos].description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 27,

              ))),
    );

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

  Widget showEj(List<EjSesion> ej, BuildContext context) {
    List<Widget> w = myWidgets(ej);

    return FutureBuilder(
        future: _initVideoPlayer,
        builder: (context, snapshot) {
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
        });
  }
}
