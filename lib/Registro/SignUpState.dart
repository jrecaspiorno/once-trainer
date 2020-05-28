//import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:googleapis/people/v1.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class LoginState with ChangeNotifier{
  GoogleSignIn _googleSingIn = GoogleSignIn( );
  SharedPreferences _prefs;
  final _auth = FirebaseAuth.instance;
  bool _ok = true;
  bool _fecha_introducida = false;
  bool _logedIn = false;
  bool _loading = true;
  bool _alertaActivada = false;
  String _id = "";
  FirebaseUser _user;
  bool isLoading() => _loading;
  DateTime _date;
  bool isLogedIn() => _logedIn;
  FirebaseUser currentUser() => _user;
  bool getFecha() => _fecha_introducida;
  bool getNoDateAlert() => _alertaActivada;
  String getId() => _id;
  LoginState() {
    loginState();
  }
  // Future<Date> _getBDay() async{

  //   var client = http.Client();
  //   var header = await _googleSingIn.currentUser.authHeaders;
  //   var authClient = AuthClient(client, header);
  //   var api = PeopleApi(authClient);
  //   return (await api.people.get(PeopleApi.UserBirthdayReadScope)).birthdays.first.date;

  // }
  void setFecahIntroducida() {
    _fecha_introducida = true;
    notifyListeners();
  } 

  void insertarFecha(DateTime dateTime) async{
    _fecha_introducida = true;
    _date = dateTime;
    notifyListeners();
  }

  void insert(UsuarioData usuario, UsuarioDAO usuarioDAO ) async{
    
    UsuarioData user1 = await usuarioDAO.getUser(usuario.id);
    if(user1 == null && _date == null){
      //_fecha_introducida = false;
      _ok = false;
      _alertaActivada = true;
      notifyListeners();
      
    }
    else if (user1 == null ){
      _alertaActivada = false;
      usuarioDAO.insertUser(usuario);
      _ok = true;
    }
    else{
      _alertaActivada = false;
      _ok = true;
    }
    
  }

  void login(UsuarioDAO usuarioDAO) async{
    
    _loading = true;
    notifyListeners();
    
    _user = await _handleSignIn();
    _id = _user.uid;
    //_date = await _getBDay();
    
    print("Birthday from " + _user.displayName + " " + _date.toString()) ;
    _loading = false;
    if(_user != null) {
      _prefs.setBool('isLoggedIn', true);
       UsuarioData data = UsuarioData(id: _id, nombre: _user.displayName, edad: _date, photoUrl: _user.photoUrl, email: _user.email);
      insert(data,usuarioDAO);
      
      await usuarioDAO.getUsers();
      if(_ok )
        _logedIn = true;
      
      notifyListeners();
    }else{
      _logedIn = false;
      notifyListeners();
    }
  }
  void logout(){
    _fecha_introducida = false;
    _prefs.clear();
    _googleSingIn.signOut();
    _logedIn = false;
    notifyListeners();
  }
  Future<FirebaseUser> _handleSignIn() async{
    final GoogleSignInAccount account = await _googleSingIn.signIn();
    final GoogleSignInAuthentication googleAuth = await account.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
    );
    final FirebaseUser user =(await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);

    return user;
  }

  void loginState() async {
    _prefs = await SharedPreferences.getInstance();
    if(_prefs.containsKey('isLoggedIn')){
      _user = await _auth.currentUser();

      _logedIn = _user != null;
      _loading = false;
      notifyListeners();
    }else{
      _loading = false;
      notifyListeners();
    }
  }



}
class AuthClient extends http.BaseClient{
  final http.Client _baseClient;
  final Map<String, String> _headers;

  AuthClient(this._baseClient, this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
  }

}