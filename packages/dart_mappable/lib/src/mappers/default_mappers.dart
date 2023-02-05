import 'package:collection/collection.dart';

import '../mapper_exception.dart';
import '../mapper_utils.dart';
import 'mapper_base.dart';
import 'mapper_mixins.dart';
import 'simple_mapper.dart';

class PrimitiveMapper<T extends Object> extends MapperBase<T> {
  const PrimitiveMapper([T Function(Object value)? decoder, this.exactType])
      : _decoder = decoder ?? _cast<T>;

  final T Function(Object value) _decoder;
  final Type? exactType;

  @override
  Type get type => exactType ?? super.type;
  @override
  bool isFor(dynamic v) =>
      exactType != null ? v.runtimeType == exactType : super.isFor(v);

  static T _cast<T>(v) => v as T;

  @override
  T decoder(DecodingOptions<Object> options) {
    return _decoder(options.value);
  }

  @override
  Object encoder(EncodingOptions<Object> options) {
    return options.value;
  }
}

/// {@category Custom Mappers}
abstract class EnumMapper<T extends Enum> extends SimpleMapper<T> {
  const EnumMapper();
}

class DateTimeMapper extends SimpleMapper<DateTime> {
  const DateTimeMapper();

  @override
  DateTime decode(dynamic value) {
    if (value is String) {
      return DateTime.parse(value);
    } else if (value is num) {
      return DateTime.fromMillisecondsSinceEpoch(value.round());
    } else {
      throw MapperException.unexpectedType(
          value.runtimeType, DateTime, 'String or num');
    }
  }

  @override
  String encode(DateTime self) {
    return self.toUtc().toIso8601String();
  }
}

/// {@category Custom Mappers}
class IterableMapper<I extends Iterable> extends MapperBase<I>
    with MapperEqualityMixin<I> {
  IterableMapper(this.fromIterable, this.typeFactory);

  final Iterable<U> Function<U>(Iterable<U> iterable) fromIterable;

  @override
  final Function typeFactory;

  @override
  I decoder(DecodingOptions options) {
    return options.checked<Iterable>().call1(<T>(o) {
      return fromIterable(o.value.map((v) {
        return o.container.$dec<T>(v, 'item');
      })) as I;
    });
  }

  @override
  Object encoder(EncodingOptions<Object> options) {
    return options.checked<I>().call1(<T>(o) =>
        o.value.map((v) => o.container.$enc<T>(v as T, 'item')).toList());
  }

  @override
  Equality equality(Equality child) => IterableEquality(child);

  @override
  String stringify(MappingOptions<I> options) =>
      '(${options.value.map((e) => options.container.asString(e)).join(', ')})';
}

/// {@category Custom Mappers}
class MapMapper<M extends Map> extends MapperBase<M>
    with MapperEqualityMixin<M> {
  MapMapper(this.fromMap, this.typeFactory);

  Map<K, V> Function<K, V>(Map<K, V> map) fromMap;
  @override
  final Function typeFactory;

  @override
  M decoder(DecodingOptions options) {
    return options.checked<Map>().call2(<K, V>(o) {
      return fromMap(o.value.map((key, value) {
        return MapEntry(o.container.$dec<K>(key, 'key'),
            o.container.$dec<V>(value, 'value'));
      })) as M;
    });
  }

  @override
  Object encoder(EncodingOptions<Object> options) {
    return options.checked<M>().call2(<K, V>(o) => o.value.map((key, value) {
          return MapEntry(o.container.toValue<K>(key as K),
              o.container.toValue<V>(value as V));
        }));
  }

  @override
  Equality equality(Equality child) => MapEquality(keys: child, values: child);

  @override
  String stringify(MappingOptions<M> options) =>
      '{${options.value.entries.map((e) => '${options.container.asString(e.key)}: '
          '${options.container.asString(e.value)}').join(', ')}}';
}

typedef SerializableDecoder1<T, V> = T Function<A>(V, A Function(Object?));
typedef SerializableEncoder1<T> = Object Function(Object? Function(dynamic))
    Function(T);

typedef SerializableDecoder2<T, V> = T Function<A, B>(
    V, A Function(Object?), B Function(Object?));
typedef SerializableEncoder2<T> = Object Function(
        Object? Function(dynamic), Object? Function(dynamic))
    Function(T);

class SerializableMapper<T extends Object, V extends Object>
    extends MapperBase<T> {
  late T Function(DecodingOptions<V> o) _decoder;
  late Object Function(EncodingOptions<T> o) _encoder;

  @override
  late Function typeFactory;

  SerializableMapper({
    required T Function(V) decode,
    required Object Function() Function(T) encode,
  })  : _decoder = ((c) => decode(c.value)),
        _encoder = ((c) => encode(c.value)()),
        typeFactory = ((f) => f<T>());

  SerializableMapper.arg1({
    required SerializableDecoder1<T, V> decode,
    required SerializableEncoder1<T> encode,
    required TypeFactory1 type,
  }) {
    _decoder = ((c) =>
        c.call1(<A>(c) => decode<A>(c.value, c.container.fromValue<A>)));
    _encoder = ((c) => c.call1(
        <A>(c) => encode(c.value)((o) => c.container.toValue<A>(o as A)))!);
    typeFactory = type;
  }

  SerializableMapper.arg2({
    required SerializableDecoder2<T, V> decode,
    required SerializableEncoder2<T> encode,
    required TypeFactory2 type,
  }) {
    _decoder = ((c) => c.call2(<A, B>(c) => decode<A, B>(
        c.value, c.container.fromValue<A>, c.container.fromValue<B>)));
    _encoder = ((c) => c.call2(<A, B>(c) => encode(c.value)(
        (o) => c.container.toValue<A>(o as A),
        (o) => c.container.toValue<B>(o as B))));
    typeFactory = type;
  }

  @override
  T decoder(DecodingOptions<Object> options) {
    return _decoder(options.checked<V>());
  }

  @override
  Object encoder(EncodingOptions<Object> options) {
    return _encoder(options.checked<T>());
  }
}
