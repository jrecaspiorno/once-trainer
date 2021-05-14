
class Session{
  int _id;
  String _name;
  String _nameid;
  String _estiramientosname;

  String get nameid => _nameid;

  String get name => _name;
  List<SubSession> _list;
  String get estiramientosname => _estiramientosname;

  Session(this._id, this._list, this._name, this._nameid,  this._estiramientosname);

  List<SubSession> get list => _list;

  int get id => _id;


}


class SubSession{
  String _name;
  int _numero;
  Tarea _principiante;


  Tarea _avanzado;

  SubSession(this._name, this._principiante, this._avanzado, this._numero);

  Tarea get principiante => _principiante;

  int get numero => _numero;

  String get name => _name;
  Tarea get avanzado => _avanzado;

}

class Tarea{

  Tarea(this._descanso, this._series, this._trabajo);
  String _trabajo;
  String _descanso;
  int _series;

  String get trabajo => _trabajo;

  String get descanso => _descanso;

  int get series => _series;

}