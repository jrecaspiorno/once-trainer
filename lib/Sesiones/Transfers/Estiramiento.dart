class EjEstiramiento {
  int _id;
  String _name;
  String _musculo;
  String _desc;
  String _pasos;
  bool _marcado = false;


  EjEstiramiento(this._id, this._name, this._musculo, this._desc, this._pasos);

  void setmarcado(bool value) {
    _marcado = value;
  }
  bool get marcado => _marcado;

  String get pasos => _pasos;

  String get desc => _desc;

  String get musculo => _musculo;

  String get name => _name;

  int get id => _id;


}