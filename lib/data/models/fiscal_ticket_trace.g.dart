// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fiscal_ticket_trace.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFiscalTicketTraceCollection on Isar {
  IsarCollection<FiscalTicketTrace> get fiscalTicketTraces => this.collection();
}

const FiscalTicketTraceSchema = CollectionSchema(
  name: r'FiscalTicketTrace',
  id: 8900912338573061564,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'invoiceId': PropertySchema(
      id: 1,
      name: r'invoiceId',
      type: IsarType.string,
    ),
    r'invoiceNumber': PropertySchema(
      id: 2,
      name: r'invoiceNumber',
      type: IsarType.long,
    ),
    r'invoiceSeries': PropertySchema(
      id: 3,
      name: r'invoiceSeries',
      type: IsarType.string,
    ),
    r'lines': PropertySchema(
      id: 4,
      name: r'lines',
      type: IsarType.objectList,
      target: r'FiscalTicketTraceLine',
    ),
    r'paymentMethod': PropertySchema(
      id: 5,
      name: r'paymentMethod',
      type: IsarType.string,
    ),
    r'ticketTableLabel': PropertySchema(
      id: 6,
      name: r'ticketTableLabel',
      type: IsarType.string,
    ),
    r'ticketTableNumber': PropertySchema(
      id: 7,
      name: r'ticketTableNumber',
      type: IsarType.long,
    ),
    r'ticketUuid': PropertySchema(
      id: 8,
      name: r'ticketUuid',
      type: IsarType.string,
    ),
    r'ticketZone': PropertySchema(
      id: 9,
      name: r'ticketZone',
      type: IsarType.string,
    ),
    r'totalAmount': PropertySchema(
      id: 10,
      name: r'totalAmount',
      type: IsarType.double,
    )
  },
  estimateSize: _fiscalTicketTraceEstimateSize,
  serialize: _fiscalTicketTraceSerialize,
  deserialize: _fiscalTicketTraceDeserialize,
  deserializeProp: _fiscalTicketTraceDeserializeProp,
  idName: r'id',
  indexes: {
    r'invoiceId': IndexSchema(
      id: 7861523084118270123,
      name: r'invoiceId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'invoiceId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'FiscalTicketTraceLine': FiscalTicketTraceLineSchema},
  getId: _fiscalTicketTraceGetId,
  getLinks: _fiscalTicketTraceGetLinks,
  attach: _fiscalTicketTraceAttach,
  version: '3.1.0+1',
);

int _fiscalTicketTraceEstimateSize(
  FiscalTicketTrace object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.invoiceId.length * 3;
  bytesCount += 3 + object.invoiceSeries.length * 3;
  bytesCount += 3 + object.lines.length * 3;
  {
    final offsets = allOffsets[FiscalTicketTraceLine]!;
    for (var i = 0; i < object.lines.length; i++) {
      final value = object.lines[i];
      bytesCount +=
          FiscalTicketTraceLineSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  {
    final value = object.paymentMethod;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.ticketTableLabel;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.ticketUuid;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.ticketZone;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _fiscalTicketTraceSerialize(
  FiscalTicketTrace object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.invoiceId);
  writer.writeLong(offsets[2], object.invoiceNumber);
  writer.writeString(offsets[3], object.invoiceSeries);
  writer.writeObjectList<FiscalTicketTraceLine>(
    offsets[4],
    allOffsets,
    FiscalTicketTraceLineSchema.serialize,
    object.lines,
  );
  writer.writeString(offsets[5], object.paymentMethod);
  writer.writeString(offsets[6], object.ticketTableLabel);
  writer.writeLong(offsets[7], object.ticketTableNumber);
  writer.writeString(offsets[8], object.ticketUuid);
  writer.writeString(offsets[9], object.ticketZone);
  writer.writeDouble(offsets[10], object.totalAmount);
}

FiscalTicketTrace _fiscalTicketTraceDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FiscalTicketTrace();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.id = id;
  object.invoiceId = reader.readString(offsets[1]);
  object.invoiceNumber = reader.readLong(offsets[2]);
  object.invoiceSeries = reader.readString(offsets[3]);
  object.lines = reader.readObjectList<FiscalTicketTraceLine>(
        offsets[4],
        FiscalTicketTraceLineSchema.deserialize,
        allOffsets,
        FiscalTicketTraceLine(),
      ) ??
      [];
  object.paymentMethod = reader.readStringOrNull(offsets[5]);
  object.ticketTableLabel = reader.readStringOrNull(offsets[6]);
  object.ticketTableNumber = reader.readLongOrNull(offsets[7]);
  object.ticketUuid = reader.readStringOrNull(offsets[8]);
  object.ticketZone = reader.readStringOrNull(offsets[9]);
  object.totalAmount = reader.readDouble(offsets[10]);
  return object;
}

P _fiscalTicketTraceDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readObjectList<FiscalTicketTraceLine>(
            offset,
            FiscalTicketTraceLineSchema.deserialize,
            allOffsets,
            FiscalTicketTraceLine(),
          ) ??
          []) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _fiscalTicketTraceGetId(FiscalTicketTrace object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _fiscalTicketTraceGetLinks(
    FiscalTicketTrace object) {
  return [];
}

void _fiscalTicketTraceAttach(
    IsarCollection<dynamic> col, Id id, FiscalTicketTrace object) {
  object.id = id;
}

extension FiscalTicketTraceByIndex on IsarCollection<FiscalTicketTrace> {
  Future<FiscalTicketTrace?> getByInvoiceId(String invoiceId) {
    return getByIndex(r'invoiceId', [invoiceId]);
  }

  FiscalTicketTrace? getByInvoiceIdSync(String invoiceId) {
    return getByIndexSync(r'invoiceId', [invoiceId]);
  }

  Future<bool> deleteByInvoiceId(String invoiceId) {
    return deleteByIndex(r'invoiceId', [invoiceId]);
  }

  bool deleteByInvoiceIdSync(String invoiceId) {
    return deleteByIndexSync(r'invoiceId', [invoiceId]);
  }

  Future<List<FiscalTicketTrace?>> getAllByInvoiceId(
      List<String> invoiceIdValues) {
    final values = invoiceIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'invoiceId', values);
  }

  List<FiscalTicketTrace?> getAllByInvoiceIdSync(List<String> invoiceIdValues) {
    final values = invoiceIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'invoiceId', values);
  }

  Future<int> deleteAllByInvoiceId(List<String> invoiceIdValues) {
    final values = invoiceIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'invoiceId', values);
  }

  int deleteAllByInvoiceIdSync(List<String> invoiceIdValues) {
    final values = invoiceIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'invoiceId', values);
  }

  Future<Id> putByInvoiceId(FiscalTicketTrace object) {
    return putByIndex(r'invoiceId', object);
  }

  Id putByInvoiceIdSync(FiscalTicketTrace object, {bool saveLinks = true}) {
    return putByIndexSync(r'invoiceId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByInvoiceId(List<FiscalTicketTrace> objects) {
    return putAllByIndex(r'invoiceId', objects);
  }

  List<Id> putAllByInvoiceIdSync(List<FiscalTicketTrace> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'invoiceId', objects, saveLinks: saveLinks);
  }
}

extension FiscalTicketTraceQueryWhereSort
    on QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QWhere> {
  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FiscalTicketTraceQueryWhere
    on QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QWhereClause> {
  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterWhereClause>
      idBetween(
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

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterWhereClause>
      invoiceIdEqualTo(String invoiceId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'invoiceId',
        value: [invoiceId],
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterWhereClause>
      invoiceIdNotEqualTo(String invoiceId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'invoiceId',
              lower: [],
              upper: [invoiceId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'invoiceId',
              lower: [invoiceId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'invoiceId',
              lower: [invoiceId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'invoiceId',
              lower: [],
              upper: [invoiceId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension FiscalTicketTraceQueryFilter
    on QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QFilterCondition> {
  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      invoiceIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invoiceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      invoiceIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'invoiceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      invoiceIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'invoiceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      invoiceIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'invoiceId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      invoiceIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'invoiceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      invoiceIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'invoiceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      invoiceIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'invoiceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      invoiceIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'invoiceId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      invoiceIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invoiceId',
        value: '',
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      invoiceIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'invoiceId',
        value: '',
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      invoiceNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invoiceNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      invoiceNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'invoiceNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      invoiceNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'invoiceNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      invoiceNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'invoiceNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      invoiceSeriesEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invoiceSeries',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      invoiceSeriesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'invoiceSeries',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      invoiceSeriesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'invoiceSeries',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      invoiceSeriesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'invoiceSeries',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      invoiceSeriesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'invoiceSeries',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      invoiceSeriesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'invoiceSeries',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      invoiceSeriesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'invoiceSeries',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      invoiceSeriesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'invoiceSeries',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      invoiceSeriesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invoiceSeries',
        value: '',
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      invoiceSeriesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'invoiceSeries',
        value: '',
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      linesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lines',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      linesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lines',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      linesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lines',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      linesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lines',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      linesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lines',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      linesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lines',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      paymentMethodIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'paymentMethod',
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      paymentMethodIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'paymentMethod',
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      paymentMethodEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      paymentMethodGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paymentMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      paymentMethodLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paymentMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      paymentMethodBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paymentMethod',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      paymentMethodStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'paymentMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      paymentMethodEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'paymentMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      paymentMethodContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'paymentMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      paymentMethodMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'paymentMethod',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      paymentMethodIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      paymentMethodIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'paymentMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketTableLabelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ticketTableLabel',
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketTableLabelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ticketTableLabel',
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketTableLabelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ticketTableLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketTableLabelGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ticketTableLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketTableLabelLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ticketTableLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketTableLabelBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ticketTableLabel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketTableLabelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ticketTableLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketTableLabelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ticketTableLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketTableLabelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ticketTableLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketTableLabelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ticketTableLabel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketTableLabelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ticketTableLabel',
        value: '',
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketTableLabelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ticketTableLabel',
        value: '',
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketTableNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ticketTableNumber',
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketTableNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ticketTableNumber',
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketTableNumberEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ticketTableNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketTableNumberGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ticketTableNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketTableNumberLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ticketTableNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketTableNumberBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ticketTableNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketUuidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ticketUuid',
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketUuidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ticketUuid',
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketUuidEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ticketUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketUuidGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ticketUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketUuidLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ticketUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketUuidBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ticketUuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketUuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ticketUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketUuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ticketUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketUuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ticketUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketUuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ticketUuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketUuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ticketUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketUuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ticketUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketZoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ticketZone',
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketZoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ticketZone',
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketZoneEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ticketZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketZoneGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ticketZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketZoneLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ticketZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketZoneBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ticketZone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketZoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ticketZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketZoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ticketZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketZoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ticketZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketZoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ticketZone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketZoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ticketZone',
        value: '',
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      ticketZoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ticketZone',
        value: '',
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      totalAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      totalAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      totalAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      totalAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension FiscalTicketTraceQueryObject
    on QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QFilterCondition> {
  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterFilterCondition>
      linesElement(FilterQuery<FiscalTicketTraceLine> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'lines');
    });
  }
}

extension FiscalTicketTraceQueryLinks
    on QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QFilterCondition> {}

extension FiscalTicketTraceQuerySortBy
    on QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QSortBy> {
  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      sortByInvoiceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceId', Sort.asc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      sortByInvoiceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceId', Sort.desc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      sortByInvoiceNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceNumber', Sort.asc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      sortByInvoiceNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceNumber', Sort.desc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      sortByInvoiceSeries() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceSeries', Sort.asc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      sortByInvoiceSeriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceSeries', Sort.desc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      sortByPaymentMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentMethod', Sort.asc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      sortByPaymentMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentMethod', Sort.desc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      sortByTicketTableLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ticketTableLabel', Sort.asc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      sortByTicketTableLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ticketTableLabel', Sort.desc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      sortByTicketTableNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ticketTableNumber', Sort.asc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      sortByTicketTableNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ticketTableNumber', Sort.desc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      sortByTicketUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ticketUuid', Sort.asc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      sortByTicketUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ticketUuid', Sort.desc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      sortByTicketZone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ticketZone', Sort.asc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      sortByTicketZoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ticketZone', Sort.desc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      sortByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.asc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      sortByTotalAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.desc);
    });
  }
}

extension FiscalTicketTraceQuerySortThenBy
    on QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QSortThenBy> {
  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      thenByInvoiceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceId', Sort.asc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      thenByInvoiceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceId', Sort.desc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      thenByInvoiceNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceNumber', Sort.asc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      thenByInvoiceNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceNumber', Sort.desc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      thenByInvoiceSeries() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceSeries', Sort.asc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      thenByInvoiceSeriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceSeries', Sort.desc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      thenByPaymentMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentMethod', Sort.asc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      thenByPaymentMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentMethod', Sort.desc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      thenByTicketTableLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ticketTableLabel', Sort.asc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      thenByTicketTableLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ticketTableLabel', Sort.desc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      thenByTicketTableNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ticketTableNumber', Sort.asc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      thenByTicketTableNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ticketTableNumber', Sort.desc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      thenByTicketUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ticketUuid', Sort.asc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      thenByTicketUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ticketUuid', Sort.desc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      thenByTicketZone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ticketZone', Sort.asc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      thenByTicketZoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ticketZone', Sort.desc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      thenByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.asc);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QAfterSortBy>
      thenByTotalAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.desc);
    });
  }
}

extension FiscalTicketTraceQueryWhereDistinct
    on QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QDistinct> {
  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QDistinct>
      distinctByInvoiceId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'invoiceId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QDistinct>
      distinctByInvoiceNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'invoiceNumber');
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QDistinct>
      distinctByInvoiceSeries({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'invoiceSeries',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QDistinct>
      distinctByPaymentMethod({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paymentMethod',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QDistinct>
      distinctByTicketTableLabel({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ticketTableLabel',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QDistinct>
      distinctByTicketTableNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ticketTableNumber');
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QDistinct>
      distinctByTicketUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ticketUuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QDistinct>
      distinctByTicketZone({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ticketZone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QDistinct>
      distinctByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalAmount');
    });
  }
}

extension FiscalTicketTraceQueryProperty
    on QueryBuilder<FiscalTicketTrace, FiscalTicketTrace, QQueryProperty> {
  QueryBuilder<FiscalTicketTrace, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FiscalTicketTrace, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<FiscalTicketTrace, String, QQueryOperations>
      invoiceIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'invoiceId');
    });
  }

  QueryBuilder<FiscalTicketTrace, int, QQueryOperations>
      invoiceNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'invoiceNumber');
    });
  }

  QueryBuilder<FiscalTicketTrace, String, QQueryOperations>
      invoiceSeriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'invoiceSeries');
    });
  }

  QueryBuilder<FiscalTicketTrace, List<FiscalTicketTraceLine>, QQueryOperations>
      linesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lines');
    });
  }

  QueryBuilder<FiscalTicketTrace, String?, QQueryOperations>
      paymentMethodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentMethod');
    });
  }

  QueryBuilder<FiscalTicketTrace, String?, QQueryOperations>
      ticketTableLabelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ticketTableLabel');
    });
  }

  QueryBuilder<FiscalTicketTrace, int?, QQueryOperations>
      ticketTableNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ticketTableNumber');
    });
  }

  QueryBuilder<FiscalTicketTrace, String?, QQueryOperations>
      ticketUuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ticketUuid');
    });
  }

  QueryBuilder<FiscalTicketTrace, String?, QQueryOperations>
      ticketZoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ticketZone');
    });
  }

  QueryBuilder<FiscalTicketTrace, double, QQueryOperations>
      totalAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalAmount');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const FiscalTicketTraceLineSchema = Schema(
  name: r'FiscalTicketTraceLine',
  id: -4377395017920027367,
  properties: {
    r'productName': PropertySchema(
      id: 0,
      name: r'productName',
      type: IsarType.string,
    ),
    r'quantity': PropertySchema(
      id: 1,
      name: r'quantity',
      type: IsarType.long,
    ),
    r'totalLine': PropertySchema(
      id: 2,
      name: r'totalLine',
      type: IsarType.double,
    ),
    r'unitPrice': PropertySchema(
      id: 3,
      name: r'unitPrice',
      type: IsarType.double,
    )
  },
  estimateSize: _fiscalTicketTraceLineEstimateSize,
  serialize: _fiscalTicketTraceLineSerialize,
  deserialize: _fiscalTicketTraceLineDeserialize,
  deserializeProp: _fiscalTicketTraceLineDeserializeProp,
);

int _fiscalTicketTraceLineEstimateSize(
  FiscalTicketTraceLine object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.productName.length * 3;
  return bytesCount;
}

void _fiscalTicketTraceLineSerialize(
  FiscalTicketTraceLine object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.productName);
  writer.writeLong(offsets[1], object.quantity);
  writer.writeDouble(offsets[2], object.totalLine);
  writer.writeDouble(offsets[3], object.unitPrice);
}

FiscalTicketTraceLine _fiscalTicketTraceLineDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FiscalTicketTraceLine();
  object.productName = reader.readString(offsets[0]);
  object.quantity = reader.readLong(offsets[1]);
  object.totalLine = reader.readDouble(offsets[2]);
  object.unitPrice = reader.readDouble(offsets[3]);
  return object;
}

P _fiscalTicketTraceLineDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension FiscalTicketTraceLineQueryFilter on QueryBuilder<
    FiscalTicketTraceLine, FiscalTicketTraceLine, QFilterCondition> {
  QueryBuilder<FiscalTicketTraceLine, FiscalTicketTraceLine,
      QAfterFilterCondition> productNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTraceLine, FiscalTicketTraceLine,
      QAfterFilterCondition> productNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTraceLine, FiscalTicketTraceLine,
      QAfterFilterCondition> productNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTraceLine, FiscalTicketTraceLine,
      QAfterFilterCondition> productNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'productName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTraceLine, FiscalTicketTraceLine,
      QAfterFilterCondition> productNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTraceLine, FiscalTicketTraceLine,
      QAfterFilterCondition> productNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTraceLine, FiscalTicketTraceLine,
          QAfterFilterCondition>
      productNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTraceLine, FiscalTicketTraceLine,
          QAfterFilterCondition>
      productNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'productName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FiscalTicketTraceLine, FiscalTicketTraceLine,
      QAfterFilterCondition> productNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productName',
        value: '',
      ));
    });
  }

  QueryBuilder<FiscalTicketTraceLine, FiscalTicketTraceLine,
      QAfterFilterCondition> productNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'productName',
        value: '',
      ));
    });
  }

  QueryBuilder<FiscalTicketTraceLine, FiscalTicketTraceLine,
      QAfterFilterCondition> quantityEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<FiscalTicketTraceLine, FiscalTicketTraceLine,
      QAfterFilterCondition> quantityGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<FiscalTicketTraceLine, FiscalTicketTraceLine,
      QAfterFilterCondition> quantityLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<FiscalTicketTraceLine, FiscalTicketTraceLine,
      QAfterFilterCondition> quantityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FiscalTicketTraceLine, FiscalTicketTraceLine,
      QAfterFilterCondition> totalLineEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalLine',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FiscalTicketTraceLine, FiscalTicketTraceLine,
      QAfterFilterCondition> totalLineGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalLine',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FiscalTicketTraceLine, FiscalTicketTraceLine,
      QAfterFilterCondition> totalLineLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalLine',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FiscalTicketTraceLine, FiscalTicketTraceLine,
      QAfterFilterCondition> totalLineBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalLine',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FiscalTicketTraceLine, FiscalTicketTraceLine,
      QAfterFilterCondition> unitPriceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unitPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FiscalTicketTraceLine, FiscalTicketTraceLine,
      QAfterFilterCondition> unitPriceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unitPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FiscalTicketTraceLine, FiscalTicketTraceLine,
      QAfterFilterCondition> unitPriceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unitPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FiscalTicketTraceLine, FiscalTicketTraceLine,
      QAfterFilterCondition> unitPriceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unitPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension FiscalTicketTraceLineQueryObject on QueryBuilder<
    FiscalTicketTraceLine, FiscalTicketTraceLine, QFilterCondition> {}
