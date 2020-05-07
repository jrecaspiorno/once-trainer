import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleSingUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GoogleSingUpState();
}

class _GoogleSingUpState extends State<GoogleSingUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.indigo,
      ),
      body: Builder(
          builder: (context) => Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 250,
                        child: Align(
                          alignment: Alignment.center,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            color: Color(0xffffffff),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(FontAwesomeIcons.google, color: Color(0xffCE107C),),
                                SizedBox(width: 10,),
                                Text('Sing in with Google',
                                  style: TextStyle(color: Colors.black, fontSize: 18),
                                ),
                            
                              ],
                            ),
                            onPressed: (){
                              
                            },
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )),
    );
  }
}
