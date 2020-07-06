//import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/DriveBackup/Backup.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginState with ChangeNotifier {
  GoogleSignIn _googleSingIn = GoogleSignIn(scopes: ['https://www.googleapis.com/auth/drive'],);
  GoogleSignInAccount _googleAcc;
  SharedPreferences _prefs;
  Map<String, String> header;
  final _auth = FirebaseAuth.instance;
  var  _idToken;
  bool _fecha_introducida = false;
  bool _logedIn = false;
  bool _loading = true;
  bool _correctRestore = false;
  String _id = "";
  FirebaseUser _user;
  bool isLoading() => _loading;
  DateTime _date;
  bool isLogedIn() => _logedIn;
  String getidToken()=> _idToken;
  FirebaseUser currentUser() => _user;
  bool getFecha() => _fecha_introducida;
  String getId() => _id;
  Map<String, String> getHeader() => header;
  LoginState() {
    loginState();
  }

  void setDate(DateTime date) => _date = date;
  void setLogedIn(){
    _logedIn = true;
    _loading = false;
    _fecha_introducida = true;
    _correctRestore = true;
    _prefs.setBool('completeLogin', true);
    notifyListeners();
  }
  void setLogedInNoRestore(){
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
    
    UsuarioData usuario = UsuarioData(
        id: _id,
        nombre: _user.displayName,
        edad: _date,
        photoUrl: _user.photoUrl,
        email: _user.email);
    database.usuarioDAO.insertUser(usuario);
    _prefs.setBool('completeLogin', true);
    
    _logedIn = true;

    notifyListeners();
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
      Backup b = Backup(header: header, id: _id, database:database , state: this);
      
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


