import 'package:collection/collection.dart';
import 'package:type_plus/type_plus.dart';

import '../annotations.dart';
import '../mapper_container.dart';
import '../mapper_exception.dart';
import '../mappers/mapper_base.dart';

typedef Decoder<V extends Object?, T> = T Function(DecodingContext<V> context);

typedef Encoder<R, V extends Object> = R Function(EncodingContext<V> context);

extension MappingOptionsCall<O extends MappingContext> on O {
  R call1<R>(R Function<A>(O) fn) {
    return callWith1(fn, _$identity);
  }

  R call2<R>(R Function<A, B>(O) fn) {
    return callWith2(fn, _$identity);
  }

  R call3<R>(R Function<A, B, C>(O) fn) {
    return callWith3(fn, _$identity);
  }

  R callWith<R, U>(Function fn, U value) {
    if (args.isEmpty) {
      return fn(value) as R;
    } else if (args.length == 1) {
      return args.first.provideTo(<A>() => fn<A>(value) as R);
    } else if (args.length == 2) {
      return args.first
          .provideTo(<A>() => args[1].provideTo(<B>() => fn<A, B>(value) as R));
    } else if (args.length == 3) {
      return args.first.provideTo(<A>() => args[1].provideTo(
          <B>() => args[2].provideTo(<C>() => fn<A, B, C>(value) as R)));
    } else {
      throw AssertionError('Max args are 3');
    }
  }

  R callWith1<R, U>(R Function<A>(U) fn, U Function(O) cb) {
    assert(args.length == 1);
    return args.first.provideTo(<A>() => fn<A>(cb(this)));
  }

  R callWith2<R, U>(R Function<A, B>(U) fn, U Function(O) cb) {
    assert(args.length == 2);
    return args.first
        .provideTo(<A>() => args[1].provideTo(<B>() => fn<A, B>(cb(this))));
  }

  R callWith3<R, U>(R Function<A, B, C>(U) fn, U Function(O) cb) {
    assert(args.length == 3);
    return args.first.provideTo(<A>() => args[1]
        .provideTo(<B>() => args[2].provideTo(<C>() => fn<A, B, C>(cb(this)))));
  }

  T _$identity<T>(T value) => value;
}

class MappingContext<V extends Object?> {
  final V value;
  final List<Type> args;
  final MapperContainer container;

  MappingContext(this.value, {MapperContainer? container, this.args = const []})
      : container = container ?? MapperContainer.globals;

  MappingContext<U> checked<U extends Object?>() {
    if (value is U) {
      return change<U>(value as U);
    } else {
      throw MapperException.unexpectedType(value.runtimeType, U.toString());
    }
  }

  MappingContext<$V> change<$V extends Object?>($V value) {
    if (identical(value, this.value) && $V == V) {
      return this as EncodingContext<$V>;
    }
    return MappingContext<$V>(value, container: container, args: args);
  }

  Type arg(int index, [List<int> argIndices = const []]) {
    var a = args[index];
    if (argIndices.isNotEmpty) {
      a = argIndices.fold(a, (a, i) => a.args.elementAtOrNull(i) ?? dynamic);
    }
    return a;
  }
}

class DecodingContext<V extends Object?> extends MappingContext<V> {
  final bool inherited;

  DecodingContext(super.value,
      {super.container, super.args, this.inherited = false});

  DecodingContext<V> inherit({MapperContainer? container, List<Type>? args}) {
    return DecodingContext<V>(
      value,
      container: container ?? this.container,
      args: args ?? this.args,
      inherited: true,
    );
  }

  T wrap<T>(Decoder<Object?, T> decoder,
      {MappingHook? hook, bool skipInherited = false}) {
    if (hook == null || (inherited && skipInherited)) {
      return decoder(this);
    } else {
      return hook.wrapDecode(
          value, (value) => decoder(change(value)), container);
    }
  }

  @override
  DecodingContext<U> checked<U extends Object?>() {
    return super.checked<U>() as DecodingContext<U>;
  }

  @override
  DecodingContext<$V> change<$V extends Object?>($V value) {
    if (identical(value, this.value) && $V == V) {
      return this as DecodingContext<$V>;
    }
    return DecodingContext<$V>(value,
        container: container, args: args, inherited: inherited);
  }
}

class EncodingContext<V extends Object?> extends MappingContext<V> {
  EncodingContext(super.value, {super.container, super.args});

  @override
  EncodingContext<U> checked<U extends Object?>() {
    return super.checked<U>() as EncodingContext<U>;
  }

  @override
  EncodingContext<$V> change<$V extends Object?>($V value) {
    if (identical(value, this.value) && $V == V) {
      return this as EncodingContext<$V>;
    }
    return EncodingContext<$V>(value, container: container, args: args);
  }
}

extension EncodingOptionsWrap<T extends Object, M extends MapperBase<T>>
    on EncodingContext<T> {
  Object? wrap(Encoder<Object?, T> encoder, {MappingHook? hook}) {
    if (hook == null) {
      return encoder(this);
    } else {
      return hook.wrapEncode<T>(
          value, (value) => encoder(change<T>(value)), container);
    }
  }
}

typedef TypeFactory0 = Object? Function(Object? Function<V>() f);
typedef TypeFactory1 = Object? Function<A>(Object? Function<V>() f);
typedef TypeFactory2 = Object? Function<A, B>(Object? Function<V>() f);
