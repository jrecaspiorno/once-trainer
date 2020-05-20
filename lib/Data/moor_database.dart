import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Usuario extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1)();
  IntColumn get edad => integer()();
  TextColumn get photoUrl => text().withLength(min: 1)();
 TextColumn get email => text().withLength(min: 1)();
}

class Restricciones extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tipo => text().withLength(min: 1, max: 50)();
  IntColumn get idUser =>
      integer().customConstraint('REFERENCES Usuario(id)')();
  BoolColumn get activo => boolean().withDefault(Constant(false))();
}

class Historials extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get dificultad => integer()();
  TextColumn get ejercicio => text().withLength(min: 1, max: 50)();
  DateTimeColumn get fecha => dateTime()();
  IntColumn get calorias => integer()();
  IntColumn get duracion => integer()();
  IntColumn get idUser =>
      integer().customConstraint('REFERENCES Usuario(id)')();
  BoolColumn get activo => boolean().withDefault(Constant(false))();
}

@UseMoor(
    tables: [Usuario, Restricciones, Historials],
  daos: [UsuarioDAO, RestriccionesDAO, HistorialDAO])
  class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
  path: 'OnceTrainerDB.sqlite', logStatements: true));
  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [Usuario])
class UsuarioDAO extends DatabaseAccessor<AppDatabase> with _$UsuarioDAOMixin {
  final AppDatabase db;

  UsuarioDAO(this.db) : super(db);

  Future<List<UsuarioData>> getUsers() => select(usuario).get();
  Future insertUser(Insertable<UsuarioData> user) => into(usuario).insert(user);
  Future updateUser(Insertable<UsuarioData> user) =>
      update(usuario).replace(user);
  Future deleteUser(Insertable<UsuarioData> user) =>
      delete(usuario).delete(user);
}

@UseDao(tables: [Restricciones, Usuario])
class RestriccionesDAO extends DatabaseAccessor<AppDatabase>
    with _$RestriccionesDAOMixin {
  final AppDatabase db;
  RestriccionesDAO(this.db) : super(db);
  Future<List<Restriccione>> resActivas(){
    return (select(restricciones)..where((t) => t.activo.equals(true))).get();
  }
  Stream<List<RestWithUser>> watchRest() {
    return (select(restricciones)
          ..orderBy([
            (t) => OrderingTerm(expression: t.tipo, mode: OrderingMode.desc),
          ]))
        .join([
          leftOuterJoin(usuario, usuario.id.equalsExp(restricciones.idUser)),
        ])
        .watch()
        .map((rows) => rows.map((row) {
              return RestWithUser(
                rest: row.readTable(restricciones),
                user: row.readTable(usuario),
              );
            }).toList());
  }
  Stream<List<Restriccione>> wachAllRest() => select(restricciones).watch();
  Future deleteAllRes()=>delete(restricciones).go();
  Future insertRest(Insertable<Restriccione> res) =>
      into(restricciones).insert(res);
  Future updateRes(Insertable<Restriccione> res) =>
      update(restricciones).replace(res);
  Future<List<Restriccione>> getAllRest() =>select(restricciones).get();

}

@UseDao(tables: [Historials, Usuario])
class HistorialDAO extends DatabaseAccessor<AppDatabase>
    with _$HistorialDAOMixin {
  final AppDatabase db;
  HistorialDAO(this.db) : super(db);
  Future<List<Historial>> getallHist() => select(historials).get();
  Future insertHistorial(Insertable<Historial> hist) => into(historials).insert(hist);
  Stream<List<Historial>> watchallHist()=> select(historials).watch();
  Future deleteHist() => delete(historials).go();
}

class RestWithUser {
  final UsuarioData user;
  final Restriccione rest;

  RestWithUser({
    @required this.user,
    @required this.rest,
  });
}
