import 'package:flutter/material.dart';

// Para los ejercicios en XML
import 'package:xml/xml.dart' as xml;
import 'package:xml/xml_events.dart' as xml_events;

Text imprimeEjer() {
  final ejer1 = 'todos_ejercicios/caminar.xml';
  //xml_events.parseEvents(ejer1);
  final storeDocument = xml.parse(ejer1);
  return Text(storeDocument.findAllElements('description').toString());

  //print(storeDocument.toString());
  //print(storeDocument.toXmlString(pretty: true, indent: '\t'));
}
/*

  final ejer1 = '''<ejercicio1>
    <name>Caminar</name>
    <time>2 min</time>
    <description>
   Camina mirando al frente, no hacia el suelo. Primero apoya el talón y luego los dedos. Mantén los hombros relajados y los brazos balanceándose ligeramente. Termina las series caminando lentamente durante 2 minutos para relajarte.
   *Camina a un ritmo que puedas mantener una conversación de manera continua pero que te cueste un poco de esfuerzo.
   </description>
    <calories>650</calories>
</ejercicio1> ''';
 */