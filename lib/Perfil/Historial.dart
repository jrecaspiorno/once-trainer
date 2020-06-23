import 'package:flutter/material.dart';

class HistorialView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Historial"),
        leading: BackButton(onPressed: () {
          Navigator.pop(context);
        }),
      ),
    );
  }
}
