//import 'dart:io';

import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/DriveBackup/Backup.dart';
import 'package:googleapis/people/v1.dart';
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginState with ChangeNotifier {
  GoogleSignIn _googleSingIn = GoogleSignIn(scopes: ['https://www.googleapis.com/auth/drive'],);
  GoogleSignInAccount _googleAcc;
  SharedPreferences _prefs;
  Map<String, String> header;
  final _auth = FirebaseAuth.instance;
  var  _idToken;
  bool _exit = false;
  bool _fecha_introducida = false;
  bool _logedIn = false;
  bool _loading = true;
  bool _alertaActivada = false;
  String _id = "";
  FirebaseUser _user;
  bool isLoading() => _loading;
  DateTime _date;
  bool isLogedIn() => _logedIn;
  String getidToken()=> _idToken;
  FirebaseUser currentUser() => _user;
  bool getFecha() => _fecha_introducida;
  bool getNoDateAlert() => _alertaActivada;
  String getId() => _id;
  Map<String, String> getHeader() => header;
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
  void setDate(DateTime date) => _date = date;
  void setLogedIn(){
    _logedIn = true;
    _loading = false;
    _fecha_introducida = true;
    _prefs.setBool('completeLogin', true);
    notifyListeners();
  }
  DateTime getFNacimiento() => _date;
  void setFecahIntroducida() {
    _fecha_introducida = true;
    notifyListeners();
  }
  void setExit(){
    _exit = true;
  }
  void setLoading() { 
    _loading = true;
    notifyListeners();
  }
  void insertarFecha(DateTime dateTime) async {
    _fecha_introducida = true;
    _date = dateTime;
    notifyListeners();
  }

  void insert(AppDatabase database) async {
    UsuarioData user1 = await database.usuarioDAO.getUser(_id);
    //Backup b = Backup(header: header, id: _id, database: database);
    UsuarioData usuario = UsuarioData(
        id: _id,
        nombre: _user.displayName,
        edad: _date,
        photoUrl: _user.photoUrl,
        email: _user.email);
    _alertaActivada = false;
    database.usuarioDAO.insertUser(usuario);
    _prefs.setBool('completeLogin', true);
    //await b.uploadDataToDrive();
    _logedIn = true;

    notifyListeners();
  }

  void waitUntilFile(){
    while(!_exit);
  }

  void login(AppDatabase database, BuildContext context) async {
    _prefs.setBool('completeLogin', false);
    _loading = true;
    notifyListeners();

    _user = await _loginGoogle();
    
    _id = _user.uid;
    //_date = await _getBDay();

    print("Birthday from " + _user.displayName + " " + _date.toString());
    _loading = false;
    if (_user != null) {
      
      _prefs.setBool('isLoggedIn', true);
      Backup b = Backup(header: header, id: _id, database:database , context: context);
      
      var z = await database.usuarioDAO.getUser(_id);
      
      
      
      if ( z == null){
         
        await b.getDataFronDrive();
        _fecha_introducida = true;
      }
      else {
         _prefs.setBool('completeLogin', true);
        _fecha_introducida = false;
        _logedIn = true;
      }

      notifyListeners();
    } else {
     
      _logedIn = false;
      notifyListeners();
    }
  }

  void logout() {
    _fecha_introducida = false;
    _prefs.clear();

    _googleSingIn.signOut();
    _logedIn = false;
    notifyListeners();
  }


  Future<FirebaseUser> _loginGoogle() async{
     
   final GoogleSignInAccount googleSignInAccount =  
         await _googleSingIn.signIn();  
     return _handleSignIn(googleSignInAccount);  
  }
  Future<FirebaseUser> _handleSignIn(GoogleSignInAccount account) async {
    //account = await _googleSingIn.signIn();
    
    var hs = await account.authHeaders;
    //var h = hs.values.first;
    //_prefs.setString('Header', h);
    final GoogleSignInAuthentication googleAuth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    header = await account.authHeaders;
    

    return user;
  }

  void loginState() async {
    
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey('isLoggedIn') && _prefs.getBool('completeLogin')) {
       //header = _prefs.getString('Header');
      
      await _googleSingIn.signInSilently().whenComplete(() => () {}); 
      _googleAcc =  _googleSingIn.currentUser;
      header = await _googleAcc.authHeaders;
      
      _user = await _auth.currentUser();
      
      //header = await _googleSingIn.currentUser.authHeaders;
      
      _logedIn = _user != null;
      _id = _user.uid;
      _loading = false;
      notifyListeners();
    } else {
      _loading = false;
      _googleSingIn.signOut();
      notifyListeners();
    }
  }
  
}

// class AuthClient extends http.BaseClient {
//   final http.Client _baseClient;
//   final Map<String, String> _headers;

//   AuthClient(this._baseClient, this._headers);

//   @override
//   Future<http.StreamedResponse> send(http.BaseRequest request) {
//     request.headers.addAll(_headers);
//   }
// }
