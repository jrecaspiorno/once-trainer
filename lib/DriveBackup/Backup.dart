import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';

import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/DriveBackup/GoogleHttpClient.dart';

import '../Registro/SignUpState.dart';

class Backup {
  Map<String, String> header;
  String id;
  AppDatabase database;
  final String fileName = "OnceTrainerBackup.txt";
  BuildContext context;
  Backup({@required this.header, @required this.id, @required this.database, this.context});

  Future<bool> getDataFronDrive() async {
    var state = Provider.of<LoginState>(context, listen: false);
    final location = await getTemporaryDirectory();
    final loc = p.join(location.path, fileName);
    final client = http.Client();
    //Map<String, dynamic> h = json.decode(header);
    var authClient = GoogleHttpClient(header, client);
    var api = drive.DriveApi(authClient);
    var fileL = await api.files.list(q: "name = '$fileName'");
    var file = fileL.files;
    var ok = file.isNotEmpty;
    if (file.isNotEmpty ) {
      String id = file[0].id;
      drive.Media response = await api.files
          .get(id, downloadOptions: drive.DownloadOptions.FullMedia);

      List<int> dataStore = [];
      state.setLoading();
      response.stream.asBroadcastStream().listen((data) {
        print("Data Recived: ${data.length}");
        dataStore.insertAll(dataStore.length, data);
      }, onDone: () async {
        File file = File(loc);
        print(loc);
        file.writeAsBytes(dataStore);
        String content = await file.readAsString();
        print(content);
        var data = json.decode(content);
        UsuarioData u = UsuarioData.fromJson(data["1"]);
        List<dynamic> aux = data["2"];
        List<Restriccione> rs = [];
        if(aux != null)
          aux.forEach((element) {
            Restriccione r = Restriccione.fromJson(element);
            rs.add(r);
          });
        
        List<Historial> hist = [];
        aux = data["3"];
        if(aux != null)
          aux.forEach((element) {Historial h = Historial.fromJson(element); hist.add(h);});
        await database.usuarioDAO.insertUser(u);
        if (rs.isNotEmpty) await database.restriccionesDAO.insertAllRes(rs);
        if (hist.isNotEmpty) await database.historialDAO.insertAllHist(hist);
        state.setLogedIn();
        state.setExit();
        return true;
      });
      print(response.toString());
      
    }
    
    state.setExit();
    return false;
  }

  Future<bool> uploadDataToDrive() async {
    final location = await getApplicationDocumentsDirectory();
    final dbFolder = await getDatabasesPath();
    final dbLocation = p.join(dbFolder, 'OnceTrainerDB.sqlite');
    File file = File(dbLocation);

    final client = http.Client();
    var authClient = GoogleHttpClient(header, client);
    var api = drive.DriveApi(authClient);

    UsuarioData user = await database.usuarioDAO.getUser(id);
    List<Restriccione> rests =
        await database.restriccionesDAO.getRestfromUser(id);
    List<Historial> hist = await database.historialDAO.getHistfromUser(id);

    DatabasetoJson data = DatabasetoJson(user: user, rests: rests, hist: hist);
    final loc = p.join(location.path, fileName);
    File jsonFile = File(loc);
    var da = data.jsonfromdatabase();
    var s = json.encode(da);
   
    jsonFile.createSync();
    jsonFile.writeAsStringSync(s);
    var fileL = await api.files.list(q: "name = '$fileName'");
    var files = fileL.files;
    var response;
    if (user.backupid == null && files.isEmpty) {
      response = await api.files.create(
        drive.File()..name = fileName,
        uploadMedia: drive.Media(jsonFile.openRead(), jsonFile.lengthSync()),
      );
      database.usuarioDAO.insertBackIdIntoUser(response.id, id);
    } else {
      var id = user.backupid == null ? files[0].id : user.backupid;
        response = await api.files.update(
        drive.File()..name = fileName,
        id,
        uploadMedia: drive.Media(jsonFile.openRead(), jsonFile.lengthSync()),
      );
      
      print(response.toJson());
    }
    if(response != null ) return true;
    else return false;
  }
}

class DatabasetoJson {
  UsuarioData user;
  List<Restriccione> rests;
  List<Historial> hist;
  DatabasetoJson({
    @required this.user,
    @required this.rests,
    @required this.hist,
  });

  Map<String, dynamic> jsonfromdatabase() {
    Map<String, dynamic> userm = {"1": user.toJson()};

    List<dynamic> restm = List();
    List<dynamic> histl = List();
    Map<String, dynamic> mast = Map();
    mast.addAll(userm);
    
    if (rests.length != 0) {
      rests.forEach((element) => restm.add(element.toJson()));
      Map<String, dynamic> restmd = {"2": restm};

      mast.addAll(restmd);
    }
    if (hist.length != 0) {
      hist.forEach((element) => histl.add(element.toJson()));
      Map<String, dynamic> histsm = {"3": histl};
      mast.addAll(histsm);
    }

    return mast;
  }
}
