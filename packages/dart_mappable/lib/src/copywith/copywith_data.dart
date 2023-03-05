import '../../dart_mappable.dart';

abstract class CopyWithData {
  V get<V>(Symbol name, {V or});
}

class FieldCopyWithData extends CopyWithData {
  FieldCopyWithData(this.fields);

  final Map<Symbol, dynamic> fields;

  @override
  V get<V>(Symbol name, {Object? or = $none}) {
    if (fields.containsKey(name) || or == $none) {
      return fields[name] as V;
    } else {
      return or as V;
    }
  }
}

class MergeCopyWithData extends CopyWithData {
  MergeCopyWithData(this.mapper, this.value);

  final ClassMapperBase mapper;
  final Object value;

  @override
  V get<V>(Symbol name, {Object? or = $none}) {
    var v = mapper.fields[name]!.get(value);
    if (v != null || or == $none) {
      return v as V;
    } else {
      return or as V;
    }
  }
}

class DeltaCopyWithData extends CopyWithData {
  DeltaCopyWithData(this.mapper, this.value)
      : context = DecodingContext(MapReader(value),
            container: MapperContainer.globals);

  final ClassMapperBase mapper;
  final Map<String, dynamic> value;
  final DecodingContext<DecodingReader> context;

  @override
  V get<V>(Symbol name, {Object? or = $none}) {
    var f = mapper.fields[name]!;
    if (value[f.key] != null || or == $none) {
      return f.decodeValue(context, value[f.key]) as V;
    } else {
      return or as V;
    }
  }
}
