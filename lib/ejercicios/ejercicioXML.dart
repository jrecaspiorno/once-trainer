

import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;






Text imprimeEjer() {



  final ejer1 = 'todos_ejercicios/Ejercicios.xml';
  var file = xml.parse(ejer1);
  var desc = file.findAllElements("description");
  //Text(storeDocument.findAllElements('description').toString());
  return Text(desc.toString());
  //print(storeDocument.toString());
  //print(storeDocument.toXmlString(pretty: true, indent: '\t'));
}
/*

  final ejer1
 */