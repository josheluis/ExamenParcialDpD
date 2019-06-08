class Account {
  int _id;
  String _name;
  String _description;
  String _moneda;
  int _saldo;

  Account(this._name, this._moneda, this._saldo, [this._description]);
  Account.withId(this._id, this._name, this._moneda, this._saldo, [this._description]);

  int get id => _id;
  String get name => _name;
  String get description => _description;
  String get moneda => _moneda;
  int get saldo => _saldo;

  set moneda (String moneda) {    
      _moneda = moneda;
  }

  set name (String name) {    
      _name = name;
  }

  set description (String description) {
      _description = description;
  }

    set saldo (int saldo) {
      _saldo = saldo;
  }
}
