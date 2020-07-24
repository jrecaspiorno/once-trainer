// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class UsuarioData extends DataClass implements Insertable<UsuarioData> {
  final String id;
  final String nombre;
  final DateTime edad;
  final String photoUrl;
  final String email;
  final String backupid;
  UsuarioData(
      {@required this.id,
      @required this.nombre,
      @required this.edad,
      @required this.photoUrl,
      @required this.email,
      this.backupid});
  factory UsuarioData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return UsuarioData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      nombre:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}nombre']),
      edad:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}edad']),
      photoUrl: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}photo_url']),
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
      backupid: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}backupid']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || nombre != null) {
      map['nombre'] = Variable<String>(nombre);
    }
    if (!nullToAbsent || edad != null) {
      map['edad'] = Variable<DateTime>(edad);
    }
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || backupid != null) {
      map['backupid'] = Variable<String>(backupid);
    }
    return map;
  }

  UsuarioCompanion toCompanion(bool nullToAbsent) {
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
      backupid: backupid == null && nullToAbsent
          ? const Value.absent()
          : Value(backupid),
    );
  }

  factory UsuarioData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return UsuarioData(
      id: serializer.fromJson<String>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      edad: serializer.fromJson<DateTime>(json['edad']),
      photoUrl: serializer.fromJson<String>(json['photoUrl']),
      email: serializer.fromJson<String>(json['email']),
      backupid: serializer.fromJson<String>(json['backupid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nombre': serializer.toJson<String>(nombre),
      'edad': serializer.toJson<DateTime>(edad),
      'photoUrl': serializer.toJson<String>(photoUrl),
      'email': serializer.toJson<String>(email),
      'backupid': serializer.toJson<String>(backupid),
    };
  }

  UsuarioData copyWith(
          {String id,
          String nombre,
          DateTime edad,
          String photoUrl,
          String email,
          String backupid}) =>
      UsuarioData(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        edad: edad ?? this.edad,
        photoUrl: photoUrl ?? this.photoUrl,
        email: email ?? this.email,
        backupid: backupid ?? this.backupid,
      );
  @override
  String toString() {
    return (StringBuffer('UsuarioData(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('edad: $edad, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('email: $email, ')
          ..write('backupid: $backupid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          nombre.hashCode,
          $mrjc(
              edad.hashCode,
              $mrjc(photoUrl.hashCode,
                  $mrjc(email.hashCode, backupid.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is UsuarioData &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.edad == this.edad &&
          other.photoUrl == this.photoUrl &&
          other.email == this.email &&
          other.backupid == this.backupid);
}

class UsuarioCompanion extends UpdateCompanion<UsuarioData> {
  final Value<String> id;
  final Value<String> nombre;
  final Value<DateTime> edad;
  final Value<String> photoUrl;
  final Value<String> email;
  final Value<String> backupid;
  const UsuarioCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.edad = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.email = const Value.absent(),
    this.backupid = const Value.absent(),
  });
  UsuarioCompanion.insert({
    @required String id,
    @required String nombre,
    @required DateTime edad,
    @required String photoUrl,
    @required String email,
    this.backupid = const Value.absent(),
  })  : id = Value(id),
        nombre = Value(nombre),
        edad = Value(edad),
        photoUrl = Value(photoUrl),
        email = Value(email);
  static Insertable<UsuarioData> custom({
    Expression<String> id,
    Expression<String> nombre,
    Expression<DateTime> edad,
    Expression<String> photoUrl,
    Expression<String> email,
    Expression<String> backupid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (edad != null) 'edad': edad,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (email != null) 'email': email,
      if (backupid != null) 'backupid': backupid,
    });
  }

  UsuarioCompanion copyWith(
      {Value<String> id,
      Value<String> nombre,
      Value<DateTime> edad,
      Value<String> photoUrl,
      Value<String> email,
      Value<String> backupid}) {
    return UsuarioCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      edad: edad ?? this.edad,
      photoUrl: photoUrl ?? this.photoUrl,
      email: email ?? this.email,
      backupid: backupid ?? this.backupid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (edad.present) {
      map['edad'] = Variable<DateTime>(edad.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (backupid.present) {
      map['backupid'] = Variable<String>(backupid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuarioCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('edad: $edad, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('email: $email, ')
          ..write('backupid: $backupid')
          ..write(')'))
        .toString();
  }
}

class $UsuarioTable extends Usuario with TableInfo<$UsuarioTable, UsuarioData> {
  final GeneratedDatabase _db;
  final String _alias;
  $UsuarioTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn('id', $tableName, false, minTextLength: 1);
  }

  final VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  GeneratedTextColumn _nombre;
  @override
  GeneratedTextColumn get nombre => _nombre ??= _constructNombre();
  GeneratedTextColumn _constructNombre() {
    return GeneratedTextColumn('nombre', $tableName, false, minTextLength: 1);
  }

  final VerificationMeta _edadMeta = const VerificationMeta('edad');
  GeneratedDateTimeColumn _edad;
  @override
  GeneratedDateTimeColumn get edad => _edad ??= _constructEdad();
  GeneratedDateTimeColumn _constructEdad() {
    return GeneratedDateTimeColumn(
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

  final VerificationMeta _backupidMeta = const VerificationMeta('backupid');
  GeneratedTextColumn _backupid;
  @override
  GeneratedTextColumn get backupid => _backupid ??= _constructBackupid();
  GeneratedTextColumn _constructBackupid() {
    return GeneratedTextColumn('backupid', $tableName, true, minTextLength: 1);
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, nombre, edad, photoUrl, email, backupid];
  @override
  $UsuarioTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'usuario';
  @override
  final String actualTableName = 'usuario';
  @override
  VerificationContext validateIntegrity(Insertable<UsuarioData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre'], _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('edad')) {
      context.handle(
          _edadMeta, edad.isAcceptableOrUnknown(data['edad'], _edadMeta));
    } else if (isInserting) {
      context.missing(_edadMeta);
    }
    if (data.containsKey('photo_url')) {
      context.handle(_photoUrlMeta,
          photoUrl.isAcceptableOrUnknown(data['photo_url'], _photoUrlMeta));
    } else if (isInserting) {
      context.missing(_photoUrlMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email'], _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('backupid')) {
      context.handle(_backupidMeta,
          backupid.isAcceptableOrUnknown(data['backupid'], _backupidMeta));
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
  $UsuarioTable createAlias(String alias) {
    return $UsuarioTable(_db, alias);
  }
}

class Restriccione extends DataClass implements Insertable<Restriccione> {
  final int id;
  final String tipo;
  final String idUser;
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
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}id_user']),
      activo:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}activo']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || tipo != null) {
      map['tipo'] = Variable<String>(tipo);
    }
    if (!nullToAbsent || idUser != null) {
      map['id_user'] = Variable<String>(idUser);
    }
    if (!nullToAbsent || activo != null) {
      map['activo'] = Variable<bool>(activo);
    }
    return map;
  }

  RestriccionesCompanion toCompanion(bool nullToAbsent) {
    return RestriccionesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      tipo: tipo == null && nullToAbsent ? const Value.absent() : Value(tipo),
      idUser:
          idUser == null && nullToAbsent ? const Value.absent() : Value(idUser),
      activo:
          activo == null && nullToAbsent ? const Value.absent() : Value(activo),
    );
  }

  factory Restriccione.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Restriccione(
      id: serializer.fromJson<int>(json['id']),
      tipo: serializer.fromJson<String>(json['tipo']),
      idUser: serializer.fromJson<String>(json['idUser']),
      activo: serializer.fromJson<bool>(json['activo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tipo': serializer.toJson<String>(tipo),
      'idUser': serializer.toJson<String>(idUser),
      'activo': serializer.toJson<bool>(activo),
    };
  }

  Restriccione copyWith({int id, String tipo, String idUser, bool activo}) =>
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
  final Value<String> idUser;
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
    @required String idUser,
    this.activo = const Value.absent(),
  })  : tipo = Value(tipo),
        idUser = Value(idUser);
  static Insertable<Restriccione> custom({
    Expression<int> id,
    Expression<String> tipo,
    Expression<String> idUser,
    Expression<bool> activo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tipo != null) 'tipo': tipo,
      if (idUser != null) 'id_user': idUser,
      if (activo != null) 'activo': activo,
    });
  }

  RestriccionesCompanion copyWith(
      {Value<int> id,
      Value<String> tipo,
      Value<String> idUser,
      Value<bool> activo}) {
    return RestriccionesCompanion(
      id: id ?? this.id,
      tipo: tipo ?? this.tipo,
      idUser: idUser ?? this.idUser,
      activo: activo ?? this.activo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (idUser.present) {
      map['id_user'] = Variable<String>(idUser.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RestriccionesCompanion(')
          ..write('id: $id, ')
          ..write('tipo: $tipo, ')
          ..write('idUser: $idUser, ')
          ..write('activo: $activo')
          ..write(')'))
        .toString();
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
  GeneratedTextColumn _idUser;
  @override
  GeneratedTextColumn get idUser => _idUser ??= _constructIdUser();
  GeneratedTextColumn _constructIdUser() {
    return GeneratedTextColumn('id_user', $tableName, false,
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
  VerificationContext validateIntegrity(Insertable<Restriccione> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('tipo')) {
      context.handle(
          _tipoMeta, tipo.isAcceptableOrUnknown(data['tipo'], _tipoMeta));
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('id_user')) {
      context.handle(_idUserMeta,
          idUser.isAcceptableOrUnknown(data['id_user'], _idUserMeta));
    } else if (isInserting) {
      context.missing(_idUserMeta);
    }
    if (data.containsKey('activo')) {
      context.handle(_activoMeta,
          activo.isAcceptableOrUnknown(data['activo'], _activoMeta));
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
  $RestriccionesTable createAlias(String alias) {
    return $RestriccionesTable(_db, alias);
  }
}

class Historial extends DataClass implements Insertable<Historial> {
  final int id;
  final int dificultad;
  final String ejercicio;
  final String tipo;
  final DateTime fecha;
  final int calorias;
  final String duracion;
  final int repeticiones;
  final int series;
  final String idUser;
  final bool activo;
  Historial(
      {@required this.id,
      @required this.dificultad,
      @required this.ejercicio,
      @required this.tipo,
      @required this.fecha,
      this.calorias,
      this.duracion,
      this.repeticiones,
      this.series,
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
      tipo: stringType.mapFromDatabaseResponse(data['${effectivePrefix}tipo']),
      fecha:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}fecha']),
      calorias:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}calorias']),
      duracion: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}duracion']),
      repeticiones: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}repeticiones']),
      series: intType.mapFromDatabaseResponse(data['${effectivePrefix}series']),
      idUser:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}id_user']),
      activo:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}activo']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || dificultad != null) {
      map['dificultad'] = Variable<int>(dificultad);
    }
    if (!nullToAbsent || ejercicio != null) {
      map['ejercicio'] = Variable<String>(ejercicio);
    }
    if (!nullToAbsent || tipo != null) {
      map['tipo'] = Variable<String>(tipo);
    }
    if (!nullToAbsent || fecha != null) {
      map['fecha'] = Variable<DateTime>(fecha);
    }
    if (!nullToAbsent || calorias != null) {
      map['calorias'] = Variable<int>(calorias);
    }
    if (!nullToAbsent || duracion != null) {
      map['duracion'] = Variable<String>(duracion);
    }
    if (!nullToAbsent || repeticiones != null) {
      map['repeticiones'] = Variable<int>(repeticiones);
    }
    if (!nullToAbsent || series != null) {
      map['series'] = Variable<int>(series);
    }
    if (!nullToAbsent || idUser != null) {
      map['id_user'] = Variable<String>(idUser);
    }
    if (!nullToAbsent || activo != null) {
      map['activo'] = Variable<bool>(activo);
    }
    return map;
  }

  HistorialsCompanion toCompanion(bool nullToAbsent) {
    return HistorialsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      dificultad: dificultad == null && nullToAbsent
          ? const Value.absent()
          : Value(dificultad),
      ejercicio: ejercicio == null && nullToAbsent
          ? const Value.absent()
          : Value(ejercicio),
      tipo: tipo == null && nullToAbsent ? const Value.absent() : Value(tipo),
      fecha:
          fecha == null && nullToAbsent ? const Value.absent() : Value(fecha),
      calorias: calorias == null && nullToAbsent
          ? const Value.absent()
          : Value(calorias),
      duracion: duracion == null && nullToAbsent
          ? const Value.absent()
          : Value(duracion),
      repeticiones: repeticiones == null && nullToAbsent
          ? const Value.absent()
          : Value(repeticiones),
      series:
          series == null && nullToAbsent ? const Value.absent() : Value(series),
      idUser:
          idUser == null && nullToAbsent ? const Value.absent() : Value(idUser),
      activo:
          activo == null && nullToAbsent ? const Value.absent() : Value(activo),
    );
  }

  factory Historial.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Historial(
      id: serializer.fromJson<int>(json['id']),
      dificultad: serializer.fromJson<int>(json['dificultad']),
      ejercicio: serializer.fromJson<String>(json['ejercicio']),
      tipo: serializer.fromJson<String>(json['tipo']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      calorias: serializer.fromJson<int>(json['calorias']),
      duracion: serializer.fromJson<String>(json['duracion']),
      repeticiones: serializer.fromJson<int>(json['repeticiones']),
      series: serializer.fromJson<int>(json['series']),
      idUser: serializer.fromJson<String>(json['idUser']),
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
      'tipo': serializer.toJson<String>(tipo),
      'fecha': serializer.toJson<DateTime>(fecha),
      'calorias': serializer.toJson<int>(calorias),
      'duracion': serializer.toJson<String>(duracion),
      'repeticiones': serializer.toJson<int>(repeticiones),
      'series': serializer.toJson<int>(series),
      'idUser': serializer.toJson<String>(idUser),
      'activo': serializer.toJson<bool>(activo),
    };
  }

  Historial copyWith(
          {int id,
          int dificultad,
          String ejercicio,
          String tipo,
          DateTime fecha,
          int calorias,
          String duracion,
          int repeticiones,
          int series,
          String idUser,
          bool activo}) =>
      Historial(
        id: id ?? this.id,
        dificultad: dificultad ?? this.dificultad,
        ejercicio: ejercicio ?? this.ejercicio,
        tipo: tipo ?? this.tipo,
        fecha: fecha ?? this.fecha,
        calorias: calorias ?? this.calorias,
        duracion: duracion ?? this.duracion,
        repeticiones: repeticiones ?? this.repeticiones,
        series: series ?? this.series,
        idUser: idUser ?? this.idUser,
        activo: activo ?? this.activo,
      );
  @override
  String toString() {
    return (StringBuffer('Historial(')
          ..write('id: $id, ')
          ..write('dificultad: $dificultad, ')
          ..write('ejercicio: $ejercicio, ')
          ..write('tipo: $tipo, ')
          ..write('fecha: $fecha, ')
          ..write('calorias: $calorias, ')
          ..write('duracion: $duracion, ')
          ..write('repeticiones: $repeticiones, ')
          ..write('series: $series, ')
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
                  tipo.hashCode,
                  $mrjc(
                      fecha.hashCode,
                      $mrjc(
                          calorias.hashCode,
                          $mrjc(
                              duracion.hashCode,
                              $mrjc(
                                  repeticiones.hashCode,
                                  $mrjc(
                                      series.hashCode,
                                      $mrjc(idUser.hashCode,
                                          activo.hashCode)))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Historial &&
          other.id == this.id &&
          other.dificultad == this.dificultad &&
          other.ejercicio == this.ejercicio &&
          other.tipo == this.tipo &&
          other.fecha == this.fecha &&
          other.calorias == this.calorias &&
          other.duracion == this.duracion &&
          other.repeticiones == this.repeticiones &&
          other.series == this.series &&
          other.idUser == this.idUser &&
          other.activo == this.activo);
}

class HistorialsCompanion extends UpdateCompanion<Historial> {
  final Value<int> id;
  final Value<int> dificultad;
  final Value<String> ejercicio;
  final Value<String> tipo;
  final Value<DateTime> fecha;
  final Value<int> calorias;
  final Value<String> duracion;
  final Value<int> repeticiones;
  final Value<int> series;
  final Value<String> idUser;
  final Value<bool> activo;
  const HistorialsCompanion({
    this.id = const Value.absent(),
    this.dificultad = const Value.absent(),
    this.ejercicio = const Value.absent(),
    this.tipo = const Value.absent(),
    this.fecha = const Value.absent(),
    this.calorias = const Value.absent(),
    this.duracion = const Value.absent(),
    this.repeticiones = const Value.absent(),
    this.series = const Value.absent(),
    this.idUser = const Value.absent(),
    this.activo = const Value.absent(),
  });
  HistorialsCompanion.insert({
    this.id = const Value.absent(),
    @required int dificultad,
    @required String ejercicio,
    @required String tipo,
    @required DateTime fecha,
    this.calorias = const Value.absent(),
    this.duracion = const Value.absent(),
    this.repeticiones = const Value.absent(),
    this.series = const Value.absent(),
    @required String idUser,
    this.activo = const Value.absent(),
  })  : dificultad = Value(dificultad),
        ejercicio = Value(ejercicio),
        tipo = Value(tipo),
        fecha = Value(fecha),
        idUser = Value(idUser);
  static Insertable<Historial> custom({
    Expression<int> id,
    Expression<int> dificultad,
    Expression<String> ejercicio,
    Expression<String> tipo,
    Expression<DateTime> fecha,
    Expression<int> calorias,
    Expression<String> duracion,
    Expression<int> repeticiones,
    Expression<int> series,
    Expression<String> idUser,
    Expression<bool> activo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dificultad != null) 'dificultad': dificultad,
      if (ejercicio != null) 'ejercicio': ejercicio,
      if (tipo != null) 'tipo': tipo,
      if (fecha != null) 'fecha': fecha,
      if (calorias != null) 'calorias': calorias,
      if (duracion != null) 'duracion': duracion,
      if (repeticiones != null) 'repeticiones': repeticiones,
      if (series != null) 'series': series,
      if (idUser != null) 'id_user': idUser,
      if (activo != null) 'activo': activo,
    });
  }

  HistorialsCompanion copyWith(
      {Value<int> id,
      Value<int> dificultad,
      Value<String> ejercicio,
      Value<String> tipo,
      Value<DateTime> fecha,
      Value<int> calorias,
      Value<String> duracion,
      Value<int> repeticiones,
      Value<int> series,
      Value<String> idUser,
      Value<bool> activo}) {
    return HistorialsCompanion(
      id: id ?? this.id,
      dificultad: dificultad ?? this.dificultad,
      ejercicio: ejercicio ?? this.ejercicio,
      tipo: tipo ?? this.tipo,
      fecha: fecha ?? this.fecha,
      calorias: calorias ?? this.calorias,
      duracion: duracion ?? this.duracion,
      repeticiones: repeticiones ?? this.repeticiones,
      series: series ?? this.series,
      idUser: idUser ?? this.idUser,
      activo: activo ?? this.activo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dificultad.present) {
      map['dificultad'] = Variable<int>(dificultad.value);
    }
    if (ejercicio.present) {
      map['ejercicio'] = Variable<String>(ejercicio.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (calorias.present) {
      map['calorias'] = Variable<int>(calorias.value);
    }
    if (duracion.present) {
      map['duracion'] = Variable<String>(duracion.value);
    }
    if (repeticiones.present) {
      map['repeticiones'] = Variable<int>(repeticiones.value);
    }
    if (series.present) {
      map['series'] = Variable<int>(series.value);
    }
    if (idUser.present) {
      map['id_user'] = Variable<String>(idUser.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistorialsCompanion(')
          ..write('id: $id, ')
          ..write('dificultad: $dificultad, ')
          ..write('ejercicio: $ejercicio, ')
          ..write('tipo: $tipo, ')
          ..write('fecha: $fecha, ')
          ..write('calorias: $calorias, ')
          ..write('duracion: $duracion, ')
          ..write('repeticiones: $repeticiones, ')
          ..write('series: $series, ')
          ..write('idUser: $idUser, ')
          ..write('activo: $activo')
          ..write(')'))
        .toString();
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

  final VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  GeneratedTextColumn _tipo;
  @override
  GeneratedTextColumn get tipo => _tipo ??= _constructTipo();
  GeneratedTextColumn _constructTipo() {
    return GeneratedTextColumn('tipo', $tableName, false,
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
      true,
    );
  }

  final VerificationMeta _duracionMeta = const VerificationMeta('duracion');
  GeneratedTextColumn _duracion;
  @override
  GeneratedTextColumn get duracion => _duracion ??= _constructDuracion();
  GeneratedTextColumn _constructDuracion() {
    return GeneratedTextColumn('duracion', $tableName, true,
        minTextLength: 1, maxTextLength: 30);
  }

  final VerificationMeta _repeticionesMeta =
      const VerificationMeta('repeticiones');
  GeneratedIntColumn _repeticiones;
  @override
  GeneratedIntColumn get repeticiones =>
      _repeticiones ??= _constructRepeticiones();
  GeneratedIntColumn _constructRepeticiones() {
    return GeneratedIntColumn(
      'repeticiones',
      $tableName,
      true,
    );
  }

  final VerificationMeta _seriesMeta = const VerificationMeta('series');
  GeneratedIntColumn _series;
  @override
  GeneratedIntColumn get series => _series ??= _constructSeries();
  GeneratedIntColumn _constructSeries() {
    return GeneratedIntColumn(
      'series',
      $tableName,
      true,
    );
  }

  final VerificationMeta _idUserMeta = const VerificationMeta('idUser');
  GeneratedTextColumn _idUser;
  @override
  GeneratedTextColumn get idUser => _idUser ??= _constructIdUser();
  GeneratedTextColumn _constructIdUser() {
    return GeneratedTextColumn('id_user', $tableName, false,
        $customConstraints: 'REFERENCES Usuario(id)');
  }

  final VerificationMeta _activoMeta = const VerificationMeta('activo');
  GeneratedBoolColumn _activo;
  @override
  GeneratedBoolColumn get activo => _activo ??= _constructActivo();
  GeneratedBoolColumn _constructActivo() {
    return GeneratedBoolColumn('activo', $tableName, false,
        defaultValue: Constant(true));
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        dificultad,
        ejercicio,
        tipo,
        fecha,
        calorias,
        duracion,
        repeticiones,
        series,
        idUser,
        activo
      ];
  @override
  $HistorialsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'historials';
  @override
  final String actualTableName = 'historials';
  @override
  VerificationContext validateIntegrity(Insertable<Historial> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('dificultad')) {
      context.handle(
          _dificultadMeta,
          dificultad.isAcceptableOrUnknown(
              data['dificultad'], _dificultadMeta));
    } else if (isInserting) {
      context.missing(_dificultadMeta);
    }
    if (data.containsKey('ejercicio')) {
      context.handle(_ejercicioMeta,
          ejercicio.isAcceptableOrUnknown(data['ejercicio'], _ejercicioMeta));
    } else if (isInserting) {
      context.missing(_ejercicioMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
          _tipoMeta, tipo.isAcceptableOrUnknown(data['tipo'], _tipoMeta));
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha'], _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('calorias')) {
      context.handle(_caloriasMeta,
          calorias.isAcceptableOrUnknown(data['calorias'], _caloriasMeta));
    }
    if (data.containsKey('duracion')) {
      context.handle(_duracionMeta,
          duracion.isAcceptableOrUnknown(data['duracion'], _duracionMeta));
    }
    if (data.containsKey('repeticiones')) {
      context.handle(
          _repeticionesMeta,
          repeticiones.isAcceptableOrUnknown(
              data['repeticiones'], _repeticionesMeta));
    }
    if (data.containsKey('series')) {
      context.handle(_seriesMeta,
          series.isAcceptableOrUnknown(data['series'], _seriesMeta));
    }
    if (data.containsKey('id_user')) {
      context.handle(_idUserMeta,
          idUser.isAcceptableOrUnknown(data['id_user'], _idUserMeta));
    } else if (isInserting) {
      context.missing(_idUserMeta);
    }
    if (data.containsKey('activo')) {
      context.handle(_activoMeta,
          activo.isAcceptableOrUnknown(data['activo'], _activoMeta));
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
  $UsuarioTable get usuario => attachedDatabase.usuario;
}
mixin _$RestriccionesDAOMixin on DatabaseAccessor<AppDatabase> {
  $RestriccionesTable get restricciones => attachedDatabase.restricciones;
  $UsuarioTable get usuario => attachedDatabase.usuario;
}
mixin _$HistorialDAOMixin on DatabaseAccessor<AppDatabase> {
  $HistorialsTable get historials => attachedDatabase.historials;
  $UsuarioTable get usuario => attachedDatabase.usuario;
}
