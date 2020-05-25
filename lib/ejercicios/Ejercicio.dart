


class Ejercicio {
  var _tags;
  String _name, _description, _type;
  int _calories;
  Ejercicio(this._name,this._description,this._calories, this._tags);
  get name => this._name;
  get description => this._description;
  get calories => this._calories;
  get tags => this._tags;
}