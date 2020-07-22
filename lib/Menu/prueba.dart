import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Data/HiveData/RecomendadorList/RecomList.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class miPruebaConsultas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final daoRec = context.watch<AppDatabase>().recomendadosDAO;

    Box recomListBox;
    var n;
    List<dynamic> l;
    _deleteAll() {
      daoRec.deleteAll();
    }

    Future _insertData() async {
      Recomendado a = Recomendado(
          nombre: 'ab', grupo: 'c', idUser: 'b', fecha: DateTime(1900));
      Recomendado b = Recomendado(
          nombre: 'ac', grupo: 'c', idUser: 'b', fecha: DateTime(1910));
      Recomendado c = Recomendado(
          nombre: 'ad', grupo: 'c', idUser: 'b', fecha: DateTime(1920));
      Recomendado d = Recomendado(
          nombre: 'ae', grupo: 'c', idUser: 'b', fecha: DateTime(1930));
      Recomendado e = Recomendado(
          nombre: 'af', grupo: 'c', idUser: 'b', fecha: DateTime(1940));
      Recomendado f = Recomendado(
          nombre: 'ag', grupo: 'c', idUser: 'b', fecha: DateTime(1950));
      Recomendado g = Recomendado(
          nombre: 'ah', grupo: 'c', idUser: 'b', fecha: DateTime(1960));
      Recomendado h = Recomendado(
          nombre: 'ai', grupo: 'c', idUser: 'b', fecha: DateTime(1970));
      Recomendado i = Recomendado(
          nombre: 'aj', grupo: 'c', idUser: 'b', fecha: DateTime(1980));
      Recomendado j = Recomendado(
          nombre: 'ak', grupo: 'c', idUser: 'b', fecha: DateTime(1990));
      daoRec.insertRecomendado(i);
      daoRec.insertRecomendado(c);
      daoRec.insertRecomendado(b);
      daoRec.insertRecomendado(a);
      daoRec.insertRecomendado(g);
      daoRec.insertRecomendado(e);
      daoRec.insertRecomendado(j);
      daoRec.insertRecomendado(f);
      daoRec.insertRecomendado(d);
      daoRec.insertRecomendado(h);
    }

    _openBox() async {
      recomListBox = await Hive.openBox('recomlists');
    }

    _addData() {
      //Ejercicio ej = Ejercicio('a', 'b', 100, ['a'], 1, 'hola');
      RecomList r = RecomList('hola', ['a', 'b'], 0, 9);
      recomListBox.add(r);
    }

    _deleteData() {
      daoRec.delete5mostRecent('b');
    }

    _showData() {
      return daoRec.getallRecFromUser('b');
    }

    _pickData(String a, String b) {
      return daoRec.getRecbyPrimaryKey(a, b);
    }

    _getAtIndex() {
      l = recomListBox.values.toList();
      n = recomListBox.getAt(0);
      n = recomListBox.getAt(1);
    }

    _changeBox() {
      RecomList r = RecomList(
        'que tal',
        ['e', 'c'],
        0,
        3,
      );

      recomListBox.putAt(1, r);
    }

    _getData() {
      l = recomListBox.values.toList();
    }

//    _deleteAll();
//    _insertData().then((value) async {
//      List<dynamic> l = await _showData();
//      var r = await _pickData('ab', 'b');
//      _deleteData();
//
//      l = await _showData();
//      l.length;
//    });
    _openBox().then((value) {
      _addData();
      _getData();
      _getAtIndex();
      _changeBox();
      _getData();
    });

    return Scaffold();
  }
}
