// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leagues_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LeaguesResponse _$LeaguesResponseFromJson(Map<String, dynamic> json) {
  return _LeaguesResponse.fromJson(json);
}

/// @nodoc
mixin _$LeaguesResponse {
  String get get => throw _privateConstructorUsedError;
  Parameters get parameters => throw _privateConstructorUsedError;
  List<dynamic> get errors => throw _privateConstructorUsedError;
  int get results => throw _privateConstructorUsedError;
  Paging get paging => throw _privateConstructorUsedError;
  List<LeagueData> get response => throw _privateConstructorUsedError;

  /// Serializes this LeaguesResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaguesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaguesResponseCopyWith<LeaguesResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaguesResponseCopyWith<$Res> {
  factory $LeaguesResponseCopyWith(
          LeaguesResponse value, $Res Function(LeaguesResponse) then) =
      _$LeaguesResponseCopyWithImpl<$Res, LeaguesResponse>;
  @useResult
  $Res call(
      {String get,
      Parameters parameters,
      List<dynamic> errors,
      int results,
      Paging paging,
      List<LeagueData> response});

  $ParametersCopyWith<$Res> get parameters;
  $PagingCopyWith<$Res> get paging;
}

/// @nodoc
class _$LeaguesResponseCopyWithImpl<$Res, $Val extends LeaguesResponse>
    implements $LeaguesResponseCopyWith<$Res> {
  _$LeaguesResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaguesResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? get = null,
    Object? parameters = null,
    Object? errors = null,
    Object? results = null,
    Object? paging = null,
    Object? response = null,
  }) {
    return _then(_value.copyWith(
      get: null == get
          ? _value.get
          : get // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: null == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Parameters,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as int,
      paging: null == paging
          ? _value.paging
          : paging // ignore: cast_nullable_to_non_nullable
              as Paging,
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as List<LeagueData>,
    ) as $Val);
  }

  /// Create a copy of LeaguesResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ParametersCopyWith<$Res> get parameters {
    return $ParametersCopyWith<$Res>(_value.parameters, (value) {
      return _then(_value.copyWith(parameters: value) as $Val);
    });
  }

  /// Create a copy of LeaguesResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PagingCopyWith<$Res> get paging {
    return $PagingCopyWith<$Res>(_value.paging, (value) {
      return _then(_value.copyWith(paging: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LeaguesResponseImplCopyWith<$Res>
    implements $LeaguesResponseCopyWith<$Res> {
  factory _$$LeaguesResponseImplCopyWith(_$LeaguesResponseImpl value,
          $Res Function(_$LeaguesResponseImpl) then) =
      __$$LeaguesResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String get,
      Parameters parameters,
      List<dynamic> errors,
      int results,
      Paging paging,
      List<LeagueData> response});

  @override
  $ParametersCopyWith<$Res> get parameters;
  @override
  $PagingCopyWith<$Res> get paging;
}

/// @nodoc
class __$$LeaguesResponseImplCopyWithImpl<$Res>
    extends _$LeaguesResponseCopyWithImpl<$Res, _$LeaguesResponseImpl>
    implements _$$LeaguesResponseImplCopyWith<$Res> {
  __$$LeaguesResponseImplCopyWithImpl(
      _$LeaguesResponseImpl _value, $Res Function(_$LeaguesResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeaguesResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? get = null,
    Object? parameters = null,
    Object? errors = null,
    Object? results = null,
    Object? paging = null,
    Object? response = null,
  }) {
    return _then(_$LeaguesResponseImpl(
      get: null == get
          ? _value.get
          : get // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: null == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Parameters,
      errors: null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as int,
      paging: null == paging
          ? _value.paging
          : paging // ignore: cast_nullable_to_non_nullable
              as Paging,
      response: null == response
          ? _value._response
          : response // ignore: cast_nullable_to_non_nullable
              as List<LeagueData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaguesResponseImpl implements _LeaguesResponse {
  const _$LeaguesResponseImpl(
      {required this.get,
      required this.parameters,
      required final List<dynamic> errors,
      required this.results,
      required this.paging,
      required final List<LeagueData> response})
      : _errors = errors,
        _response = response;

  factory _$LeaguesResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaguesResponseImplFromJson(json);

  @override
  final String get;
  @override
  final Parameters parameters;
  final List<dynamic> _errors;
  @override
  List<dynamic> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  @override
  final int results;
  @override
  final Paging paging;
  final List<LeagueData> _response;
  @override
  List<LeagueData> get response {
    if (_response is EqualUnmodifiableListView) return _response;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_response);
  }

  @override
  String toString() {
    return 'LeaguesResponse(get: $get, parameters: $parameters, errors: $errors, results: $results, paging: $paging, response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaguesResponseImpl &&
            (identical(other.get, get) || other.get == get) &&
            (identical(other.parameters, parameters) ||
                other.parameters == parameters) &&
            const DeepCollectionEquality().equals(other._errors, _errors) &&
            (identical(other.results, results) || other.results == results) &&
            (identical(other.paging, paging) || other.paging == paging) &&
            const DeepCollectionEquality().equals(other._response, _response));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      get,
      parameters,
      const DeepCollectionEquality().hash(_errors),
      results,
      paging,
      const DeepCollectionEquality().hash(_response));

  /// Create a copy of LeaguesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaguesResponseImplCopyWith<_$LeaguesResponseImpl> get copyWith =>
      __$$LeaguesResponseImplCopyWithImpl<_$LeaguesResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaguesResponseImplToJson(
      this,
    );
  }
}

abstract class _LeaguesResponse implements LeaguesResponse {
  const factory _LeaguesResponse(
      {required final String get,
      required final Parameters parameters,
      required final List<dynamic> errors,
      required final int results,
      required final Paging paging,
      required final List<LeagueData> response}) = _$LeaguesResponseImpl;

  factory _LeaguesResponse.fromJson(Map<String, dynamic> json) =
      _$LeaguesResponseImpl.fromJson;

  @override
  String get get;
  @override
  Parameters get parameters;
  @override
  List<dynamic> get errors;
  @override
  int get results;
  @override
  Paging get paging;
  @override
  List<LeagueData> get response;

  /// Create a copy of LeaguesResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaguesResponseImplCopyWith<_$LeaguesResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Parameters _$ParametersFromJson(Map<String, dynamic> json) {
  return _Parameters.fromJson(json);
}

/// @nodoc
mixin _$Parameters {
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String? get season => throw _privateConstructorUsedError;
  String? get team => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get current => throw _privateConstructorUsedError;
  String? get search => throw _privateConstructorUsedError;

  /// Serializes this Parameters to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Parameters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParametersCopyWith<Parameters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParametersCopyWith<$Res> {
  factory $ParametersCopyWith(
          Parameters value, $Res Function(Parameters) then) =
      _$ParametersCopyWithImpl<$Res, Parameters>;
  @useResult
  $Res call(
      {String id,
      String? name,
      String? country,
      String? code,
      String? season,
      String? team,
      String? type,
      String? current,
      String? search});
}

/// @nodoc
class _$ParametersCopyWithImpl<$Res, $Val extends Parameters>
    implements $ParametersCopyWith<$Res> {
  _$ParametersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Parameters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? country = freezed,
    Object? code = freezed,
    Object? season = freezed,
    Object? team = freezed,
    Object? type = freezed,
    Object? current = freezed,
    Object? search = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      season: freezed == season
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as String?,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      current: freezed == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as String?,
      search: freezed == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ParametersImplCopyWith<$Res>
    implements $ParametersCopyWith<$Res> {
  factory _$$ParametersImplCopyWith(
          _$ParametersImpl value, $Res Function(_$ParametersImpl) then) =
      __$$ParametersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? name,
      String? country,
      String? code,
      String? season,
      String? team,
      String? type,
      String? current,
      String? search});
}

/// @nodoc
class __$$ParametersImplCopyWithImpl<$Res>
    extends _$ParametersCopyWithImpl<$Res, _$ParametersImpl>
    implements _$$ParametersImplCopyWith<$Res> {
  __$$ParametersImplCopyWithImpl(
      _$ParametersImpl _value, $Res Function(_$ParametersImpl) _then)
      : super(_value, _then);

  /// Create a copy of Parameters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? country = freezed,
    Object? code = freezed,
    Object? season = freezed,
    Object? team = freezed,
    Object? type = freezed,
    Object? current = freezed,
    Object? search = freezed,
  }) {
    return _then(_$ParametersImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      season: freezed == season
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as String?,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      current: freezed == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as String?,
      search: freezed == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParametersImpl implements _Parameters {
  const _$ParametersImpl(
      {required this.id,
      this.name,
      this.country,
      this.code,
      this.season,
      this.team,
      this.type,
      this.current,
      this.search});

  factory _$ParametersImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParametersImplFromJson(json);

  @override
  final String id;
  @override
  final String? name;
  @override
  final String? country;
  @override
  final String? code;
  @override
  final String? season;
  @override
  final String? team;
  @override
  final String? type;
  @override
  final String? current;
  @override
  final String? search;

  @override
  String toString() {
    return 'Parameters(id: $id, name: $name, country: $country, code: $code, season: $season, team: $team, type: $type, current: $current, search: $search)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParametersImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.season, season) || other.season == season) &&
            (identical(other.team, team) || other.team == team) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.current, current) || other.current == current) &&
            (identical(other.search, search) || other.search == search));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, country, code, season,
      team, type, current, search);

  /// Create a copy of Parameters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParametersImplCopyWith<_$ParametersImpl> get copyWith =>
      __$$ParametersImplCopyWithImpl<_$ParametersImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParametersImplToJson(
      this,
    );
  }
}

abstract class _Parameters implements Parameters {
  const factory _Parameters(
      {required final String id,
      final String? name,
      final String? country,
      final String? code,
      final String? season,
      final String? team,
      final String? type,
      final String? current,
      final String? search}) = _$ParametersImpl;

  factory _Parameters.fromJson(Map<String, dynamic> json) =
      _$ParametersImpl.fromJson;

  @override
  String get id;
  @override
  String? get name;
  @override
  String? get country;
  @override
  String? get code;
  @override
  String? get season;
  @override
  String? get team;
  @override
  String? get type;
  @override
  String? get current;
  @override
  String? get search;

  /// Create a copy of Parameters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParametersImplCopyWith<_$ParametersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Paging _$PagingFromJson(Map<String, dynamic> json) {
  return _Paging.fromJson(json);
}

/// @nodoc
mixin _$Paging {
  int get current => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  /// Serializes this Paging to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Paging
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PagingCopyWith<Paging> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PagingCopyWith<$Res> {
  factory $PagingCopyWith(Paging value, $Res Function(Paging) then) =
      _$PagingCopyWithImpl<$Res, Paging>;
  @useResult
  $Res call({int current, int total});
}

/// @nodoc
class _$PagingCopyWithImpl<$Res, $Val extends Paging>
    implements $PagingCopyWith<$Res> {
  _$PagingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Paging
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? current = null,
    Object? total = null,
  }) {
    return _then(_value.copyWith(
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PagingImplCopyWith<$Res> implements $PagingCopyWith<$Res> {
  factory _$$PagingImplCopyWith(
          _$PagingImpl value, $Res Function(_$PagingImpl) then) =
      __$$PagingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int current, int total});
}

/// @nodoc
class __$$PagingImplCopyWithImpl<$Res>
    extends _$PagingCopyWithImpl<$Res, _$PagingImpl>
    implements _$$PagingImplCopyWith<$Res> {
  __$$PagingImplCopyWithImpl(
      _$PagingImpl _value, $Res Function(_$PagingImpl) _then)
      : super(_value, _then);

  /// Create a copy of Paging
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? current = null,
    Object? total = null,
  }) {
    return _then(_$PagingImpl(
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PagingImpl implements _Paging {
  const _$PagingImpl({required this.current, required this.total});

  factory _$PagingImpl.fromJson(Map<String, dynamic> json) =>
      _$$PagingImplFromJson(json);

  @override
  final int current;
  @override
  final int total;

  @override
  String toString() {
    return 'Paging(current: $current, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PagingImpl &&
            (identical(other.current, current) || other.current == current) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, current, total);

  /// Create a copy of Paging
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PagingImplCopyWith<_$PagingImpl> get copyWith =>
      __$$PagingImplCopyWithImpl<_$PagingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PagingImplToJson(
      this,
    );
  }
}

abstract class _Paging implements Paging {
  const factory _Paging(
      {required final int current, required final int total}) = _$PagingImpl;

  factory _Paging.fromJson(Map<String, dynamic> json) = _$PagingImpl.fromJson;

  @override
  int get current;
  @override
  int get total;

  /// Create a copy of Paging
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PagingImplCopyWith<_$PagingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LeagueData _$LeagueDataFromJson(Map<String, dynamic> json) {
  return _LeagueData.fromJson(json);
}

/// @nodoc
mixin _$LeagueData {
  League get league => throw _privateConstructorUsedError;
  Country get country => throw _privateConstructorUsedError;
  List<Season> get seasons => throw _privateConstructorUsedError;

  /// Serializes this LeagueData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeagueData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeagueDataCopyWith<LeagueData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeagueDataCopyWith<$Res> {
  factory $LeagueDataCopyWith(
          LeagueData value, $Res Function(LeagueData) then) =
      _$LeagueDataCopyWithImpl<$Res, LeagueData>;
  @useResult
  $Res call({League league, Country country, List<Season> seasons});

  $LeagueCopyWith<$Res> get league;
  $CountryCopyWith<$Res> get country;
}

/// @nodoc
class _$LeagueDataCopyWithImpl<$Res, $Val extends LeagueData>
    implements $LeagueDataCopyWith<$Res> {
  _$LeagueDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeagueData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? league = null,
    Object? country = null,
    Object? seasons = null,
  }) {
    return _then(_value.copyWith(
      league: null == league
          ? _value.league
          : league // ignore: cast_nullable_to_non_nullable
              as League,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as Country,
      seasons: null == seasons
          ? _value.seasons
          : seasons // ignore: cast_nullable_to_non_nullable
              as List<Season>,
    ) as $Val);
  }

  /// Create a copy of LeagueData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LeagueCopyWith<$Res> get league {
    return $LeagueCopyWith<$Res>(_value.league, (value) {
      return _then(_value.copyWith(league: value) as $Val);
    });
  }

  /// Create a copy of LeagueData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CountryCopyWith<$Res> get country {
    return $CountryCopyWith<$Res>(_value.country, (value) {
      return _then(_value.copyWith(country: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LeagueDataImplCopyWith<$Res>
    implements $LeagueDataCopyWith<$Res> {
  factory _$$LeagueDataImplCopyWith(
          _$LeagueDataImpl value, $Res Function(_$LeagueDataImpl) then) =
      __$$LeagueDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({League league, Country country, List<Season> seasons});

  @override
  $LeagueCopyWith<$Res> get league;
  @override
  $CountryCopyWith<$Res> get country;
}

/// @nodoc
class __$$LeagueDataImplCopyWithImpl<$Res>
    extends _$LeagueDataCopyWithImpl<$Res, _$LeagueDataImpl>
    implements _$$LeagueDataImplCopyWith<$Res> {
  __$$LeagueDataImplCopyWithImpl(
      _$LeagueDataImpl _value, $Res Function(_$LeagueDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeagueData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? league = null,
    Object? country = null,
    Object? seasons = null,
  }) {
    return _then(_$LeagueDataImpl(
      league: null == league
          ? _value.league
          : league // ignore: cast_nullable_to_non_nullable
              as League,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as Country,
      seasons: null == seasons
          ? _value._seasons
          : seasons // ignore: cast_nullable_to_non_nullable
              as List<Season>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeagueDataImpl implements _LeagueData {
  const _$LeagueDataImpl(
      {required this.league,
      required this.country,
      required final List<Season> seasons})
      : _seasons = seasons;

  factory _$LeagueDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeagueDataImplFromJson(json);

  @override
  final League league;
  @override
  final Country country;
  final List<Season> _seasons;
  @override
  List<Season> get seasons {
    if (_seasons is EqualUnmodifiableListView) return _seasons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_seasons);
  }

  @override
  String toString() {
    return 'LeagueData(league: $league, country: $country, seasons: $seasons)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeagueDataImpl &&
            (identical(other.league, league) || other.league == league) &&
            (identical(other.country, country) || other.country == country) &&
            const DeepCollectionEquality().equals(other._seasons, _seasons));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, league, country,
      const DeepCollectionEquality().hash(_seasons));

  /// Create a copy of LeagueData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeagueDataImplCopyWith<_$LeagueDataImpl> get copyWith =>
      __$$LeagueDataImplCopyWithImpl<_$LeagueDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeagueDataImplToJson(
      this,
    );
  }
}

abstract class _LeagueData implements LeagueData {
  const factory _LeagueData(
      {required final League league,
      required final Country country,
      required final List<Season> seasons}) = _$LeagueDataImpl;

  factory _LeagueData.fromJson(Map<String, dynamic> json) =
      _$LeagueDataImpl.fromJson;

  @override
  League get league;
  @override
  Country get country;
  @override
  List<Season> get seasons;

  /// Create a copy of LeagueData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeagueDataImplCopyWith<_$LeagueDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

League _$LeagueFromJson(Map<String, dynamic> json) {
  return _League.fromJson(json);
}

/// @nodoc
mixin _$League {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get logo => throw _privateConstructorUsedError;

  /// Serializes this League to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of League
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeagueCopyWith<League> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeagueCopyWith<$Res> {
  factory $LeagueCopyWith(League value, $Res Function(League) then) =
      _$LeagueCopyWithImpl<$Res, League>;
  @useResult
  $Res call({int id, String name, String type, String logo});
}

/// @nodoc
class _$LeagueCopyWithImpl<$Res, $Val extends League>
    implements $LeagueCopyWith<$Res> {
  _$LeagueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of League
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? logo = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      logo: null == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeagueImplCopyWith<$Res> implements $LeagueCopyWith<$Res> {
  factory _$$LeagueImplCopyWith(
          _$LeagueImpl value, $Res Function(_$LeagueImpl) then) =
      __$$LeagueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String type, String logo});
}

/// @nodoc
class __$$LeagueImplCopyWithImpl<$Res>
    extends _$LeagueCopyWithImpl<$Res, _$LeagueImpl>
    implements _$$LeagueImplCopyWith<$Res> {
  __$$LeagueImplCopyWithImpl(
      _$LeagueImpl _value, $Res Function(_$LeagueImpl) _then)
      : super(_value, _then);

  /// Create a copy of League
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? logo = null,
  }) {
    return _then(_$LeagueImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      logo: null == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeagueImpl implements _League {
  const _$LeagueImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.logo});

  factory _$LeagueImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeagueImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String type;
  @override
  final String logo;

  @override
  String toString() {
    return 'League(id: $id, name: $name, type: $type, logo: $logo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeagueImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.logo, logo) || other.logo == logo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, type, logo);

  /// Create a copy of League
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeagueImplCopyWith<_$LeagueImpl> get copyWith =>
      __$$LeagueImplCopyWithImpl<_$LeagueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeagueImplToJson(
      this,
    );
  }
}

abstract class _League implements League {
  const factory _League(
      {required final int id,
      required final String name,
      required final String type,
      required final String logo}) = _$LeagueImpl;

  factory _League.fromJson(Map<String, dynamic> json) = _$LeagueImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get type;
  @override
  String get logo;

  /// Create a copy of League
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeagueImplCopyWith<_$LeagueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Country _$CountryFromJson(Map<String, dynamic> json) {
  return _Country.fromJson(json);
}

/// @nodoc
mixin _$Country {
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get flag => throw _privateConstructorUsedError;

  /// Serializes this Country to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CountryCopyWith<Country> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CountryCopyWith<$Res> {
  factory $CountryCopyWith(Country value, $Res Function(Country) then) =
      _$CountryCopyWithImpl<$Res, Country>;
  @useResult
  $Res call({String name, String code, String flag});
}

/// @nodoc
class _$CountryCopyWithImpl<$Res, $Val extends Country>
    implements $CountryCopyWith<$Res> {
  _$CountryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? code = null,
    Object? flag = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      flag: null == flag
          ? _value.flag
          : flag // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CountryImplCopyWith<$Res> implements $CountryCopyWith<$Res> {
  factory _$$CountryImplCopyWith(
          _$CountryImpl value, $Res Function(_$CountryImpl) then) =
      __$$CountryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String code, String flag});
}

/// @nodoc
class __$$CountryImplCopyWithImpl<$Res>
    extends _$CountryCopyWithImpl<$Res, _$CountryImpl>
    implements _$$CountryImplCopyWith<$Res> {
  __$$CountryImplCopyWithImpl(
      _$CountryImpl _value, $Res Function(_$CountryImpl) _then)
      : super(_value, _then);

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? code = null,
    Object? flag = null,
  }) {
    return _then(_$CountryImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      flag: null == flag
          ? _value.flag
          : flag // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CountryImpl implements _Country {
  const _$CountryImpl(
      {required this.name, required this.code, required this.flag});

  factory _$CountryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CountryImplFromJson(json);

  @override
  final String name;
  @override
  final String code;
  @override
  final String flag;

  @override
  String toString() {
    return 'Country(name: $name, code: $code, flag: $flag)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CountryImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.flag, flag) || other.flag == flag));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, code, flag);

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CountryImplCopyWith<_$CountryImpl> get copyWith =>
      __$$CountryImplCopyWithImpl<_$CountryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CountryImplToJson(
      this,
    );
  }
}

abstract class _Country implements Country {
  const factory _Country(
      {required final String name,
      required final String code,
      required final String flag}) = _$CountryImpl;

  factory _Country.fromJson(Map<String, dynamic> json) = _$CountryImpl.fromJson;

  @override
  String get name;
  @override
  String get code;
  @override
  String get flag;

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CountryImplCopyWith<_$CountryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Season _$SeasonFromJson(Map<String, dynamic> json) {
  return _Season.fromJson(json);
}

/// @nodoc
mixin _$Season {
  int get year => throw _privateConstructorUsedError;
  String get start => throw _privateConstructorUsedError;
  String get end => throw _privateConstructorUsedError;
  bool get current => throw _privateConstructorUsedError;
  Coverage get coverage => throw _privateConstructorUsedError;

  /// Serializes this Season to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Season
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeasonCopyWith<Season> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeasonCopyWith<$Res> {
  factory $SeasonCopyWith(Season value, $Res Function(Season) then) =
      _$SeasonCopyWithImpl<$Res, Season>;
  @useResult
  $Res call(
      {int year, String start, String end, bool current, Coverage coverage});

  $CoverageCopyWith<$Res> get coverage;
}

/// @nodoc
class _$SeasonCopyWithImpl<$Res, $Val extends Season>
    implements $SeasonCopyWith<$Res> {
  _$SeasonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Season
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? start = null,
    Object? end = null,
    Object? current = null,
    Object? coverage = null,
  }) {
    return _then(_value.copyWith(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as bool,
      coverage: null == coverage
          ? _value.coverage
          : coverage // ignore: cast_nullable_to_non_nullable
              as Coverage,
    ) as $Val);
  }

  /// Create a copy of Season
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CoverageCopyWith<$Res> get coverage {
    return $CoverageCopyWith<$Res>(_value.coverage, (value) {
      return _then(_value.copyWith(coverage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SeasonImplCopyWith<$Res> implements $SeasonCopyWith<$Res> {
  factory _$$SeasonImplCopyWith(
          _$SeasonImpl value, $Res Function(_$SeasonImpl) then) =
      __$$SeasonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int year, String start, String end, bool current, Coverage coverage});

  @override
  $CoverageCopyWith<$Res> get coverage;
}

/// @nodoc
class __$$SeasonImplCopyWithImpl<$Res>
    extends _$SeasonCopyWithImpl<$Res, _$SeasonImpl>
    implements _$$SeasonImplCopyWith<$Res> {
  __$$SeasonImplCopyWithImpl(
      _$SeasonImpl _value, $Res Function(_$SeasonImpl) _then)
      : super(_value, _then);

  /// Create a copy of Season
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? start = null,
    Object? end = null,
    Object? current = null,
    Object? coverage = null,
  }) {
    return _then(_$SeasonImpl(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as bool,
      coverage: null == coverage
          ? _value.coverage
          : coverage // ignore: cast_nullable_to_non_nullable
              as Coverage,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SeasonImpl implements _Season {
  const _$SeasonImpl(
      {required this.year,
      required this.start,
      required this.end,
      required this.current,
      required this.coverage});

  factory _$SeasonImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeasonImplFromJson(json);

  @override
  final int year;
  @override
  final String start;
  @override
  final String end;
  @override
  final bool current;
  @override
  final Coverage coverage;

  @override
  String toString() {
    return 'Season(year: $year, start: $start, end: $end, current: $current, coverage: $coverage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeasonImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.current, current) || other.current == current) &&
            (identical(other.coverage, coverage) ||
                other.coverage == coverage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, year, start, end, current, coverage);

  /// Create a copy of Season
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeasonImplCopyWith<_$SeasonImpl> get copyWith =>
      __$$SeasonImplCopyWithImpl<_$SeasonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SeasonImplToJson(
      this,
    );
  }
}

abstract class _Season implements Season {
  const factory _Season(
      {required final int year,
      required final String start,
      required final String end,
      required final bool current,
      required final Coverage coverage}) = _$SeasonImpl;

  factory _Season.fromJson(Map<String, dynamic> json) = _$SeasonImpl.fromJson;

  @override
  int get year;
  @override
  String get start;
  @override
  String get end;
  @override
  bool get current;
  @override
  Coverage get coverage;

  /// Create a copy of Season
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeasonImplCopyWith<_$SeasonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Coverage _$CoverageFromJson(Map<String, dynamic> json) {
  return _Coverage.fromJson(json);
}

/// @nodoc
mixin _$Coverage {
  Fixtures get fixtures => throw _privateConstructorUsedError;
  bool get standings => throw _privateConstructorUsedError;
  bool get players => throw _privateConstructorUsedError;
  bool get top_scorers => throw _privateConstructorUsedError;
  bool get top_assists => throw _privateConstructorUsedError;
  bool get top_cards => throw _privateConstructorUsedError;
  bool get injuries => throw _privateConstructorUsedError;
  bool get predictions => throw _privateConstructorUsedError;
  bool get odds => throw _privateConstructorUsedError;

  /// Serializes this Coverage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Coverage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CoverageCopyWith<Coverage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoverageCopyWith<$Res> {
  factory $CoverageCopyWith(Coverage value, $Res Function(Coverage) then) =
      _$CoverageCopyWithImpl<$Res, Coverage>;
  @useResult
  $Res call(
      {Fixtures fixtures,
      bool standings,
      bool players,
      bool top_scorers,
      bool top_assists,
      bool top_cards,
      bool injuries,
      bool predictions,
      bool odds});

  $FixturesCopyWith<$Res> get fixtures;
}

/// @nodoc
class _$CoverageCopyWithImpl<$Res, $Val extends Coverage>
    implements $CoverageCopyWith<$Res> {
  _$CoverageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Coverage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fixtures = null,
    Object? standings = null,
    Object? players = null,
    Object? top_scorers = null,
    Object? top_assists = null,
    Object? top_cards = null,
    Object? injuries = null,
    Object? predictions = null,
    Object? odds = null,
  }) {
    return _then(_value.copyWith(
      fixtures: null == fixtures
          ? _value.fixtures
          : fixtures // ignore: cast_nullable_to_non_nullable
              as Fixtures,
      standings: null == standings
          ? _value.standings
          : standings // ignore: cast_nullable_to_non_nullable
              as bool,
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as bool,
      top_scorers: null == top_scorers
          ? _value.top_scorers
          : top_scorers // ignore: cast_nullable_to_non_nullable
              as bool,
      top_assists: null == top_assists
          ? _value.top_assists
          : top_assists // ignore: cast_nullable_to_non_nullable
              as bool,
      top_cards: null == top_cards
          ? _value.top_cards
          : top_cards // ignore: cast_nullable_to_non_nullable
              as bool,
      injuries: null == injuries
          ? _value.injuries
          : injuries // ignore: cast_nullable_to_non_nullable
              as bool,
      predictions: null == predictions
          ? _value.predictions
          : predictions // ignore: cast_nullable_to_non_nullable
              as bool,
      odds: null == odds
          ? _value.odds
          : odds // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of Coverage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FixturesCopyWith<$Res> get fixtures {
    return $FixturesCopyWith<$Res>(_value.fixtures, (value) {
      return _then(_value.copyWith(fixtures: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CoverageImplCopyWith<$Res>
    implements $CoverageCopyWith<$Res> {
  factory _$$CoverageImplCopyWith(
          _$CoverageImpl value, $Res Function(_$CoverageImpl) then) =
      __$$CoverageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Fixtures fixtures,
      bool standings,
      bool players,
      bool top_scorers,
      bool top_assists,
      bool top_cards,
      bool injuries,
      bool predictions,
      bool odds});

  @override
  $FixturesCopyWith<$Res> get fixtures;
}

/// @nodoc
class __$$CoverageImplCopyWithImpl<$Res>
    extends _$CoverageCopyWithImpl<$Res, _$CoverageImpl>
    implements _$$CoverageImplCopyWith<$Res> {
  __$$CoverageImplCopyWithImpl(
      _$CoverageImpl _value, $Res Function(_$CoverageImpl) _then)
      : super(_value, _then);

  /// Create a copy of Coverage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fixtures = null,
    Object? standings = null,
    Object? players = null,
    Object? top_scorers = null,
    Object? top_assists = null,
    Object? top_cards = null,
    Object? injuries = null,
    Object? predictions = null,
    Object? odds = null,
  }) {
    return _then(_$CoverageImpl(
      fixtures: null == fixtures
          ? _value.fixtures
          : fixtures // ignore: cast_nullable_to_non_nullable
              as Fixtures,
      standings: null == standings
          ? _value.standings
          : standings // ignore: cast_nullable_to_non_nullable
              as bool,
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as bool,
      top_scorers: null == top_scorers
          ? _value.top_scorers
          : top_scorers // ignore: cast_nullable_to_non_nullable
              as bool,
      top_assists: null == top_assists
          ? _value.top_assists
          : top_assists // ignore: cast_nullable_to_non_nullable
              as bool,
      top_cards: null == top_cards
          ? _value.top_cards
          : top_cards // ignore: cast_nullable_to_non_nullable
              as bool,
      injuries: null == injuries
          ? _value.injuries
          : injuries // ignore: cast_nullable_to_non_nullable
              as bool,
      predictions: null == predictions
          ? _value.predictions
          : predictions // ignore: cast_nullable_to_non_nullable
              as bool,
      odds: null == odds
          ? _value.odds
          : odds // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CoverageImpl implements _Coverage {
  const _$CoverageImpl(
      {required this.fixtures,
      required this.standings,
      required this.players,
      required this.top_scorers,
      required this.top_assists,
      required this.top_cards,
      required this.injuries,
      required this.predictions,
      required this.odds});

  factory _$CoverageImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoverageImplFromJson(json);

  @override
  final Fixtures fixtures;
  @override
  final bool standings;
  @override
  final bool players;
  @override
  final bool top_scorers;
  @override
  final bool top_assists;
  @override
  final bool top_cards;
  @override
  final bool injuries;
  @override
  final bool predictions;
  @override
  final bool odds;

  @override
  String toString() {
    return 'Coverage(fixtures: $fixtures, standings: $standings, players: $players, top_scorers: $top_scorers, top_assists: $top_assists, top_cards: $top_cards, injuries: $injuries, predictions: $predictions, odds: $odds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoverageImpl &&
            (identical(other.fixtures, fixtures) ||
                other.fixtures == fixtures) &&
            (identical(other.standings, standings) ||
                other.standings == standings) &&
            (identical(other.players, players) || other.players == players) &&
            (identical(other.top_scorers, top_scorers) ||
                other.top_scorers == top_scorers) &&
            (identical(other.top_assists, top_assists) ||
                other.top_assists == top_assists) &&
            (identical(other.top_cards, top_cards) ||
                other.top_cards == top_cards) &&
            (identical(other.injuries, injuries) ||
                other.injuries == injuries) &&
            (identical(other.predictions, predictions) ||
                other.predictions == predictions) &&
            (identical(other.odds, odds) || other.odds == odds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fixtures, standings, players,
      top_scorers, top_assists, top_cards, injuries, predictions, odds);

  /// Create a copy of Coverage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoverageImplCopyWith<_$CoverageImpl> get copyWith =>
      __$$CoverageImplCopyWithImpl<_$CoverageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CoverageImplToJson(
      this,
    );
  }
}

abstract class _Coverage implements Coverage {
  const factory _Coverage(
      {required final Fixtures fixtures,
      required final bool standings,
      required final bool players,
      required final bool top_scorers,
      required final bool top_assists,
      required final bool top_cards,
      required final bool injuries,
      required final bool predictions,
      required final bool odds}) = _$CoverageImpl;

  factory _Coverage.fromJson(Map<String, dynamic> json) =
      _$CoverageImpl.fromJson;

  @override
  Fixtures get fixtures;
  @override
  bool get standings;
  @override
  bool get players;
  @override
  bool get top_scorers;
  @override
  bool get top_assists;
  @override
  bool get top_cards;
  @override
  bool get injuries;
  @override
  bool get predictions;
  @override
  bool get odds;

  /// Create a copy of Coverage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoverageImplCopyWith<_$CoverageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Fixtures _$FixturesFromJson(Map<String, dynamic> json) {
  return _Fixtures.fromJson(json);
}

/// @nodoc
mixin _$Fixtures {
  bool get events => throw _privateConstructorUsedError;
  bool get lineups => throw _privateConstructorUsedError;
  bool get statistics_fixtures => throw _privateConstructorUsedError;
  bool get statistics_players => throw _privateConstructorUsedError;

  /// Serializes this Fixtures to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Fixtures
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FixturesCopyWith<Fixtures> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FixturesCopyWith<$Res> {
  factory $FixturesCopyWith(Fixtures value, $Res Function(Fixtures) then) =
      _$FixturesCopyWithImpl<$Res, Fixtures>;
  @useResult
  $Res call(
      {bool events,
      bool lineups,
      bool statistics_fixtures,
      bool statistics_players});
}

/// @nodoc
class _$FixturesCopyWithImpl<$Res, $Val extends Fixtures>
    implements $FixturesCopyWith<$Res> {
  _$FixturesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Fixtures
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? events = null,
    Object? lineups = null,
    Object? statistics_fixtures = null,
    Object? statistics_players = null,
  }) {
    return _then(_value.copyWith(
      events: null == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as bool,
      lineups: null == lineups
          ? _value.lineups
          : lineups // ignore: cast_nullable_to_non_nullable
              as bool,
      statistics_fixtures: null == statistics_fixtures
          ? _value.statistics_fixtures
          : statistics_fixtures // ignore: cast_nullable_to_non_nullable
              as bool,
      statistics_players: null == statistics_players
          ? _value.statistics_players
          : statistics_players // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FixturesImplCopyWith<$Res>
    implements $FixturesCopyWith<$Res> {
  factory _$$FixturesImplCopyWith(
          _$FixturesImpl value, $Res Function(_$FixturesImpl) then) =
      __$$FixturesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool events,
      bool lineups,
      bool statistics_fixtures,
      bool statistics_players});
}

/// @nodoc
class __$$FixturesImplCopyWithImpl<$Res>
    extends _$FixturesCopyWithImpl<$Res, _$FixturesImpl>
    implements _$$FixturesImplCopyWith<$Res> {
  __$$FixturesImplCopyWithImpl(
      _$FixturesImpl _value, $Res Function(_$FixturesImpl) _then)
      : super(_value, _then);

  /// Create a copy of Fixtures
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? events = null,
    Object? lineups = null,
    Object? statistics_fixtures = null,
    Object? statistics_players = null,
  }) {
    return _then(_$FixturesImpl(
      events: null == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as bool,
      lineups: null == lineups
          ? _value.lineups
          : lineups // ignore: cast_nullable_to_non_nullable
              as bool,
      statistics_fixtures: null == statistics_fixtures
          ? _value.statistics_fixtures
          : statistics_fixtures // ignore: cast_nullable_to_non_nullable
              as bool,
      statistics_players: null == statistics_players
          ? _value.statistics_players
          : statistics_players // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FixturesImpl implements _Fixtures {
  const _$FixturesImpl(
      {required this.events,
      required this.lineups,
      required this.statistics_fixtures,
      required this.statistics_players});

  factory _$FixturesImpl.fromJson(Map<String, dynamic> json) =>
      _$$FixturesImplFromJson(json);

  @override
  final bool events;
  @override
  final bool lineups;
  @override
  final bool statistics_fixtures;
  @override
  final bool statistics_players;

  @override
  String toString() {
    return 'Fixtures(events: $events, lineups: $lineups, statistics_fixtures: $statistics_fixtures, statistics_players: $statistics_players)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FixturesImpl &&
            (identical(other.events, events) || other.events == events) &&
            (identical(other.lineups, lineups) || other.lineups == lineups) &&
            (identical(other.statistics_fixtures, statistics_fixtures) ||
                other.statistics_fixtures == statistics_fixtures) &&
            (identical(other.statistics_players, statistics_players) ||
                other.statistics_players == statistics_players));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, events, lineups, statistics_fixtures, statistics_players);

  /// Create a copy of Fixtures
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FixturesImplCopyWith<_$FixturesImpl> get copyWith =>
      __$$FixturesImplCopyWithImpl<_$FixturesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FixturesImplToJson(
      this,
    );
  }
}

abstract class _Fixtures implements Fixtures {
  const factory _Fixtures(
      {required final bool events,
      required final bool lineups,
      required final bool statistics_fixtures,
      required final bool statistics_players}) = _$FixturesImpl;

  factory _Fixtures.fromJson(Map<String, dynamic> json) =
      _$FixturesImpl.fromJson;

  @override
  bool get events;
  @override
  bool get lineups;
  @override
  bool get statistics_fixtures;
  @override
  bool get statistics_players;

  /// Create a copy of Fixtures
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FixturesImplCopyWith<_$FixturesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
