


class Ejercicio {
  List <String> _tags;
  String _name, _time, _description;
  int _calories;
  Ejercicio(this._name, this._time,this._description,this._calories, this._tags);
  get name => this._name;
  get time => this._time;
  get description => this._description;
  get calories => this._calories;
  get tags => this._tags;
}