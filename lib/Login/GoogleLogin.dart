import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLogin extends StatefulWidget{
  GoogleLogin(this.usuarioDAO);
  UsuarioDAO usuarioDAO;
  State<StatefulWidget> createState() => _GoogleLogin();
}
class _GoogleLogin extends State<GoogleLogin>{

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);

  //class _GoogleSingUpState extends State<GoogleSingUp> {
  //GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email', "https://www.googleapis.com/auth/user.birthday.read"]);
  GoogleSignInAccount _currentUser;



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

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
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
                    Text('Login',
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
  Future<void> _handleSignIn() async {
    try {
      if(true) {
        await _googleSignIn.signIn();
      }
      else{
        showAlertDialog(context);
      }
    } catch (error) {
      print(error);
    }
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

