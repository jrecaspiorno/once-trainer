import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyVplayer extends StatefulWidget {
  final VideoPlayerController videocontroller;

  @override
  State<StatefulWidget> createState() => _MyVplayerState();

  MyVplayer({Key key, @required this.videocontroller}) : super(key: key);
}

class _MyVplayerState extends State<MyVplayer> {
  ChewieController _chewieController;
  Future<void> _initVideoPlayer;
  bool pause;

  @override
  void initState() {
    pause = false;
    _initVideoPlayer = widget.videocontroller.initialize();
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videocontroller,
      showControls: true,
      aspectRatio: 9 / 16,
      allowFullScreen: false,
    );
  }

  @override
  void dispose() {
    _chewieController.dispose();

    super.dispose();
  }

  _play() {
    setState(() {
      if (widget.videocontroller.value.isPlaying) {
        widget.videocontroller.pause();
        pause = false;
      } else {
        widget.videocontroller.play();
        pause = true;
      }
    });
  }

  _reset() {
    setState(() {
      widget.videocontroller.initialize();

      widget.videocontroller.pause();
      pause = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Semantics(
                  label: (!pause) ? "Reproducir video" : "Para video",
                  excludeSemantics: true,
                  button: true,
                  child: Center(
                    child:ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(15)),
                            backgroundColor: MaterialStateProperty.all<Color>(
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
                        onPressed: _play,
                        child: Icon((!pause) ? Icons.play_arrow : Icons.pause,
                            color: Colors.white)),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Semantics(
                  label: "Reiniciar video",
                  excludeSemantics: true,
                  button: true,
                  child: Center(
                    child:ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(15)),
                            backgroundColor: MaterialStateProperty.all<Color>(
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

                        onPressed: _play,
                        child: Icon( Icons.stop,
                            color: Colors.white)),
                  )),
            ),
          ],
        ),
        SizedBox(
          height: 400,
          child: FutureBuilder(
            future: _initVideoPlayer,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Semantics(
                  label: "Video del ejercicio",
                  child: AspectRatio(
                    aspectRatio: 9 / 16,
                    child: VideoPlayer(widget.videocontroller),
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ]),
    );
  }
}
