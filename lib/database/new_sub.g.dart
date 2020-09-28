// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_sub.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Sub extends DataClass implements Insertable<Sub> {
  final int id;
  final String subsName;
  final double subsPrice;
  final String notes;
  final String payStatus;
  final String payMethod;
  final DateTime payDate;
  final String periodNo;
  final String periodType;
  final String category;
  final String archive;
  final String currency;
  final DateTime createdAt;
  Sub(
      {@required this.id,
      @required this.subsName,
      @required this.subsPrice,
      this.notes,
      @required this.payStatus,
      this.payMethod,
      @required this.payDate,
      @required this.periodNo,
      @required this.periodType,
      this.category,
      @required this.archive,
      @required this.currency,
      this.createdAt});
  factory Sub.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Sub(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      subsName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}subs_name']),
      subsPrice: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}subs_price']),
      notes:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}notes']),
      payStatus: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}pay_status']),
      payMethod: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}pay_method']),
      payDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}pay_date']),
      periodNo: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}period_no']),
      periodType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}period_type']),
      category: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}category']),
      archive:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}archive']),
      currency: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}currency']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || subsName != null) {
      map['subs_name'] = Variable<String>(subsName);
    }
    if (!nullToAbsent || subsPrice != null) {
      map['subs_price'] = Variable<double>(subsPrice);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || payStatus != null) {
      map['pay_status'] = Variable<String>(payStatus);
    }
    if (!nullToAbsent || payMethod != null) {
      map['pay_method'] = Variable<String>(payMethod);
    }
    if (!nullToAbsent || payDate != null) {
      map['pay_date'] = Variable<DateTime>(payDate);
    }
    if (!nullToAbsent || periodNo != null) {
      map['period_no'] = Variable<String>(periodNo);
    }
    if (!nullToAbsent || periodType != null) {
      map['period_type'] = Variable<String>(periodType);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || archive != null) {
      map['archive'] = Variable<String>(archive);
    }
    if (!nullToAbsent || currency != null) {
      map['currency'] = Variable<String>(currency);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  SubsCompanion toCompanion(bool nullToAbsent) {
    return SubsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      subsName: subsName == null && nullToAbsent
          ? const Value.absent()
          : Value(subsName),
      subsPrice: subsPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(subsPrice),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      payStatus: payStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(payStatus),
      payMethod: payMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(payMethod),
      payDate: payDate == null && nullToAbsent
          ? const Value.absent()
          : Value(payDate),
      periodNo: periodNo == null && nullToAbsent
          ? const Value.absent()
          : Value(periodNo),
      periodType: periodType == null && nullToAbsent
          ? const Value.absent()
          : Value(periodType),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      archive: archive == null && nullToAbsent
          ? const Value.absent()
          : Value(archive),
      currency: currency == null && nullToAbsent
          ? const Value.absent()
          : Value(currency),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory Sub.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Sub(
      id: serializer.fromJson<int>(json['id']),
      subsName: serializer.fromJson<String>(json['subsName']),
      subsPrice: serializer.fromJson<double>(json['subsPrice']),
      notes: serializer.fromJson<String>(json['notes']),
      payStatus: serializer.fromJson<String>(json['payStatus']),
      payMethod: serializer.fromJson<String>(json['payMethod']),
      payDate: serializer.fromJson<DateTime>(json['payDate']),
      periodNo: serializer.fromJson<String>(json['periodNo']),
      periodType: serializer.fromJson<String>(json['periodType']),
      category: serializer.fromJson<String>(json['category']),
      archive: serializer.fromJson<String>(json['archive']),
      currency: serializer.fromJson<String>(json['currency']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'subsName': serializer.toJson<String>(subsName),
      'subsPrice': serializer.toJson<double>(subsPrice),
      'notes': serializer.toJson<String>(notes),
      'payStatus': serializer.toJson<String>(payStatus),
      'payMethod': serializer.toJson<String>(payMethod),
      'payDate': serializer.toJson<DateTime>(payDate),
      'periodNo': serializer.toJson<String>(periodNo),
      'periodType': serializer.toJson<String>(periodType),
      'category': serializer.toJson<String>(category),
      'archive': serializer.toJson<String>(archive),
      'currency': serializer.toJson<String>(currency),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Sub copyWith(
          {int id,
          String subsName,
          double subsPrice,
          String notes,
          String payStatus,
          String payMethod,
          DateTime payDate,
          String periodNo,
          String periodType,
          String category,
          String archive,
          String currency,
          DateTime createdAt}) =>
      Sub(
        id: id ?? this.id,
        subsName: subsName ?? this.subsName,
        subsPrice: subsPrice ?? this.subsPrice,
        notes: notes ?? this.notes,
        payStatus: payStatus ?? this.payStatus,
        payMethod: payMethod ?? this.payMethod,
        payDate: payDate ?? this.payDate,
        periodNo: periodNo ?? this.periodNo,
        periodType: periodType ?? this.periodType,
        category: category ?? this.category,
        archive: archive ?? this.archive,
        currency: currency ?? this.currency,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('Sub(')
          ..write('id: $id, ')
          ..write('subsName: $subsName, ')
          ..write('subsPrice: $subsPrice, ')
          ..write('notes: $notes, ')
          ..write('payStatus: $payStatus, ')
          ..write('payMethod: $payMethod, ')
          ..write('payDate: $payDate, ')
          ..write('periodNo: $periodNo, ')
          ..write('periodType: $periodType, ')
          ..write('category: $category, ')
          ..write('archive: $archive, ')
          ..write('currency: $currency, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          subsName.hashCode,
          $mrjc(
              subsPrice.hashCode,
              $mrjc(
                  notes.hashCode,
                  $mrjc(
                      payStatus.hashCode,
                      $mrjc(
                          payMethod.hashCode,
                          $mrjc(
                              payDate.hashCode,
                              $mrjc(
                                  periodNo.hashCode,
                                  $mrjc(
                                      periodType.hashCode,
                                      $mrjc(
                                          category.hashCode,
                                          $mrjc(
                                              archive.hashCode,
                                              $mrjc(
                                                  currency.hashCode,
                                                  createdAt
                                                      .hashCode)))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Sub &&
          other.id == this.id &&
          other.subsName == this.subsName &&
          other.subsPrice == this.subsPrice &&
          other.notes == this.notes &&
          other.payStatus == this.payStatus &&
          other.payMethod == this.payMethod &&
          other.payDate == this.payDate &&
          other.periodNo == this.periodNo &&
          other.periodType == this.periodType &&
          other.category == this.category &&
          other.archive == this.archive &&
          other.currency == this.currency &&
          other.createdAt == this.createdAt);
}

class SubsCompanion extends UpdateCompanion<Sub> {
  final Value<int> id;
  final Value<String> subsName;
  final Value<double> subsPrice;
  final Value<String> notes;
  final Value<String> payStatus;
  final Value<String> payMethod;
  final Value<DateTime> payDate;
  final Value<String> periodNo;
  final Value<String> periodType;
  final Value<String> category;
  final Value<String> archive;
  final Value<String> currency;
  final Value<DateTime> createdAt;
  const SubsCompanion({
    this.id = const Value.absent(),
    this.subsName = const Value.absent(),
    this.subsPrice = const Value.absent(),
    this.notes = const Value.absent(),
    this.payStatus = const Value.absent(),
    this.payMethod = const Value.absent(),
    this.payDate = const Value.absent(),
    this.periodNo = const Value.absent(),
    this.periodType = const Value.absent(),
    this.category = const Value.absent(),
    this.archive = const Value.absent(),
    this.currency = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SubsCompanion.insert({
    this.id = const Value.absent(),
    @required String subsName,
    @required double subsPrice,
    this.notes = const Value.absent(),
    @required String payStatus,
    this.payMethod = const Value.absent(),
    @required DateTime payDate,
    @required String periodNo,
    @required String periodType,
    this.category = const Value.absent(),
    @required String archive,
    @required String currency,
    this.createdAt = const Value.absent(),
  })  : subsName = Value(subsName),
        subsPrice = Value(subsPrice),
        payStatus = Value(payStatus),
        payDate = Value(payDate),
        periodNo = Value(periodNo),
        periodType = Value(periodType),
        archive = Value(archive),
        currency = Value(currency);
  static Insertable<Sub> custom({
    Expression<int> id,
    Expression<String> subsName,
    Expression<double> subsPrice,
    Expression<String> notes,
    Expression<String> payStatus,
    Expression<String> payMethod,
    Expression<DateTime> payDate,
    Expression<String> periodNo,
    Expression<String> periodType,
    Expression<String> category,
    Expression<String> archive,
    Expression<String> currency,
    Expression<DateTime> createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subsName != null) 'subs_name': subsName,
      if (subsPrice != null) 'subs_price': subsPrice,
      if (notes != null) 'notes': notes,
      if (payStatus != null) 'pay_status': payStatus,
      if (payMethod != null) 'pay_method': payMethod,
      if (payDate != null) 'pay_date': payDate,
      if (periodNo != null) 'period_no': periodNo,
      if (periodType != null) 'period_type': periodType,
      if (category != null) 'category': category,
      if (archive != null) 'archive': archive,
      if (currency != null) 'currency': currency,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SubsCompanion copyWith(
      {Value<int> id,
      Value<String> subsName,
      Value<double> subsPrice,
      Value<String> notes,
      Value<String> payStatus,
      Value<String> payMethod,
      Value<DateTime> payDate,
      Value<String> periodNo,
      Value<String> periodType,
      Value<String> category,
      Value<String> archive,
      Value<String> currency,
      Value<DateTime> createdAt}) {
    return SubsCompanion(
      id: id ?? this.id,
      subsName: subsName ?? this.subsName,
      subsPrice: subsPrice ?? this.subsPrice,
      notes: notes ?? this.notes,
      payStatus: payStatus ?? this.payStatus,
      payMethod: payMethod ?? this.payMethod,
      payDate: payDate ?? this.payDate,
      periodNo: periodNo ?? this.periodNo,
      periodType: periodType ?? this.periodType,
      category: category ?? this.category,
      archive: archive ?? this.archive,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (subsName.present) {
      map['subs_name'] = Variable<String>(subsName.value);
    }
    if (subsPrice.present) {
      map['subs_price'] = Variable<double>(subsPrice.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (payStatus.present) {
      map['pay_status'] = Variable<String>(payStatus.value);
    }
    if (payMethod.present) {
      map['pay_method'] = Variable<String>(payMethod.value);
    }
    if (payDate.present) {
      map['pay_date'] = Variable<DateTime>(payDate.value);
    }
    if (periodNo.present) {
      map['period_no'] = Variable<String>(periodNo.value);
    }
    if (periodType.present) {
      map['period_type'] = Variable<String>(periodType.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (archive.present) {
      map['archive'] = Variable<String>(archive.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubsCompanion(')
          ..write('id: $id, ')
          ..write('subsName: $subsName, ')
          ..write('subsPrice: $subsPrice, ')
          ..write('notes: $notes, ')
          ..write('payStatus: $payStatus, ')
          ..write('payMethod: $payMethod, ')
          ..write('payDate: $payDate, ')
          ..write('periodNo: $periodNo, ')
          ..write('periodType: $periodType, ')
          ..write('category: $category, ')
          ..write('archive: $archive, ')
          ..write('currency: $currency, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SubsTable extends Subs with TableInfo<$SubsTable, Sub> {
  final GeneratedDatabase _db;
  final String _alias;
  $SubsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _subsNameMeta = const VerificationMeta('subsName');
  GeneratedTextColumn _subsName;
  @override
  GeneratedTextColumn get subsName => _subsName ??= _constructSubsName();
  GeneratedTextColumn _constructSubsName() {
    return GeneratedTextColumn('subs_name', $tableName, false,
        minTextLength: 1, maxTextLength: 30);
  }

  final VerificationMeta _subsPriceMeta = const VerificationMeta('subsPrice');
  GeneratedRealColumn _subsPrice;
  @override
  GeneratedRealColumn get subsPrice => _subsPrice ??= _constructSubsPrice();
  GeneratedRealColumn _constructSubsPrice() {
    return GeneratedRealColumn(
      'subs_price',
      $tableName,
      false,
    );
  }

  final VerificationMeta _notesMeta = const VerificationMeta('notes');
  GeneratedTextColumn _notes;
  @override
  GeneratedTextColumn get notes => _notes ??= _constructNotes();
  GeneratedTextColumn _constructNotes() {
    return GeneratedTextColumn('notes', $tableName, true, maxTextLength: 100);
  }

  final VerificationMeta _payStatusMeta = const VerificationMeta('payStatus');
  GeneratedTextColumn _payStatus;
  @override
  GeneratedTextColumn get payStatus => _payStatus ??= _constructPayStatus();
  GeneratedTextColumn _constructPayStatus() {
    return GeneratedTextColumn(
      'pay_status',
      $tableName,
      false,
    );
  }

  final VerificationMeta _payMethodMeta = const VerificationMeta('payMethod');
  GeneratedTextColumn _payMethod;
  @override
  GeneratedTextColumn get payMethod => _payMethod ??= _constructPayMethod();
  GeneratedTextColumn _constructPayMethod() {
    return GeneratedTextColumn(
      'pay_method',
      $tableName,
      true,
    );
  }

  final VerificationMeta _payDateMeta = const VerificationMeta('payDate');
  GeneratedDateTimeColumn _payDate;
  @override
  GeneratedDateTimeColumn get payDate => _payDate ??= _constructPayDate();
  GeneratedDateTimeColumn _constructPayDate() {
    return GeneratedDateTimeColumn(
      'pay_date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _periodNoMeta = const VerificationMeta('periodNo');
  GeneratedTextColumn _periodNo;
  @override
  GeneratedTextColumn get periodNo => _periodNo ??= _constructPeriodNo();
  GeneratedTextColumn _constructPeriodNo() {
    return GeneratedTextColumn(
      'period_no',
      $tableName,
      false,
    );
  }

  final VerificationMeta _periodTypeMeta = const VerificationMeta('periodType');
  GeneratedTextColumn _periodType;
  @override
  GeneratedTextColumn get periodType => _periodType ??= _constructPeriodType();
  GeneratedTextColumn _constructPeriodType() {
    return GeneratedTextColumn(
      'period_type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  GeneratedTextColumn _category;
  @override
  GeneratedTextColumn get category => _category ??= _constructCategory();
  GeneratedTextColumn _constructCategory() {
    return GeneratedTextColumn(
      'category',
      $tableName,
      true,
    );
  }

  final VerificationMeta _archiveMeta = const VerificationMeta('archive');
  GeneratedTextColumn _archive;
  @override
  GeneratedTextColumn get archive => _archive ??= _constructArchive();
  GeneratedTextColumn _constructArchive() {
    return GeneratedTextColumn(
      'archive',
      $tableName,
      false,
    );
  }

  final VerificationMeta _currencyMeta = const VerificationMeta('currency');
  GeneratedTextColumn _currency;
  @override
  GeneratedTextColumn get currency => _currency ??= _constructCurrency();
  GeneratedTextColumn _constructCurrency() {
    return GeneratedTextColumn(
      'currency',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        subsName,
        subsPrice,
        notes,
        payStatus,
        payMethod,
        payDate,
        periodNo,
        periodType,
        category,
        archive,
        currency,
        createdAt
      ];
  @override
  $SubsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'subs';
  @override
  final String actualTableName = 'subs';
  @override
  VerificationContext validateIntegrity(Insertable<Sub> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('subs_name')) {
      context.handle(_subsNameMeta,
          subsName.isAcceptableOrUnknown(data['subs_name'], _subsNameMeta));
    } else if (isInserting) {
      context.missing(_subsNameMeta);
    }
    if (data.containsKey('subs_price')) {
      context.handle(_subsPriceMeta,
          subsPrice.isAcceptableOrUnknown(data['subs_price'], _subsPriceMeta));
    } else if (isInserting) {
      context.missing(_subsPriceMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes'], _notesMeta));
    }
    if (data.containsKey('pay_status')) {
      context.handle(_payStatusMeta,
          payStatus.isAcceptableOrUnknown(data['pay_status'], _payStatusMeta));
    } else if (isInserting) {
      context.missing(_payStatusMeta);
    }
    if (data.containsKey('pay_method')) {
      context.handle(_payMethodMeta,
          payMethod.isAcceptableOrUnknown(data['pay_method'], _payMethodMeta));
    }
    if (data.containsKey('pay_date')) {
      context.handle(_payDateMeta,
          payDate.isAcceptableOrUnknown(data['pay_date'], _payDateMeta));
    } else if (isInserting) {
      context.missing(_payDateMeta);
    }
    if (data.containsKey('period_no')) {
      context.handle(_periodNoMeta,
          periodNo.isAcceptableOrUnknown(data['period_no'], _periodNoMeta));
    } else if (isInserting) {
      context.missing(_periodNoMeta);
    }
    if (data.containsKey('period_type')) {
      context.handle(
          _periodTypeMeta,
          periodType.isAcceptableOrUnknown(
              data['period_type'], _periodTypeMeta));
    } else if (isInserting) {
      context.missing(_periodTypeMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category'], _categoryMeta));
    }
    if (data.containsKey('archive')) {
      context.handle(_archiveMeta,
          archive.isAcceptableOrUnknown(data['archive'], _archiveMeta));
    } else if (isInserting) {
      context.missing(_archiveMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency'], _currencyMeta));
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sub map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Sub.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $SubsTable createAlias(String alias) {
    return $SubsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $SubsTable _subs;
  $SubsTable get subs => _subs ??= $SubsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [subs];
}
