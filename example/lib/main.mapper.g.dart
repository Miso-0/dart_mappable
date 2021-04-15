import 'dart:convert';
import 'package:dart_mappable_example/main.dart';

// ignore_for_file: unnecessary_cast

// === GENERATED MAPPER CLASSES AND EXTENSIONS ===

class PersonMapper extends StrictMapper<Person, Map<String, dynamic>> {
  PersonMapper._();
  static Person fromMap(Map<String, dynamic> map) => Person(map.get('name'), age: map.getOpt('age') ?? 18, car: map.getOpt('car'));

  @override Person strictDecode(Map<String, dynamic> map) => fromMap(map);
  @override Map<String, dynamic> strictEncode(Person p) => {'name': p.name, 'age': p.age, 'car': p.car?.toMap()};
  @override String stringify(Person self) => 'Person(${self.name}, age: ${self.age}, car: ${self.car})';
  @override int hash(Person self) => self.name.hashCode ^ self.age.hashCode ^ self.car.hashCode;
  @override bool strictEquals(Person self, Person other) => self.name == other.name && self.age == other.age && self.car == other.car;
}

extension PersonExtension on Person {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  Person copyWith({String? name, int? age, Car? car}) => Person(name ?? this.name, age: age ?? this.age, car: car ?? this.car);
}

class CarMapper extends StrictMapper<Car, Map<String, dynamic>> {
  CarMapper._();
  static Car fromMap(Map<String, dynamic> map) => Car(map.get('driven_km'), map.get('brand'));

  @override Car strictDecode(Map<String, dynamic> map) => fromMap(map);
  @override Map<String, dynamic> strictEncode(Car c) => {'driven_km': c.drivenKm, 'brand': c.brand.toStringValue()};
  @override String stringify(Car self) => 'Car(${self.drivenKm}, ${self.brand})';
  @override int hash(Car self) => self.drivenKm.hashCode ^ self.brand.hashCode;
  @override bool strictEquals(Car self, Car other) => self.drivenKm == other.drivenKm && self.brand == other.brand;
}

extension CarExtension on Car {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  Car copyWith({int? drivenKm, Brand? brand}) => Car(drivenKm ?? this.drivenKm, brand ?? this.brand);
}


extension BrandMapper on Brand {
  static Brand fromString(String value) {
    switch (value) {
      case 'toyota': return Brand.Toyota;
      case 'audi': return Brand.Audi;
      case 'bmw': return Brand.BMW;
      default: throw MapperException('Cannot parse String $value to enum Brand');
    }
  }
  String toStringValue() {
    switch (this) {
      case Brand.Toyota: return 'toyota';
      case Brand.Audi: return 'audi';
      case Brand.BMW: return 'bmw';
    }
  }
}



// === ALL STATICALLY REGISTERED MAPPERS ===

var _mappers = <Type, Mapper>{
  // primitive mappers
  typeOf<String>(): _PrimitiveMapper<String>((dynamic v) => v.toString()),
  typeOf<int>(): _PrimitiveMapper<int>((dynamic v) => num.parse(v.toString()).round()),
  typeOf<double>(): _PrimitiveMapper<double>((dynamic v) => double.parse(v.toString())),
  typeOf<num>(): _PrimitiveMapper<num>((dynamic v) => num.parse(v.toString())),
  typeOf<bool>(): _PrimitiveMapper<bool>((dynamic v) => v is num ? v != 0 : v.toString() == 'true'),
  // generated mappers
  typeOf<Person>(): PersonMapper._(),
  typeOf<Car>(): CarMapper._(),

  typeOf<Brand>(): _EnumMapper<Brand>(BrandMapper.fromString, (Brand b) => b.toStringValue()),

};


// === GENERATED UTILITY CLASSES ===

abstract class Mapper<T> {

  T decode(dynamic value);
  dynamic encode(T self);

  String stringify(T self);
  int hash(T self);
  bool equals(T self, Object? other);

  Mapper._();

  static T fromValue<T>(dynamic value, {Type? toType}) {
    var type = toType ?? T;
    if (value.runtimeType == type) {
      return value as T;
    } else if (_mappers[type] != null) {
      return (_mappers[type] as Mapper<T>).decode(value);
    } else {
      throw MapperException(
          'Cannot decode value $value of type ${value.runtimeType} to type $type. Unknown type. Did you forgot to include the class or register a custom mapper?');
    }
  }

  static dynamic toValue(dynamic value) {
    var type = value.runtimeType;
    if (_mappers[type] != null) {
      return _mappers[type]!.encode(value);
    } else {
      throw MapperException(
          'Cannot decode value to type $type. Unknown type. Did you forgot to include the class or register a custom mapper?');
    }
  }

  static T fromMap<T>(Map<String, dynamic> map) => fromValue<T>(map);

  static Map<String, dynamic> toMap(dynamic object) {
    var value = toValue(object);
    if (value is Map<String, dynamic>) {
      return value;
    } else {
      throw MapperException('Cannot encode value of type ${object.runtimeType} to Map. Instead encoded to type ${value.runtimeType}.');
    }
  }

  static T fromJson<T>(String json) => fromValue<T>(jsonDecode(json) as Map<String, dynamic>);
  static String toJson(dynamic object) => jsonEncode(toValue(object));

  static bool isEqual(dynamic value, Object? other) {
    var type = value.runtimeType;
    if (_mappers[type] != null) {
      return _mappers[type]!.equals(value, other);
    } else {
      throw MapperException(
          'Cannot compare value of type $type for equality. Unknown type. Did you forgot to include the class or register a custom mapper?');
    }
  }

  static String asString(dynamic value) {
    var type = value.runtimeType;
    if (_mappers[type] != null) {
      return _mappers[type]!.stringify(value);
    } else {
      throw MapperException(
          'Cannot stringify value of type $type. Unknown type. Did you forgot to include the class or register a custom mapper?');
    }
  }

  static void use<T>(Mapper<T> mapper) => _mappers[typeOf<T>()] = mapper;
}

abstract class Mappable<T> {
  String toJson() => jsonEncode(toMap());
  Map<String, dynamic> toMap() => _mappers[T]?.encode(this) as Map<String, dynamic>? ?? {};

  @override String toString() => _mappers[T]?.stringify(this) ?? super.toString();
  @override bool operator ==(Object other) => _mappers[T]?.equals(this, other) ?? this == other;
  @override int get hashCode => _mappers[T]?.hash(this) ?? this.hashCode;
}

Type typeOf<T>() => T;

abstract class StrictMapper<T, U> implements Mapper<T> {
  T strictDecode(U value);
  U strictEncode(T value);

  bool strictEquals(T self, T other);

  @override
  T decode(dynamic value) {
    if (value is U) {
      return strictDecode(value);
    } else {
      throw MapperException(
          'Cannot decode value of type ${value.runtimeType} to type $T, because a value of type $U is expected.');
    }
  }

  @override
  U encode(T value) => strictEncode(value);

  @override
  bool equals(T self, Object? other) =>
      identical(self, other) ||
      other is T &&
          self.runtimeType == other.runtimeType &&
          strictEquals(self, other as T);
}

abstract class BaseMapper<T> implements Mapper<T> {
  @override bool equals(T self, Object? other) => self == other;
  @override int hash(T self) => self.hashCode;
  @override String stringify(T self) => self.toString();
}

class _PrimitiveMapper<T> with BaseMapper<T> implements Mapper<T> {
  final T Function(dynamic value) parse;
  const _PrimitiveMapper(this.parse);

  @override T decode(dynamic value) => parse(value);
  @override dynamic encode(T value) => value;
}

class _EnumMapper<T> extends StrictMapper<T, String> with BaseMapper<T> {

  _EnumMapper(this.decoder, this.encoder);

  final T Function(String value) decoder;
  final String Function(T value) encoder;

  @override T strictDecode(String value) => decoder(value);
  @override String strictEncode(T value) => encoder(value);
  @override bool strictEquals(T self, T other) => self == other;
}

extension on Map<String, dynamic> {
  T get<T>(String key) {
    if (this[key] == null) {
      throw MapperException('Parameter $key is required.');
    }
    return Mapper.fromValue<T>(this[key]!);
  }

  T? getOpt<T>(String key) {
    if (this[key] == null) {
      return null;
    }
    return get<T>(key);
  }

  List<T> getList<T>(String key) {
    if (this[key] == null) {
      throw MapperException('Parameter $key is required.');
    } else if (this[key] is! List) {
      throw MapperException(
          'Parameter ${this[key]} with key $key is not a List');
    }
    List value = this[key] as List<dynamic>;
    return value.map((dynamic item) => Mapper.fromValue<T>(item)).toList();
  }

  List<T>? getListOpt<T>(String key) {
    if (this[key] == null) {
      return null;
    }
    return getList<T>(key);
  }

  Map<K, V> getMap<K, V>(String key) {
    if (this[key] == null) {
      throw MapperException('Parameter $key is required.');
    } else if (this[key] is! Map) {
      throw MapperException(
          'Parameter ${this[key]} with key $key is not a Map');
    }
    Map value = this[key] as Map<dynamic, dynamic>;
    return value.map((dynamic key, dynamic value) =>
        MapEntry(Mapper.fromValue<K>(key), Mapper.fromValue<V>(value)));
  }

  Map<K, V>? getMapOpt<K, V>(String key) {
    if (this[key] == null) {
      return null;
    }
    return getMap<K, V>(key);
  }
}

class MapperException implements Exception {
  final String message;
  const MapperException(this.message);

  @override
  String toString() => 'MapperException: $message';
}
