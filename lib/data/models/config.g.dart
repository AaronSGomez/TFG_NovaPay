// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetConfigCollection on Isar {
  IsarCollection<Config> get configs => this.collection();
}

const ConfigSchema = CollectionSchema(
  name: r'Config',
  id: -3644000870443854999,
  properties: {
    r'businessMode': PropertySchema(
      id: 0,
      name: r'businessMode',
      type: IsarType.string,
    ),
    r'businessName': PropertySchema(
      id: 1,
      name: r'businessName',
      type: IsarType.string,
    ),
    r'printerMacAddress': PropertySchema(
      id: 2,
      name: r'printerMacAddress',
      type: IsarType.string,
    ),
    r'verifactuClientHash': PropertySchema(
      id: 3,
      name: r'verifactuClientHash',
      type: IsarType.string,
    ),
    r'verifactuClientId': PropertySchema(
      id: 4,
      name: r'verifactuClientId',
      type: IsarType.string,
    ),
    r'verifactuIsNewSystem': PropertySchema(
      id: 5,
      name: r'verifactuIsNewSystem',
      type: IsarType.bool,
    ),
    r'verifactuLastAuthAt': PropertySchema(
      id: 6,
      name: r'verifactuLastAuthAt',
      type: IsarType.dateTime,
    ),
    r'verifactuRegistered': PropertySchema(
      id: 7,
      name: r'verifactuRegistered',
      type: IsarType.bool,
    )
  },
  estimateSize: _configEstimateSize,
  serialize: _configSerialize,
  deserialize: _configDeserialize,
  deserializeProp: _configDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _configGetId,
  getLinks: _configGetLinks,
  attach: _configAttach,
  version: '3.1.0+1',
);

int _configEstimateSize(
  Config object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.businessMode.length * 3;
  bytesCount += 3 + object.businessName.length * 3;
  {
    final value = object.printerMacAddress;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.verifactuClientHash;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.verifactuClientId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _configSerialize(
  Config object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.businessMode);
  writer.writeString(offsets[1], object.businessName);
  writer.writeString(offsets[2], object.printerMacAddress);
  writer.writeString(offsets[3], object.verifactuClientHash);
  writer.writeString(offsets[4], object.verifactuClientId);
  writer.writeBool(offsets[5], object.verifactuIsNewSystem);
  writer.writeDateTime(offsets[6], object.verifactuLastAuthAt);
  writer.writeBool(offsets[7], object.verifactuRegistered);
}

Config _configDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Config();
  object.businessMode = reader.readString(offsets[0]);
  object.businessName = reader.readString(offsets[1]);
  object.id = id;
  object.printerMacAddress = reader.readStringOrNull(offsets[2]);
  object.verifactuClientHash = reader.readStringOrNull(offsets[3]);
  object.verifactuClientId = reader.readStringOrNull(offsets[4]);
  object.verifactuIsNewSystem = reader.readBool(offsets[5]);
  object.verifactuLastAuthAt = reader.readDateTimeOrNull(offsets[6]);
  object.verifactuRegistered = reader.readBool(offsets[7]);
  return object;
}

P _configDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _configGetId(Config object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _configGetLinks(Config object) {
  return [];
}

void _configAttach(IsarCollection<dynamic> col, Id id, Config object) {
  object.id = id;
}

extension ConfigQueryWhereSort on QueryBuilder<Config, Config, QWhere> {
  QueryBuilder<Config, Config, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ConfigQueryWhere on QueryBuilder<Config, Config, QWhereClause> {
  QueryBuilder<Config, Config, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Config, Config, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Config, Config, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Config, Config, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ConfigQueryFilter on QueryBuilder<Config, Config, QFilterCondition> {
  QueryBuilder<Config, Config, QAfterFilterCondition> businessModeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'businessMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> businessModeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'businessMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> businessModeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'businessMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> businessModeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'businessMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> businessModeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'businessMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> businessModeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'businessMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> businessModeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'businessMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> businessModeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'businessMode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> businessModeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'businessMode',
        value: '',
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> businessModeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'businessMode',
        value: '',
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> businessNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'businessName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> businessNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'businessName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> businessNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'businessName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> businessNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'businessName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> businessNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'businessName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> businessNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'businessName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> businessNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'businessName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> businessNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'businessName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> businessNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'businessName',
        value: '',
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> businessNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'businessName',
        value: '',
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      printerMacAddressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'printerMacAddress',
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      printerMacAddressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'printerMacAddress',
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> printerMacAddressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'printerMacAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      printerMacAddressGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'printerMacAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> printerMacAddressLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'printerMacAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> printerMacAddressBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'printerMacAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      printerMacAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'printerMacAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> printerMacAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'printerMacAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> printerMacAddressContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'printerMacAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> printerMacAddressMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'printerMacAddress',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      printerMacAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'printerMacAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      printerMacAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'printerMacAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuClientHashIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'verifactuClientHash',
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuClientHashIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'verifactuClientHash',
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuClientHashEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verifactuClientHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuClientHashGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'verifactuClientHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuClientHashLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'verifactuClientHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuClientHashBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'verifactuClientHash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuClientHashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'verifactuClientHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuClientHashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'verifactuClientHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuClientHashContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'verifactuClientHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuClientHashMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'verifactuClientHash',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuClientHashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verifactuClientHash',
        value: '',
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuClientHashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'verifactuClientHash',
        value: '',
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuClientIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'verifactuClientId',
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuClientIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'verifactuClientId',
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> verifactuClientIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verifactuClientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuClientIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'verifactuClientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> verifactuClientIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'verifactuClientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> verifactuClientIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'verifactuClientId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuClientIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'verifactuClientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> verifactuClientIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'verifactuClientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> verifactuClientIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'verifactuClientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition> verifactuClientIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'verifactuClientId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuClientIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verifactuClientId',
        value: '',
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuClientIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'verifactuClientId',
        value: '',
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuIsNewSystemEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verifactuIsNewSystem',
        value: value,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuLastAuthAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'verifactuLastAuthAt',
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuLastAuthAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'verifactuLastAuthAt',
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuLastAuthAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verifactuLastAuthAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuLastAuthAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'verifactuLastAuthAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuLastAuthAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'verifactuLastAuthAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuLastAuthAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'verifactuLastAuthAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Config, Config, QAfterFilterCondition>
      verifactuRegisteredEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verifactuRegistered',
        value: value,
      ));
    });
  }
}

extension ConfigQueryObject on QueryBuilder<Config, Config, QFilterCondition> {}

extension ConfigQueryLinks on QueryBuilder<Config, Config, QFilterCondition> {}

extension ConfigQuerySortBy on QueryBuilder<Config, Config, QSortBy> {
  QueryBuilder<Config, Config, QAfterSortBy> sortByBusinessMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'businessMode', Sort.asc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortByBusinessModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'businessMode', Sort.desc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortByBusinessName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'businessName', Sort.asc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortByBusinessNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'businessName', Sort.desc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortByPrinterMacAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'printerMacAddress', Sort.asc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortByPrinterMacAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'printerMacAddress', Sort.desc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortByVerifactuClientHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifactuClientHash', Sort.asc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortByVerifactuClientHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifactuClientHash', Sort.desc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortByVerifactuClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifactuClientId', Sort.asc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortByVerifactuClientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifactuClientId', Sort.desc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortByVerifactuIsNewSystem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifactuIsNewSystem', Sort.asc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortByVerifactuIsNewSystemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifactuIsNewSystem', Sort.desc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortByVerifactuLastAuthAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifactuLastAuthAt', Sort.asc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortByVerifactuLastAuthAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifactuLastAuthAt', Sort.desc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortByVerifactuRegistered() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifactuRegistered', Sort.asc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> sortByVerifactuRegisteredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifactuRegistered', Sort.desc);
    });
  }
}

extension ConfigQuerySortThenBy on QueryBuilder<Config, Config, QSortThenBy> {
  QueryBuilder<Config, Config, QAfterSortBy> thenByBusinessMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'businessMode', Sort.asc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByBusinessModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'businessMode', Sort.desc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByBusinessName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'businessName', Sort.asc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByBusinessNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'businessName', Sort.desc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByPrinterMacAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'printerMacAddress', Sort.asc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByPrinterMacAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'printerMacAddress', Sort.desc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByVerifactuClientHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifactuClientHash', Sort.asc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByVerifactuClientHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifactuClientHash', Sort.desc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByVerifactuClientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifactuClientId', Sort.asc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByVerifactuClientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifactuClientId', Sort.desc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByVerifactuIsNewSystem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifactuIsNewSystem', Sort.asc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByVerifactuIsNewSystemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifactuIsNewSystem', Sort.desc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByVerifactuLastAuthAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifactuLastAuthAt', Sort.asc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByVerifactuLastAuthAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifactuLastAuthAt', Sort.desc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByVerifactuRegistered() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifactuRegistered', Sort.asc);
    });
  }

  QueryBuilder<Config, Config, QAfterSortBy> thenByVerifactuRegisteredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifactuRegistered', Sort.desc);
    });
  }
}

extension ConfigQueryWhereDistinct on QueryBuilder<Config, Config, QDistinct> {
  QueryBuilder<Config, Config, QDistinct> distinctByBusinessMode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'businessMode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Config, Config, QDistinct> distinctByBusinessName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'businessName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Config, Config, QDistinct> distinctByPrinterMacAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'printerMacAddress',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Config, Config, QDistinct> distinctByVerifactuClientHash(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'verifactuClientHash',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Config, Config, QDistinct> distinctByVerifactuClientId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'verifactuClientId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Config, Config, QDistinct> distinctByVerifactuIsNewSystem() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'verifactuIsNewSystem');
    });
  }

  QueryBuilder<Config, Config, QDistinct> distinctByVerifactuLastAuthAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'verifactuLastAuthAt');
    });
  }

  QueryBuilder<Config, Config, QDistinct> distinctByVerifactuRegistered() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'verifactuRegistered');
    });
  }
}

extension ConfigQueryProperty on QueryBuilder<Config, Config, QQueryProperty> {
  QueryBuilder<Config, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Config, String, QQueryOperations> businessModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'businessMode');
    });
  }

  QueryBuilder<Config, String, QQueryOperations> businessNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'businessName');
    });
  }

  QueryBuilder<Config, String?, QQueryOperations> printerMacAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'printerMacAddress');
    });
  }

  QueryBuilder<Config, String?, QQueryOperations>
      verifactuClientHashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'verifactuClientHash');
    });
  }

  QueryBuilder<Config, String?, QQueryOperations> verifactuClientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'verifactuClientId');
    });
  }

  QueryBuilder<Config, bool, QQueryOperations> verifactuIsNewSystemProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'verifactuIsNewSystem');
    });
  }

  QueryBuilder<Config, DateTime?, QQueryOperations>
      verifactuLastAuthAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'verifactuLastAuthAt');
    });
  }

  QueryBuilder<Config, bool, QQueryOperations> verifactuRegisteredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'verifactuRegistered');
    });
  }
}
