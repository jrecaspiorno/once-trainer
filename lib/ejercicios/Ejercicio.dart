


class Ejercicio {
  var _tags;
  String _name, _description, _type, _grupoprincipal;
  int _calories;
  int _dificultad;
  Ejercicio(this._name,this._description,this._calories, this._tags, this._dificultad, this._grupoprincipal);
  get dificultad => this._dificultad;
  get name => this._name;
  get description => this._description;
  get calories => this._calories;
  get tags => this._tags;
  get grupoprincipal => this._grupoprincipal;
  void setDiff(int diff) => this._dificultad = diff;
}