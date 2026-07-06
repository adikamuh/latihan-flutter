// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_entity_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAuthEntityIsarCollection on Isar {
  IsarCollection<AuthEntityIsar> get authEntityIsars => this.collection();
}

const AuthEntityIsarSchema = CollectionSchema(
  name: r'AuthEntityIsar',
  id: 775454707166676372,
  properties: {
    r'accessToken': PropertySchema(
      id: 0,
      name: r'accessToken',
      type: IsarType.string,
    ),
    r'code': PropertySchema(id: 1, name: r'code', type: IsarType.string),
    r'expiredAt': PropertySchema(
      id: 2,
      name: r'expiredAt',
      type: IsarType.dateTime,
    ),
    r'login': PropertySchema(id: 3, name: r'login', type: IsarType.string),
  },

  estimateSize: _authEntityIsarEstimateSize,
  serialize: _authEntityIsarSerialize,
  deserialize: _authEntityIsarDeserialize,
  deserializeProp: _authEntityIsarDeserializeProp,
  idName: r'idIsar',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _authEntityIsarGetId,
  getLinks: _authEntityIsarGetLinks,
  attach: _authEntityIsarAttach,
  version: '3.3.2',
);

int _authEntityIsarEstimateSize(
  AuthEntityIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.accessToken;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.code;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.login;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _authEntityIsarSerialize(
  AuthEntityIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.accessToken);
  writer.writeString(offsets[1], object.code);
  writer.writeDateTime(offsets[2], object.expiredAt);
  writer.writeString(offsets[3], object.login);
}

AuthEntityIsar _authEntityIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AuthEntityIsar(
    accessToken: reader.readStringOrNull(offsets[0]),
    code: reader.readStringOrNull(offsets[1]),
    expiredAt: reader.readDateTimeOrNull(offsets[2]),
    idIsar: id,
    login: reader.readStringOrNull(offsets[3]),
  );
  return object;
}

P _authEntityIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _authEntityIsarGetId(AuthEntityIsar object) {
  return object.idIsar;
}

List<IsarLinkBase<dynamic>> _authEntityIsarGetLinks(AuthEntityIsar object) {
  return [];
}

void _authEntityIsarAttach(
  IsarCollection<dynamic> col,
  Id id,
  AuthEntityIsar object,
) {}

extension AuthEntityIsarQueryWhereSort
    on QueryBuilder<AuthEntityIsar, AuthEntityIsar, QWhere> {
  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterWhere> anyIdIsar() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AuthEntityIsarQueryWhere
    on QueryBuilder<AuthEntityIsar, AuthEntityIsar, QWhereClause> {
  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterWhereClause> idIsarEqualTo(
    Id idIsar,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: idIsar, upper: idIsar),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterWhereClause>
  idIsarNotEqualTo(Id idIsar) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: idIsar, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: idIsar, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: idIsar, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: idIsar, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterWhereClause>
  idIsarGreaterThan(Id idIsar, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: idIsar, includeLower: include),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterWhereClause>
  idIsarLessThan(Id idIsar, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: idIsar, includeUpper: include),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterWhereClause> idIsarBetween(
    Id lowerIdIsar,
    Id upperIdIsar, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerIdIsar,
          includeLower: includeLower,
          upper: upperIdIsar,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension AuthEntityIsarQueryFilter
    on QueryBuilder<AuthEntityIsar, AuthEntityIsar, QFilterCondition> {
  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  accessTokenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'accessToken'),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  accessTokenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'accessToken'),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  accessTokenEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'accessToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  accessTokenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'accessToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  accessTokenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'accessToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  accessTokenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'accessToken',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  accessTokenStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'accessToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  accessTokenEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'accessToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  accessTokenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'accessToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  accessTokenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'accessToken',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  accessTokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'accessToken', value: ''),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  accessTokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'accessToken', value: ''),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  codeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'code'),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  codeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'code'),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  codeEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'code',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  codeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'code',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  codeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'code',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  codeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'code',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  codeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'code',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  codeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'code',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  codeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'code',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  codeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'code',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  codeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'code', value: ''),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  codeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'code', value: ''),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  expiredAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'expiredAt'),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  expiredAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'expiredAt'),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  expiredAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'expiredAt', value: value),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  expiredAtGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'expiredAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  expiredAtLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'expiredAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  expiredAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'expiredAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  idIsarEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'idIsar', value: value),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  idIsarGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'idIsar',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  idIsarLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'idIsar',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  idIsarBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'idIsar',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  loginIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'login'),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  loginIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'login'),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  loginEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'login',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  loginGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'login',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  loginLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'login',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  loginBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'login',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  loginStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'login',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  loginEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'login',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  loginContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'login',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  loginMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'login',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  loginIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'login', value: ''),
      );
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterFilterCondition>
  loginIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'login', value: ''),
      );
    });
  }
}

extension AuthEntityIsarQueryObject
    on QueryBuilder<AuthEntityIsar, AuthEntityIsar, QFilterCondition> {}

extension AuthEntityIsarQueryLinks
    on QueryBuilder<AuthEntityIsar, AuthEntityIsar, QFilterCondition> {}

extension AuthEntityIsarQuerySortBy
    on QueryBuilder<AuthEntityIsar, AuthEntityIsar, QSortBy> {
  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterSortBy>
  sortByAccessToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accessToken', Sort.asc);
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterSortBy>
  sortByAccessTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accessToken', Sort.desc);
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterSortBy> sortByCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.asc);
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterSortBy> sortByCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.desc);
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterSortBy> sortByExpiredAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiredAt', Sort.asc);
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterSortBy>
  sortByExpiredAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiredAt', Sort.desc);
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterSortBy> sortByLogin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'login', Sort.asc);
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterSortBy> sortByLoginDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'login', Sort.desc);
    });
  }
}

extension AuthEntityIsarQuerySortThenBy
    on QueryBuilder<AuthEntityIsar, AuthEntityIsar, QSortThenBy> {
  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterSortBy>
  thenByAccessToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accessToken', Sort.asc);
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterSortBy>
  thenByAccessTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accessToken', Sort.desc);
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterSortBy> thenByCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.asc);
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterSortBy> thenByCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.desc);
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterSortBy> thenByExpiredAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiredAt', Sort.asc);
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterSortBy>
  thenByExpiredAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiredAt', Sort.desc);
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterSortBy> thenByIdIsar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idIsar', Sort.asc);
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterSortBy>
  thenByIdIsarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idIsar', Sort.desc);
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterSortBy> thenByLogin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'login', Sort.asc);
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QAfterSortBy> thenByLoginDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'login', Sort.desc);
    });
  }
}

extension AuthEntityIsarQueryWhereDistinct
    on QueryBuilder<AuthEntityIsar, AuthEntityIsar, QDistinct> {
  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QDistinct>
  distinctByAccessToken({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accessToken', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QDistinct> distinctByCode({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'code', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QDistinct>
  distinctByExpiredAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expiredAt');
    });
  }

  QueryBuilder<AuthEntityIsar, AuthEntityIsar, QDistinct> distinctByLogin({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'login', caseSensitive: caseSensitive);
    });
  }
}

extension AuthEntityIsarQueryProperty
    on QueryBuilder<AuthEntityIsar, AuthEntityIsar, QQueryProperty> {
  QueryBuilder<AuthEntityIsar, int, QQueryOperations> idIsarProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idIsar');
    });
  }

  QueryBuilder<AuthEntityIsar, String?, QQueryOperations>
  accessTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accessToken');
    });
  }

  QueryBuilder<AuthEntityIsar, String?, QQueryOperations> codeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'code');
    });
  }

  QueryBuilder<AuthEntityIsar, DateTime?, QQueryOperations>
  expiredAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expiredAt');
    });
  }

  QueryBuilder<AuthEntityIsar, String?, QQueryOperations> loginProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'login');
    });
  }
}
