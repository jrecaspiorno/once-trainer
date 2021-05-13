class EjSesion {
  int _id;
  var _tags;
  String _video;
  String _name, _description, _grupoprincipal;
  int _reps;
  String _time;
  bool _marcado = false;
  EjSesion(this._id, this._name,this._description,this._tags,  this._grupoprincipal, this._reps,  this._time, this._video);
  get id => this._id;
  get reps => this._reps;
  get name => this._name;
  get description => this._description;
  get time => this._time;

  bool get marcado => _marcado;

  setmarcado(bool value) {
    _marcado = value;
  }

  get video => this._video;
  get mar => this._video;
  void setTime(String time) => _time = time;
  get tags => this._tags;
  get grupoprincipal => this._grupoprincipal;
}