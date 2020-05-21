// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class UsuarioData extends DataClass implements Insertable<UsuarioData> {
  final int id;
  final String nombre;
  final int edad;
  final String photoUrl;
  final String email;
  UsuarioData(
      {@required this.id,
      @required this.nombre,
      @required this.edad,
      @required this.photoUrl,
      @required this.email});
  factory UsuarioData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return UsuarioData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      nombre:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}nombre']),
      edad: intType.mapFromDatabaseResponse(data['${effectivePrefix}edad']),
      photoUrl: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}photo_url']),
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
    );
  }
  factory UsuarioData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return UsuarioData(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      edad: serializer.fromJson<int>(json['edad']),
      photoUrl: serializer.fromJson<String>(json['photoUrl']),
      email: serializer.fromJson<String>(json['email']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'edad': serializer.toJson<int>(edad),
      'photoUrl': serializer.toJson<String>(photoUrl),
      'email': serializer.toJson<String>(email),
    };
  }

  @override
  UsuarioCompanion createCompanion(bool nullToAbsent) {
    return UsuarioCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      nombre:
          nombre == null && nullToAbsent ? const Value.absent() : Value(nombre),
      edad: edad == null && nullToAbsent ? const Value.absent() : Value(edad),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
    );
  }

  UsuarioData copyWith(
          {int id, String nombre, int edad, String photoUrl, String email}) =>
      UsuarioData(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        edad: edad ?? this.edad,
        photoUrl: photoUrl ?? this.photoUrl,
        email: email ?? this.email,
      );
  @override
  String toString() {
    return (StringBuffer('UsuarioData(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('edad: $edad, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(nombre.hashCode,
          $mrjc(edad.hashCode, $mrjc(photoUrl.hashCode, email.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is UsuarioData &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.edad == this.edad &&
          other.photoUrl == this.photoUrl &&
          other.email == this.email);
}

class UsuarioCompanion extends UpdateCompanion<UsuarioData> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<int> edad;
  final Value<String> photoUrl;
  final Value<String> email;
  const UsuarioCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.edad = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.email = const Value.absent(),
  });
  UsuarioCompanion.insert({
    this.id = const Value.absent(),
    @required String nombre,
    @required int edad,
    @required String photoUrl,
    @required String email,
  })  : nombre = Value(nombre),
        edad = Value(edad),
        photoUrl = Value(photoUrl),
        email = Value(email);
  UsuarioCompanion copyWith(
      {Value<int> id,
      Value<String> nombre,
      Value<int> edad,
      Value<String> photoUrl,
      Value<String> email}) {
    return UsuarioCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      edad: edad ?? this.edad,
      photoUrl: photoUrl ?? this.photoUrl,
      email: email ?? this.email,
    );
  }
}

class $UsuarioTable extends Usuario with TableInfo<$UsuarioTable, UsuarioData> {
  final GeneratedDatabase _db;
  final String _alias;
  $UsuarioTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  GeneratedTextColumn _nombre;
  @override
  GeneratedTextColumn get nombre => _nombre ??= _constructNombre();
  GeneratedTextColumn _constructNombre() {
    return GeneratedTextColumn('nombre', $tableName, false, minTextLength: 1);
  }

  final VerificationMeta _edadMeta = const VerificationMeta('edad');
  GeneratedIntColumn _edad;
  @override
  GeneratedIntColumn get edad => _edad ??= _constructEdad();
  GeneratedIntColumn _constructEdad() {
    return GeneratedIntColumn(
      'edad',
      $tableName,
      false,
    );
  }

  final VerificationMeta _photoUrlMeta = const VerificationMeta('photoUrl');
  GeneratedTextColumn _photoUrl;
  @override
  GeneratedTextColumn get photoUrl => _photoUrl ??= _constructPhotoUrl();
  GeneratedTextColumn _constructPhotoUrl() {
    return GeneratedTextColumn('photo_url', $tableName, false,
        minTextLength: 1);
  }

  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedTextColumn _email;
  @override
  GeneratedTextColumn get email => _email ??= _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn('email', $tableName, false, minTextLength: 1);
  }

  @override
  List<GeneratedColumn> get $columns => [id, nombre, edad, photoUrl, email];
  @override
  $UsuarioTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'usuario';
  @override
  final String actualTableName = 'usuario';
  @override
  VerificationContext validateIntegrity(UsuarioCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.nombre.present) {
      context.handle(
          _nombreMeta, nombre.isAcceptableValue(d.nombre.value, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (d.edad.present) {
      context.handle(
          _edadMeta, edad.isAcceptableValue(d.edad.value, _edadMeta));
    } else if (isInserting) {
      context.missing(_edadMeta);
    }
    if (d.photoUrl.present) {
      context.handle(_photoUrlMeta,
          photoUrl.isAcceptableValue(d.photoUrl.value, _photoUrlMeta));
    } else if (isInserting) {
      context.missing(_photoUrlMeta);
    }
    if (d.email.present) {
      context.handle(
          _emailMeta, email.isAcceptableValue(d.email.value, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsuarioData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return UsuarioData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(UsuarioCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.nombre.present) {
      map['nombre'] = Variable<String, StringType>(d.nombre.value);
    }
    if (d.edad.present) {
      map['edad'] = Variable<int, IntType>(d.edad.value);
    }
    if (d.photoUrl.present) {
      map['photo_url'] = Variable<String, StringType>(d.photoUrl.value);
    }
    if (d.email.present) {
      map['email'] = Variable<String, StringType>(d.email.value);
    }
    return map;
  }

  @override
  $UsuarioTable createAlias(String alias) {
    return $UsuarioTable(_db, alias);
  }
}

class Restriccione extends DataClass implements Insertable<Restriccione> {
  final int id;
  final String tipo;
  final int idUser;
  final bool activo;
  Restriccione(
      {@required this.id,
      @required this.tipo,
      @required this.idUser,
      @required this.activo});
  factory Restriccione.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Restriccione(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      tipo: stringType.mapFromDatabaseResponse(data['${effectivePrefix}tipo']),
      idUser:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_user']),
      activo:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}activo']),
    );
  }
  factory Restriccione.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Restriccione(
      id: serializer.fromJson<int>(json['id']),
      tipo: serializer.fromJson<String>(json['tipo']),
      idUser: serializer.fromJson<int>(json['idUser']),
      activo: serializer.fromJson<bool>(json['activo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tipo': serializer.toJson<String>(tipo),
      'idUser': serializer.toJson<int>(idUser),
      'activo': serializer.toJson<bool>(activo),
    };
  }

  @override
  RestriccionesCompanion createCompanion(bool nullToAbsent) {
    return RestriccionesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      tipo: tipo == null && nullToAbsent ? const Value.absent() : Value(tipo),
      idUser:
          idUser == null && nullToAbsent ? const Value.absent() : Value(idUser),
      activo:
          activo == null && nullToAbsent ? const Value.absent() : Value(activo),
    );
  }

  Restriccione copyWith({int id, String tipo, int idUser, bool activo}) =>
      Restriccione(
        id: id ?? this.id,
        tipo: tipo ?? this.tipo,
        idUser: idUser ?? this.idUser,
        activo: activo ?? this.activo,
      );
  @override
  String toString() {
    return (StringBuffer('Restriccione(')
          ..write('id: $id, ')
          ..write('tipo: $tipo, ')
          ..write('idUser: $idUser, ')
          ..write('activo: $activo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(tipo.hashCode, $mrjc(idUser.hashCode, activo.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Restriccione &&
          other.id == this.id &&
          other.tipo == this.tipo &&
          other.idUser == this.idUser &&
          other.activo == this.activo);
}

class RestriccionesCompanion extends UpdateCompanion<Restriccione> {
  final Value<int> id;
  final Value<String> tipo;
  final Value<int> idUser;
  final Value<bool> activo;
  const RestriccionesCompanion({
    this.id = const Value.absent(),
    this.tipo = const Value.absent(),
    this.idUser = const Value.absent(),
    this.activo = const Value.absent(),
  });
  RestriccionesCompanion.insert({
    this.id = const Value.absent(),
    @required String tipo,
    @required int idUser,
    this.activo = const Value.absent(),
  })  : tipo = Value(tipo),
        idUser = Value(idUser);
  RestriccionesCompanion copyWith(
      {Value<int> id,
      Value<String> tipo,
      Value<int> idUser,
      Value<bool> activo}) {
    return RestriccionesCompanion(
      id: id ?? this.id,
      tipo: tipo ?? this.tipo,
      idUser: idUser ?? this.idUser,
      activo: activo ?? this.activo,
    );
  }
}

class $RestriccionesTable extends Restricciones
    with TableInfo<$RestriccionesTable, Restriccione> {
  final GeneratedDatabase _db;
  final String _alias;
  $RestriccionesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  GeneratedTextColumn _tipo;
  @override
  GeneratedTextColumn get tipo => _tipo ??= _constructTipo();
  GeneratedTextColumn _constructTipo() {
    return GeneratedTextColumn('tipo', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _idUserMeta = const VerificationMeta('idUser');
  GeneratedIntColumn _idUser;
  @override
  GeneratedIntColumn get idUser => _idUser ??= _constructIdUser();
  GeneratedIntColumn _constructIdUser() {
    return GeneratedIntColumn('id_user', $tableName, false,
        $customConstraints: 'REFERENCES Usuario(id)');
  }

  final VerificationMeta _activoMeta = const VerificationMeta('activo');
  GeneratedBoolColumn _activo;
  @override
  GeneratedBoolColumn get activo => _activo ??= _constructActivo();
  GeneratedBoolColumn _constructActivo() {
    return GeneratedBoolColumn('activo', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [id, tipo, idUser, activo];
  @override
  $RestriccionesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'restricciones';
  @override
  final String actualTableName = 'restricciones';
  @override
  VerificationContext validateIntegrity(RestriccionesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.tipo.present) {
      context.handle(
          _tipoMeta, tipo.isAcceptableValue(d.tipo.value, _tipoMeta));
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (d.idUser.present) {
      context.handle(
          _idUserMeta, idUser.isAcceptableValue(d.idUser.value, _idUserMeta));
    } else if (isInserting) {
      context.missing(_idUserMeta);
    }
    if (d.activo.present) {
      context.handle(
          _activoMeta, activo.isAcceptableValue(d.activo.value, _activoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Restriccione map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Restriccione.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(RestriccionesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.tipo.present) {
      map['tipo'] = Variable<String, StringType>(d.tipo.value);
    }
    if (d.idUser.present) {
      map['id_user'] = Variable<int, IntType>(d.idUser.value);
    }
    if (d.activo.present) {
      map['activo'] = Variable<bool, BoolType>(d.activo.value);
    }
    return map;
  }

  @override
  $RestriccionesTable createAlias(String alias) {
    return $RestriccionesTable(_db, alias);
  }
}

class Historial extends DataClass implements Insertable<Historial> {
  final int id;
  final int dificultad;
  final String ejercicio;
  final DateTime fecha;
  final int calorias;
  final int duracion;
  final int idUser;
  final bool activo;
  Historial(
      {@required this.id,
      @required this.dificultad,
      @required this.ejercicio,
      @required this.fecha,
      @required this.calorias,
      @required this.duracion,
      @required this.idUser,
      @required this.activo});
  factory Historial.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Historial(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      dificultad:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}dificultad']),
      ejercicio: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}ejercicio']),
      fecha:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}fecha']),
      calorias:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}calorias']),
      duracion:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}duracion']),
      idUser:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_user']),
      activo:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}activo']),
    );
  }
  factory Historial.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Historial(
      id: serializer.fromJson<int>(json['id']),
      dificultad: serializer.fromJson<int>(json['dificultad']),
      ejercicio: serializer.fromJson<String>(json['ejercicio']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      calorias: serializer.fromJson<int>(json['calorias']),
      duracion: serializer.fromJson<int>(json['duracion']),
      idUser: serializer.fromJson<int>(json['idUser']),
      activo: serializer.fromJson<bool>(json['activo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dificultad': serializer.toJson<int>(dificultad),
      'ejercicio': serializer.toJson<String>(ejercicio),
      'fecha': serializer.toJson<DateTime>(fecha),
      'calorias': serializer.toJson<int>(calorias),
      'duracion': serializer.toJson<int>(duracion),
      'idUser': serializer.toJson<int>(idUser),
      'activo': serializer.toJson<bool>(activo),
    };
  }

  @override
  HistorialsCompanion createCompanion(bool nullToAbsent) {
    return HistorialsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      dificultad: dificultad == null && nullToAbsent
          ? const Value.absent()
          : Value(dificultad),
      ejercicio: ejercicio == null && nullToAbsent
          ? const Value.absent()
          : Value(ejercicio),
      fecha:
          fecha == null && nullToAbsent ? const Value.absent() : Value(fecha),
      calorias: calorias == null && nullToAbsent
          ? const Value.absent()
          : Value(calorias),
      duracion: duracion == null && nullToAbsent
          ? const Value.absent()
          : Value(duracion),
      idUser:
          idUser == null && nullToAbsent ? const Value.absent() : Value(idUser),
      activo:
          activo == null && nullToAbsent ? const Value.absent() : Value(activo),
    );
  }

  Historial copyWith(
          {int id,
          int dificultad,
          String ejercicio,
          DateTime fecha,
          int calorias,
          int duracion,
          int idUser,
          bool activo}) =>
      Historial(
        id: id ?? this.id,
        dificultad: dificultad ?? this.dificultad,
        ejercicio: ejercicio ?? this.ejercicio,
        fecha: fecha ?? this.fecha,
        calorias: calorias ?? this.calorias,
        duracion: duracion ?? this.duracion,
        idUser: idUser ?? this.idUser,
        activo: activo ?? this.activo,
      );
  @override
  String toString() {
    return (StringBuffer('Historial(')
          ..write('id: $id, ')
          ..write('dificultad: $dificultad, ')
          ..write('ejercicio: $ejercicio, ')
          ..write('fecha: $fecha, ')
          ..write('calorias: $calorias, ')
          ..write('duracion: $duracion, ')
          ..write('idUser: $idUser, ')
          ..write('activo: $activo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          dificultad.hashCode,
          $mrjc(
              ejercicio.hashCode,
              $mrjc(
                  fecha.hashCode,
                  $mrjc(
                      calorias.hashCode,
                      $mrjc(duracion.hashCode,
                          $mrjc(idUser.hashCode, activo.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Historial &&
          other.id == this.id &&
          other.dificultad == this.dificultad &&
          other.ejercicio == this.ejercicio &&
          other.fecha == this.fecha &&
          other.calorias == this.calorias &&
          other.duracion == this.duracion &&
          other.idUser == this.idUser &&
          other.activo == this.activo);
}

class HistorialsCompanion extends UpdateCompanion<Historial> {
  final Value<int> id;
  final Value<int> dificultad;
  final Value<String> ejercicio;
  final Value<DateTime> fecha;
  final Value<int> calorias;
  final Value<int> duracion;
  final Value<int> idUser;
  final Value<bool> activo;
  const HistorialsCompanion({
    this.id = const Value.absent(),
    this.dificultad = const Value.absent(),
    this.ejercicio = const Value.absent(),
    this.fecha = const Value.absent(),
    this.calorias = const Value.absent(),
    this.duracion = const Value.absent(),
    this.idUser = const Value.absent(),
    this.activo = const Value.absent(),
  });
  HistorialsCompanion.insert({
    this.id = const Value.absent(),
    @required int dificultad,
    @required String ejercicio,
    @required DateTime fecha,
    @required int calorias,
    @required int duracion,
    @required int idUser,
    this.activo = const Value.absent(),
  })  : dificultad = Value(dificultad),
        ejercicio = Value(ejercicio),
        fecha = Value(fecha),
        calorias = Value(calorias),
        duracion = Value(duracion),
        idUser = Value(idUser);
  HistorialsCompanion copyWith(
      {Value<int> id,
      Value<int> dificultad,
      Value<String> ejercicio,
      Value<DateTime> fecha,
      Value<int> calorias,
      Value<int> duracion,
      Value<int> idUser,
      Value<bool> activo}) {
    return HistorialsCompanion(
      id: id ?? this.id,
      dificultad: dificultad ?? this.dificultad,
      ejercicio: ejercicio ?? this.ejercicio,
      fecha: fecha ?? this.fecha,
      calorias: calorias ?? this.calorias,
      duracion: duracion ?? this.duracion,
      idUser: idUser ?? this.idUser,
      activo: activo ?? this.activo,
    );
  }
}

class $HistorialsTable extends Historials
    with TableInfo<$HistorialsTable, Historial> {
  final GeneratedDatabase _db;
  final String _alias;
  $HistorialsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _dificultadMeta = const VerificationMeta('dificultad');
  GeneratedIntColumn _dificultad;
  @override
  GeneratedIntColumn get dificultad => _dificultad ??= _constructDificultad();
  GeneratedIntColumn _constructDificultad() {
    return GeneratedIntColumn(
      'dificultad',
      $tableName,
      false,
    );
  }

  final VerificationMeta _ejercicioMeta = const VerificationMeta('ejercicio');
  GeneratedTextColumn _ejercicio;
  @override
  GeneratedTextColumn get ejercicio => _ejercicio ??= _constructEjercicio();
  GeneratedTextColumn _constructEjercicio() {
    return GeneratedTextColumn('ejercicio', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  GeneratedDateTimeColumn _fecha;
  @override
  GeneratedDateTimeColumn get fecha => _fecha ??= _constructFecha();
  GeneratedDateTimeColumn _constructFecha() {
    return GeneratedDateTimeColumn(
      'fecha',
      $tableName,
      false,
    );
  }

  final VerificationMeta _caloriasMeta = const VerificationMeta('calorias');
  GeneratedIntColumn _calorias;
  @override
  GeneratedIntColumn get calorias => _calorias ??= _constructCalorias();
  GeneratedIntColumn _constructCalorias() {
    return GeneratedIntColumn(
      'calorias',
      $tableName,
      false,
    );
  }

  final VerificationMeta _duracionMeta = const VerificationMeta('duracion');
  GeneratedIntColumn _duracion;
  @override
  GeneratedIntColumn get duracion => _duracion ??= _constructDuracion();
  GeneratedIntColumn _constructDuracion() {
    return GeneratedIntColumn(
      'duracion',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idUserMeta = const VerificationMeta('idUser');
  GeneratedIntColumn _idUser;
  @override
  GeneratedIntColumn get idUser => _idUser ??= _constructIdUser();
  GeneratedIntColumn _constructIdUser() {
    return GeneratedIntColumn('id_user', $tableName, false,
        $customConstraints: 'REFERENCES Usuario(id)');
  }

  final VerificationMeta _activoMeta = const VerificationMeta('activo');
  GeneratedBoolColumn _activo;
  @override
  GeneratedBoolColumn get activo => _activo ??= _constructActivo();
  GeneratedBoolColumn _constructActivo() {
    return GeneratedBoolColumn('activo', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, dificultad, ejercicio, fecha, calorias, duracion, idUser, activo];
  @override
  $HistorialsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'historials';
  @override
  final String actualTableName = 'historials';
  @override
  VerificationContext validateIntegrity(HistorialsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.dificultad.present) {
      context.handle(_dificultadMeta,
          dificultad.isAcceptableValue(d.dificultad.value, _dificultadMeta));
    } else if (isInserting) {
      context.missing(_dificultadMeta);
    }
    if (d.ejercicio.present) {
      context.handle(_ejercicioMeta,
          ejercicio.isAcceptableValue(d.ejercicio.value, _ejercicioMeta));
    } else if (isInserting) {
      context.missing(_ejercicioMeta);
    }
    if (d.fecha.present) {
      context.handle(
          _fechaMeta, fecha.isAcceptableValue(d.fecha.value, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (d.calorias.present) {
      context.handle(_caloriasMeta,
          calorias.isAcceptableValue(d.calorias.value, _caloriasMeta));
    } else if (isInserting) {
      context.missing(_caloriasMeta);
    }
    if (d.duracion.present) {
      context.handle(_duracionMeta,
          duracion.isAcceptableValue(d.duracion.value, _duracionMeta));
    } else if (isInserting) {
      context.missing(_duracionMeta);
    }
    if (d.idUser.present) {
      context.handle(
          _idUserMeta, idUser.isAcceptableValue(d.idUser.value, _idUserMeta));
    } else if (isInserting) {
      context.missing(_idUserMeta);
    }
    if (d.activo.present) {
      context.handle(
          _activoMeta, activo.isAcceptableValue(d.activo.value, _activoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Historial map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Historial.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(HistorialsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.dificultad.present) {
      map['dificultad'] = Variable<int, IntType>(d.dificultad.value);
    }
    if (d.ejercicio.present) {
      map['ejercicio'] = Variable<String, StringType>(d.ejercicio.value);
    }
    if (d.fecha.present) {
      map['fecha'] = Variable<DateTime, DateTimeType>(d.fecha.value);
    }
    if (d.calorias.present) {
      map['calorias'] = Variable<int, IntType>(d.calorias.value);
    }
    if (d.duracion.present) {
      map['duracion'] = Variable<int, IntType>(d.duracion.value);
    }
    if (d.idUser.present) {
      map['id_user'] = Variable<int, IntType>(d.idUser.value);
    }
    if (d.activo.present) {
      map['activo'] = Variable<bool, BoolType>(d.activo.value);
    }
    return map;
  }

  @override
  $HistorialsTable createAlias(String alias) {
    return $HistorialsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $UsuarioTable _usuario;
  $UsuarioTable get usuario => _usuario ??= $UsuarioTable(this);
  $RestriccionesTable _restricciones;
  $RestriccionesTable get restricciones =>
      _restricciones ??= $RestriccionesTable(this);
  $HistorialsTable _historials;
  $HistorialsTable get historials => _historials ??= $HistorialsTable(this);
  UsuarioDAO _usuarioDAO;
  UsuarioDAO get usuarioDAO => _usuarioDAO ??= UsuarioDAO(this as AppDatabase);
  RestriccionesDAO _restriccionesDAO;
  RestriccionesDAO get restriccionesDAO =>
      _restriccionesDAO ??= RestriccionesDAO(this as AppDatabase);
  HistorialDAO _historialDAO;
  HistorialDAO get historialDAO =>
      _historialDAO ??= HistorialDAO(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [usuario, restricciones, historials];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$UsuarioDAOMixin on DatabaseAccessor<AppDatabase> {
  $UsuarioTable get usuario => db.usuario;
}
mixin _$RestriccionesDAOMixin on DatabaseAccessor<AppDatabase> {
  $RestriccionesTable get restricciones => db.restricciones;
  $UsuarioTable get usuario => db.usuario;
}
mixin _$HistorialDAOMixin on DatabaseAccessor<AppDatabase> {
  $HistorialsTable get historials => db.historials;
  $UsuarioTable get usuario => db.usuario;
}
