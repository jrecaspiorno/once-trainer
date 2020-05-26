import 'dart:io';

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
  bool _fecha_introducida = false;
  bool _logedIn = false;
  bool _loading = true;
  FirebaseUser _user;
  bool isLoading() => _loading;
  DateTime _date;
  bool isLogedIn() => _logedIn;
  FirebaseUser currentUser() => _user;
  bool getFecha() => _fecha_introducida;
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

  void insertarFecha(DateTime dateTime) async{
    _fecha_introducida = true;
    _date = dateTime;
    notifyListeners();
  }

  void insert(UsuarioData usuario, UsuarioDAO usuarioDAO ) async{
    UsuarioData user1 = await usuarioDAO.getUser(usuario.id);
    if(user1 == null){
      usuarioDAO.insertUser(usuario);
    }
  }

  void login(UsuarioDAO usuarioDAO) async{
    
    _loading = true;
    notifyListeners();

    _user = await _handleSignIn();
    //_date = await _getBDay();
   
    print("Birthday from " + _user.displayName + " " + _date.toString()) ;
    _loading = false;
    if(_user != null) {
      _prefs.setBool('isLoggedIn', true);
       UsuarioData data = UsuarioData(id: _user.providerId, nombre: _user.displayName, edad: _date, photoUrl: _user.photoUrl, email: _user.email);
      insert(data,usuarioDAO);
      _logedIn = true;
      notifyListeners();
    }else{
      _logedIn = false;
      notifyListeners();
    }
  }
  void logout(){
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