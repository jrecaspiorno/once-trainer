import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:googleapis/people/v1.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
class LoginState with ChangeNotifier{
   GoogleSignIn _googleSingIn = GoogleSignIn( );
  final _auth = FirebaseAuth.instance;
  bool _fecha_introducida = false;
  bool _logedIn = false;
  bool _loading = false;
  FirebaseUser _user;
  bool isLoading() => _loading;
  DateTime _date;
  bool isLogedIn() => _logedIn;
  FirebaseUser currentUser() => _user;
  bool getFecha() => _fecha_introducida;

  Future<Date> _getBDay() async{

    var client = http.Client();
    var header = await _googleSingIn.currentUser.authHeaders;
    var authClient = AuthClient(client, header);
    var api = PeopleApi(authClient);
    return (await api.people.get(PeopleApi.UserBirthdayReadScope)).birthdays.first.date;

  }

  void insertarFecha(DateTime dateTime) async{
    _fecha_introducida = true;
    _date = dateTime;
    notifyListeners();
  }


  void login() async{

    _loading = true;
    notifyListeners();
    _user = await _handleSignIn();
    //_date = await _getBDay();
    print("Birthday from " + _user.displayName + " " + _date.toString()) ;
    _loading = false;
    if(_user != null) {
      _logedIn = true;
      notifyListeners();
    }else{
      _logedIn = false;
      notifyListeners();
    }
  }
  void logout(){
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