// This file has been generated by the dart_json_mapper v2.2.9
// https://github.com/k-paxian/dart-json-mapper
// @dart = 2.12
import 'comparisons/basic.dart' as x0 show PersonA, PersonB;
import 'comparisons/generic.dart' as x1 show BoxA, ContentA, BoxB, ContentB;
import 'comparisons/nested.dart' as x2 show GameA, PlayerA;
import 'comparisons/polymorph.dart' as x3 show AnimalA, CatA, DogA;
import 'comparisons/renaming.dart' as x4 show PersonA;
import 'package:dart_json_mapper/dart_json_mapper.dart'
    show
        JsonMapper,
        JsonMapperAdapter,
        SerializationOptions,
        DeserializationOptions,
        typeOf;
// This file has been generated by the reflectable package.
// https://github.com/dart-lang/reflectable.

import 'dart:core';
import 'package:dart_json_mapper/src/model/annotations.dart' as prefix0;
import 'package:package_comparison/comparisons/basic.dart' as prefix1;
import 'package:package_comparison/comparisons/generic.dart' as prefix2;

// ignore_for_file: camel_case_types
// ignore_for_file: implementation_imports
// ignore_for_file: prefer_adjacent_string_concatenation
// ignore_for_file: prefer_collection_literals
// ignore_for_file: unnecessary_const

// ignore:unused_import
import 'package:reflectable/mirrors.dart' as m;
// ignore:unused_import
import 'package:reflectable/src/reflectable_builder_based.dart' as r;
// ignore:unused_import
import 'package:reflectable/reflectable.dart' as r show Reflectable;

final _data = <r.Reflectable, r.ReflectorData>{
  const prefix0.JsonSerializable(): r.ReflectorData(
      <m.TypeMirror>[
        r.NonGenericClassMirrorImpl(
            r'PersonB',
            r'.PersonB',
            134217735,
            0,
            const prefix0.JsonSerializable(),
            const <int>[0, 4],
            const <int>[5, 6, 7, 8, 9, 3],
            const <int>[],
            -1,
            {},
            {},
            {
              r'': (bool b) =>
                  ({name}) => b ? prefix1.PersonB(name: name) : null
            },
            -1,
            0,
            const <int>[],
            const [prefix0.jsonSerializable],
            null),
        r.GenericClassMirrorImpl(
            r'BoxB',
            r'.BoxB',
            134217735,
            1,
            const prefix0.JsonSerializable(),
            const <int>[1, 11],
            const <int>[5, 6, 7, 8, 9, 10],
            const <int>[],
            -1,
            {},
            {},
            {
              r'': (bool b) =>
                  ({content}) => b ? prefix2.BoxB(content: content) : null
            },
            -1,
            1,
            const <int>[],
            const [prefix0.jsonSerializable],
            null, (o) {
          return o is prefix2.BoxB;
        }, const <int>[3], 1),
        r.NonGenericClassMirrorImpl(
            r'ContentB',
            r'.ContentB',
            134217735,
            2,
            const prefix0.JsonSerializable(),
            const <int>[2, 13],
            const <int>[5, 6, 7, 8, 9, 12],
            const <int>[],
            -1,
            {},
            {},
            {r'': (bool b) => (data) => b ? prefix2.ContentB(data) : null},
            -1,
            2,
            const <int>[],
            const [prefix0.jsonSerializable],
            null),
        r.TypeVariableMirrorImpl(
            r'T', r'.BoxB.T', const prefix0.JsonSerializable(), -1, 1, [])
      ],
      <m.DeclarationMirror>[
        r.VariableMirrorImpl(
            r'name',
            134349829,
            0,
            const prefix0.JsonSerializable(),
            -1,
            3,
            3, const <int>[], const []),
        r.VariableMirrorImpl(
            r'content',
            1029,
            1,
            const prefix0.JsonSerializable(),
            -1,
            -1,
            -1, const <int>[], const []),
        r.VariableMirrorImpl(
            r'data',
            134349829,
            2,
            const prefix0.JsonSerializable(),
            -1,
            3,
            3, const <int>[], const []),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 0, 3),
        r.MethodMirrorImpl(r'', 0, 0, -1, 0, 0, const <int>[], const <int>[0],
            const prefix0.JsonSerializable(), const []),
        r.MethodMirrorImpl(r'==', 2097154, -1, -1, 4, 4, const <int>[],
            const <int>[1], const prefix0.JsonSerializable(), const []),
        r.MethodMirrorImpl(r'toString', 2097154, -1, -1, 3, 3, const <int>[],
            const <int>[], const prefix0.JsonSerializable(), const []),
        r.MethodMirrorImpl(
            r'noSuchMethod',
            524290,
            -1,
            -1,
            -1,
            -1,
            const <int>[],
            const <int>[2],
            const prefix0.JsonSerializable(),
            const []),
        r.MethodMirrorImpl(r'hashCode', 2097155, -1, -1, 5, 5, const <int>[],
            const <int>[], const prefix0.JsonSerializable(), const []),
        r.MethodMirrorImpl(r'runtimeType', 2097155, -1, -1, 6, 6, const <int>[],
            const <int>[], const prefix0.JsonSerializable(), const []),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 1, 10),
        r.MethodMirrorImpl(r'', 0, 1, -1, 7, 1, null, const <int>[3],
            const prefix0.JsonSerializable(), const []),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 2, 12),
        r.MethodMirrorImpl(r'', 0, 2, -1, 2, 2, const <int>[], const <int>[4],
            const prefix0.JsonSerializable(), const [])
      ],
      <m.ParameterMirror>[
        r.ParameterMirrorImpl(
            r'name',
            134358022,
            4,
            const prefix0.JsonSerializable(),
            -1,
            3,
            3,
            const <int>[],
            const [],
            null,
            #name),
        r.ParameterMirrorImpl(
            r'other',
            134348806,
            5,
            const prefix0.JsonSerializable(),
            -1,
            8,
            8,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'invocation',
            134348806,
            7,
            const prefix0.JsonSerializable(),
            -1,
            9,
            9,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'content',
            9222,
            11,
            const prefix0.JsonSerializable(),
            -1,
            -1,
            -1,
            const <int>[],
            const [],
            null,
            #content),
        r.ParameterMirrorImpl(
            r'data',
            134349830,
            13,
            const prefix0.JsonSerializable(),
            -1,
            3,
            3,
            const <int>[],
            const [],
            null,
            null)
      ],
      <Type>[
        prefix1.PersonB,
        prefix2.BoxB,
        prefix2.ContentB,
        String,
        bool,
        int,
        Type,
        const r.FakeType(r'.BoxB<T>'),
        Object,
        Invocation
      ],
      3,
      {
        r'==': (dynamic instance) => (x) => instance == x,
        r'toString': (dynamic instance) => instance.toString,
        r'noSuchMethod': (dynamic instance) => instance.noSuchMethod,
        r'hashCode': (dynamic instance) => instance.hashCode,
        r'runtimeType': (dynamic instance) => instance.runtimeType,
        r'name': (dynamic instance) => instance.name,
        r'content': (dynamic instance) => instance.content,
        r'data': (dynamic instance) => instance.data
      },
      {},
      null,
      [])
};

final _memberSymbolMap = null;

void _initializeReflectable(JsonMapperAdapter adapter) {
  if (!adapter.isGenerated) {
    return;
  }
  r.data = adapter.reflectableData!;
  r.memberSymbolMap = adapter.memberSymbolMap;
}

final mainGeneratedAdapter = JsonMapperAdapter(
    title: 'package_comparison',
    url: 'package:package_comparison/main.dart',
    reflectableData: _data,
    memberSymbolMap: _memberSymbolMap,
    valueDecorators: {
      typeOf<List<x0.PersonA>>(): (value) => value.cast<x0.PersonA>(),
      typeOf<Set<x0.PersonA>>(): (value) => value.cast<x0.PersonA>(),
      typeOf<List<x0.PersonB>>(): (value) => value.cast<x0.PersonB>(),
      typeOf<Set<x0.PersonB>>(): (value) => value.cast<x0.PersonB>(),
      typeOf<List<x1.BoxA>>(): (value) => value.cast<x1.BoxA>(),
      typeOf<Set<x1.BoxA>>(): (value) => value.cast<x1.BoxA>(),
      typeOf<List<x1.ContentA>>(): (value) => value.cast<x1.ContentA>(),
      typeOf<Set<x1.ContentA>>(): (value) => value.cast<x1.ContentA>(),
      typeOf<List<x1.BoxB>>(): (value) => value.cast<x1.BoxB>(),
      typeOf<Set<x1.BoxB>>(): (value) => value.cast<x1.BoxB>(),
      typeOf<List<x1.ContentB>>(): (value) => value.cast<x1.ContentB>(),
      typeOf<Set<x1.ContentB>>(): (value) => value.cast<x1.ContentB>(),
      typeOf<List<x2.GameA>>(): (value) => value.cast<x2.GameA>(),
      typeOf<Set<x2.GameA>>(): (value) => value.cast<x2.GameA>(),
      typeOf<List<x2.PlayerA>>(): (value) => value.cast<x2.PlayerA>(),
      typeOf<Set<x2.PlayerA>>(): (value) => value.cast<x2.PlayerA>(),
      typeOf<List<x3.AnimalA>>(): (value) => value.cast<x3.AnimalA>(),
      typeOf<Set<x3.AnimalA>>(): (value) => value.cast<x3.AnimalA>(),
      typeOf<List<x3.CatA>>(): (value) => value.cast<x3.CatA>(),
      typeOf<Set<x3.CatA>>(): (value) => value.cast<x3.CatA>(),
      typeOf<List<x3.DogA>>(): (value) => value.cast<x3.DogA>(),
      typeOf<Set<x3.DogA>>(): (value) => value.cast<x3.DogA>(),
      typeOf<List<x4.PersonA>>(): (value) => value.cast<x4.PersonA>(),
      typeOf<Set<x4.PersonA>>(): (value) => value.cast<x4.PersonA>()
    },
    enumValues: {});

Future<JsonMapper> initializeJsonMapperAsync(
        {Iterable<JsonMapperAdapter> adapters = const [],
        SerializationOptions? serializationOptions,
        DeserializationOptions? deserializationOptions}) =>
    Future(() => initializeJsonMapper(
        adapters: adapters,
        serializationOptions: serializationOptions,
        deserializationOptions: deserializationOptions));

JsonMapper initializeJsonMapper(
    {Iterable<JsonMapperAdapter> adapters = const [],
    SerializationOptions? serializationOptions,
    DeserializationOptions? deserializationOptions}) {
  JsonMapper.globalSerializationOptions =
      serializationOptions ?? JsonMapper.globalSerializationOptions;
  JsonMapper.globalDeserializationOptions =
      deserializationOptions ?? JsonMapper.globalDeserializationOptions;
  JsonMapper.enumerateAdapters([...adapters, mainGeneratedAdapter],
      (JsonMapperAdapter adapter) {
    _initializeReflectable(adapter);
    JsonMapper().useAdapter(adapter);
  });
  return JsonMapper();
}
