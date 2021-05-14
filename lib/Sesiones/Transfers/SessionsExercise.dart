class EjSesion {
  int _id;
  var _tags;
  String _video;
  String _name, _description;
  bool _marcado = false;
  EjSesion(this._id, this._name,this._description,   this._video);
  get id => this._id;
  get name => this._name;
  get description => this._description;

  bool get marcado => _marcado;

  setmarcado(bool value) {
    _marcado = value;
  }

  get video => this._video;
  get mar => this._video;

}