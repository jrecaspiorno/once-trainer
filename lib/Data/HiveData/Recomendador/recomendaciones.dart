import 'package:hive/hive.dart';

part 'recomendaciones.g.dart';

@HiveType(typeId: 0)
class Recomendacione extends HiveObject {
  @HiveField(0)
  final Map<String, dynamic> id;
  @HiveField(1)
  final String grupo;
  @HiveField(2)
  final DateTime fecha;

  Recomendacione(this.id, this.grupo, this.fecha);
}
