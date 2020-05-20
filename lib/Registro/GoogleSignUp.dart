import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/io_client.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:googleapis/people/v1.dart'
    show ListConnectionsResponse, PeopleApi;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleSingUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GoogleSingUpState();
}

class _GoogleSingUpState extends State<GoogleSingUp> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);
  GoogleSignInAccount _currentUser;
  DateTime _dateTime;
  final _MycontrollerE = TextEditingController();
  final String labelEdad = 'Introduzca su edad';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_currentUser != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: _currentUser,
            ),
            title: Text(_currentUser.displayName ?? ''),
            subtitle: Text(_currentUser.email ?? ''),
          ),
          RaisedButton(
            onPressed: _handleSignOut,
            child: Text('SIGN OUT'),
          )
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          DatePicker(),
          Padding(
            padding: EdgeInsets.all(16.0),
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            ),
            color: Colors.indigo,
            onPressed: _handleSignIn,
            child: Container(
              width: 110,
              child: Row(

                children: <Widget>[
                  FaIcon(FontAwesomeIcons.google),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  Text('Registrarse',
                    style: TextStyle(
                      color: Colors.white,

                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }
  }


  Widget DatePicker(){
    return RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
      ),
      color: Colors.indigo,
      child: Text('Introduzca su feche de nacimento',
          style: TextStyle(
            color: Colors.white,

          ),),
        onPressed: () {
          showDatePicker(
              context: context,
              initialDate: _dateTime == null ? DateTime.now() : _dateTime,
              firstDate: DateTime(1900),
              lastDate: DateTime.now()
          ).then((date) {
            setState(() {
              _dateTime = date;
            });
          });
        },
    );
  }

  Widget CampoEdad(String text) {
    return Container(
      width: 200,
      child: TextFormField(
        controller: _MycontrollerE,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
        decoration:  InputDecoration(
          fillColor: Colors.indigo,
          labelText: text,
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          border:  OutlineInputBorder(

            borderRadius: const BorderRadius.all(
              const Radius.circular(15.0),
            ),
          ),
          filled: true,
        ),
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> _handleSignIn() async {
    try {
      if(_dateTime != null) {
        await _googleSignIn.signIn();
      }
      else{
        showAlertDialog(context);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() async {
    _googleSignIn.disconnect();
  }

  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Ok"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("No ha introducido su edad"),
      content: Text("Introduzca su edad para poder registrarse"),
      actions: [
        cancelButton,

      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
