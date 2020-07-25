class Note {

  int _id;
  String _name;
  double _size;
  String _sizeType;
  double _price;
  String _color;
  String _madeIn;

  Note(this._name, this._size, this._sizeType, this._price, this._color, this._madeIn);

  Note.withId(this._id, this._name, this._size, this._sizeType, this._price, this._color, this._madeIn);

  int get id => _id;

  String get name => _name;

  double get size => _size;

  String get sizeType => _sizeType;

  double get price => _price;

  String get color => _color;

  String get madeIn => _madeIn;

  set name(String newName) {
      this._name = newName;
    }
  set size(double newSize) {
    this._size = newSize;
  }
  set sizeType(String newSizeType) {
    this._sizeType = newSizeType;
  }
  set price(double newPrice) {
    this._price = newPrice;
  }
  set color(String newColor) {
    this._color = newColor;
  }
  set madeIn(String newMadeIn) {
    this._madeIn = newMadeIn;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['size'] = _size;
    map['sizeType'] = _sizeType;
    map['price'] = _price;
    map['color'] = _color;
    map['madeIn'] = _madeIn;
    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._size = map['size'];
    this._sizeType = map['sizeType'];
    this._price = map['price'];
    this._color = map['color'];
    this._madeIn = map['madeIn'];
  }
}
