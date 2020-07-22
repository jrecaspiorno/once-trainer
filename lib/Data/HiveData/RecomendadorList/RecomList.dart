import 'package:hive/hive.dart';

part 'RecomList.g.dart';

@HiveType(typeId: 1)
class RecomList extends HiveObject {
  @HiveField(1)
  final String tipo;
  @HiveField(0)
  final List<String> ejercicios;
  @HiveField(3)
  final int hechosLista;
  @HiveField(4)
  final int hechosTotales;

  RecomList(this.tipo, this.ejercicios, this.hechosLista, this.hechosTotales);
}
