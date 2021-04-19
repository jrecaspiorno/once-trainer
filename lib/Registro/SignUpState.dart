//import 'dart:io';

import 'dart:convert';

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/DriveBackup/Backup.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/serviceconsumermanagement/v1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginState with ChangeNotifier {
  GoogleSignIn _googleSingIn = GoogleSignIn(
    scopes: ['https://www.googleapis.com/auth/drive'],
  );
  GoogleSignInAccount _googleAcc;
  SharedPreferences _prefs;
  Map<String, String> header;
  final _auth = FirebaseAuth.instance;
  var _idToken;
  bool _fecha_introducida = false;
  bool _logedIn = false;
  bool _loading = true;
  bool _correctRestore = false;
  String _id = "";
  User _user;
  bool isLoading() => _loading;
  DateTime _date;
  bool isLogedIn() => _logedIn;
  String getidToken() => _idToken;
  User currentUser() => _user;
  bool getFecha() => _fecha_introducida;
  String getId() => _id;
  Map<String, String> getHeader() => header;
  LoginState() {
    loginState();
  }

  void setDate(DateTime date) => _date = date;
  void setLogedIn() {
    _logedIn = true;
    _loading = false;
    _fecha_introducida = false;
    _correctRestore = true;
    _prefs.setBool('completeLogin', true);
    notifyListeners();
  }

  void setLogedInNoRestore() {
    _logedIn = false;
    _loading = false;
    _fecha_introducida = true;
    _prefs.setBool('completeLogin', false);
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
        photoUrl: _user.photoURL != null ? _user.photoURL : "images/avatar.jpg",
        email: _user.email);
    database.usuarioDAO.insertUser(usuario);
    _prefs.setBool('completeLogin', true);
    if(_prefs.getString('logType') == 'apple'){
      _prefs.setString('appleUser', _user.uid);
    }
    _logedIn = true;

    notifyListeners();
  }

  void loginApple(AppDatabase database, BuildContext context) async {
    _prefs.setBool('completeLogin', false);
    _prefs.setString('logType', 'apple');
    _loading = true;
    notifyListeners();
    try {
      _user = await _signInWithApple();

      _id = _user.uid;
      //_date = await _getBDay();
      _prefs.setString('appleUser', _user.uid);
      print("Birthday from " + _user.displayName + " " + _date.toString());
      _loading = false;
      if (_user != null) {
        _prefs.setBool('isLoggedIn', true);
        Backup b =
            Backup(header: header, id: _id, database: database, state: this);

        var z = await database.usuarioDAO.getUser(_id);

        if (z == null) {
          try {
            //await b.getDataFronDrive();

            _fecha_introducida = true;
            notifyListeners();
          } catch (e) {
            _fecha_introducida = false;
            notifyListeners();
          }
        } else {
          _prefs.setBool('completeLogin', true);
          _fecha_introducida = false;
          _logedIn = true;
        }

        notifyListeners();
      } else {
        _logedIn = false;
        notifyListeners();
      }
    } catch (e) {
      _loading = false;
      notifyListeners();
      throw (e);
      //login(database, context);
      //print(e);
    }
  }

  void login(AppDatabase database, BuildContext context) async {
    _prefs.setBool('completeLogin', false);
    _prefs.setString('logType', 'google');
    _loading = true;
    notifyListeners();
    try {
      _user = await _loginGoogle();

      _id = _user.uid;
      //_date = await _getBDay();

      //print("Birthday from " + _user.displayName + " " + _date.toString());
      _loading = false;
      if (_user != null) {
        _prefs.setBool('isLoggedIn', true);
        Backup b =
            Backup(header: header, id: _id, database: database, state: this);

        var z = await database.usuarioDAO.getUser(_id);

        if (z == null) {
          try {
            await b.getDataFronDrive();
            _fecha_introducida = true;
            notifyListeners();
          } catch (e) {
            _fecha_introducida = false;
            notifyListeners();
          }
        } else {
          _prefs.setBool('completeLogin', true);
          _fecha_introducida = false;
          _logedIn = true;
        }

        notifyListeners();
      } else {
        _logedIn = false;
        notifyListeners();
      }
    } catch (e) {
      _loading = false;
      notifyListeners();
      throw (e);
      //login(database, context);
      //print(e);
    }
  }

  void logout() {
    _fecha_introducida = false;
    _prefs.clear();

    _googleSingIn.signOut();
    _logedIn = false;
    notifyListeners();
  }

  Future<User> _signInWithApple({List<Scope> scopes = const []}) async {
    // 1. perform the sign-in request

    final _appleSignIn = await AppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);
    // 2. check the result
    switch (_appleSignIn.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = _appleSignIn.credential;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode),
        );

        final authResult = await _auth.signInWithCredential(credential);
        saveAuth(credential);

        final firebaseUser = authResult.user;
        if (scopes.contains(Scope.fullName)) {
          final displayName =
              '${appleIdCredential.fullName.givenName} ${appleIdCredential.fullName.familyName}';
          await firebaseUser.updateProfile(displayName: displayName);
        }
        return firebaseUser;
      case AuthorizationStatus.error:
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: _appleSignIn.error.toString(),
        );

      case AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      default:
        throw UnimplementedError();
    }
  }

  Future<User> _loginGoogle() async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSingIn.signIn();
    return _handleSignIn(googleSignInAccount);
  }

  Future<User> _handleSignIn(GoogleSignInAccount account) async {
    //account = await _googleSingIn.signIn();

    //var hs = await account.authHeaders;
    //var h = hs.values.first;
    //_prefs.setString('Header', h);
    final GoogleSignInAuthentication googleAuth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    final User user = (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    header = await account.authHeaders;

    return user;
  }
  void saveAuth( OAuthCredential userCredential) {
    print(userCredential);
  }
  void loginState() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey('isLoggedIn') && _prefs.getBool('completeLogin')) {
      if (_prefs.getString('logType') == 'google') {
        await _googleSingIn.signInSilently();
        _googleAcc = _googleSingIn.currentUser;

        if (_googleAcc != null) header = await _googleAcc.authHeaders;

        _user = _auth.currentUser;
        _logedIn = _user != null;
        _id = _user.uid;
        _loading = false;
        notifyListeners();
      }
      else{

        _logedIn = true;
        _id = _prefs.getString('appleUser');
        _loading = false;
        notifyListeners();
      }
    } else {
      _loading = false;
      _googleSingIn.signOut();
      notifyListeners();
    }
  }
}
