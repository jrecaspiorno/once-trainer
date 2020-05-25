
import 'package:flutterapp/Data/moor_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class GoogleSingUp extends StatefulWidget {
  GoogleSingUp(this.usuarioDAO);
  UsuarioDAO usuarioDAO;
  @override
  State<StatefulWidget> createState() => _GoogleSingUpState();
}

class _GoogleSingUpState extends State<GoogleSingUp> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);
  GoogleSignInAccount _currentUser;
  DateTime _dateTime;
  String id;
  String email;
  String nombre;
  String URL;
  UsuarioData user;
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
      id = _currentUser.id;
      email = _currentUser.email;
      nombre = _currentUser.displayName;
      URL = _currentUser.photoUrl;

      user = UsuarioData(id: id, nombre: nombre, edad: _dateTime, photoUrl: URL, email: email);

      _insertUser(widget.usuarioDAO, user);


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
          Text(_dateTime == null ? 'Nothing has been picked yet' : _dateTime.toString()),
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



  Future<void> _insertUser(UsuarioDAO usuarioDAO, user) async{
    UsuarioData user1 = await usuarioDAO.getUser(user.id);
    if(user1 == null){
      usuarioDAO.insertUser(user);
    }
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
