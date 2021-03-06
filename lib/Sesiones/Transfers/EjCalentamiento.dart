class EjCalentamiento {
  int _id;
  var _tags;
  String _name, _description, _grupoprincipal;
  int _reps;
  int _series;
  bool _marcado = false;
  EjCalentamiento(this._id, this._name,this._description,this._tags,  this._grupoprincipal, this._reps, this._series) ;
  get id => this._id;
  get reps => this._reps;
  get series => this._series;
  get name => this._name;
  get description => this._description;

  void setmarcado(bool value) {
    _marcado = value;
  }

  bool get marcado => _marcado;

  get tags => this._tags;
  get grupoprincipal => this._grupoprincipal;
}