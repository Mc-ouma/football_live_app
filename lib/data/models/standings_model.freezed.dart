// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'standings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StandingsResponse _$StandingsResponseFromJson(Map<String, dynamic> json) {
  return _StandingsResponse.fromJson(json);
}

/// @nodoc
mixin _$StandingsResponse {
  String get get => throw _privateConstructorUsedError;
  Parameters get parameters => throw _privateConstructorUsedError;
  List<dynamic> get errors => throw _privateConstructorUsedError;
  int get results => throw _privateConstructorUsedError;
  Paging get paging => throw _privateConstructorUsedError;
  List<LeagueResponse> get response => throw _privateConstructorUsedError;

  /// Serializes this StandingsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StandingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StandingsResponseCopyWith<StandingsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StandingsResponseCopyWith<$Res> {
  factory $StandingsResponseCopyWith(
          StandingsResponse value, $Res Function(StandingsResponse) then) =
      _$StandingsResponseCopyWithImpl<$Res, StandingsResponse>;
  @useResult
  $Res call(
      {String get,
      Parameters parameters,
      List<dynamic> errors,
      int results,
      Paging paging,
      List<LeagueResponse> response});

  $ParametersCopyWith<$Res> get parameters;
  $PagingCopyWith<$Res> get paging;
}

/// @nodoc
class _$StandingsResponseCopyWithImpl<$Res, $Val extends StandingsResponse>
    implements $StandingsResponseCopyWith<$Res> {
  _$StandingsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StandingsResponse
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
              as List<LeagueResponse>,
    ) as $Val);
  }

  /// Create a copy of StandingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ParametersCopyWith<$Res> get parameters {
    return $ParametersCopyWith<$Res>(_value.parameters, (value) {
      return _then(_value.copyWith(parameters: value) as $Val);
    });
  }

  /// Create a copy of StandingsResponse
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
abstract class _$$StandingsResponseImplCopyWith<$Res>
    implements $StandingsResponseCopyWith<$Res> {
  factory _$$StandingsResponseImplCopyWith(_$StandingsResponseImpl value,
          $Res Function(_$StandingsResponseImpl) then) =
      __$$StandingsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String get,
      Parameters parameters,
      List<dynamic> errors,
      int results,
      Paging paging,
      List<LeagueResponse> response});

  @override
  $ParametersCopyWith<$Res> get parameters;
  @override
  $PagingCopyWith<$Res> get paging;
}

/// @nodoc
class __$$StandingsResponseImplCopyWithImpl<$Res>
    extends _$StandingsResponseCopyWithImpl<$Res, _$StandingsResponseImpl>
    implements _$$StandingsResponseImplCopyWith<$Res> {
  __$$StandingsResponseImplCopyWithImpl(_$StandingsResponseImpl _value,
      $Res Function(_$StandingsResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of StandingsResponse
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
    return _then(_$StandingsResponseImpl(
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
              as List<LeagueResponse>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StandingsResponseImpl implements _StandingsResponse {
  const _$StandingsResponseImpl(
      {required this.get,
      required this.parameters,
      required final List<dynamic> errors,
      required this.results,
      required this.paging,
      required final List<LeagueResponse> response})
      : _errors = errors,
        _response = response;

  factory _$StandingsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$StandingsResponseImplFromJson(json);

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
  final List<LeagueResponse> _response;
  @override
  List<LeagueResponse> get response {
    if (_response is EqualUnmodifiableListView) return _response;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_response);
  }

  @override
  String toString() {
    return 'StandingsResponse(get: $get, parameters: $parameters, errors: $errors, results: $results, paging: $paging, response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StandingsResponseImpl &&
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

  /// Create a copy of StandingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StandingsResponseImplCopyWith<_$StandingsResponseImpl> get copyWith =>
      __$$StandingsResponseImplCopyWithImpl<_$StandingsResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StandingsResponseImplToJson(
      this,
    );
  }
}

abstract class _StandingsResponse implements StandingsResponse {
  const factory _StandingsResponse(
      {required final String get,
      required final Parameters parameters,
      required final List<dynamic> errors,
      required final int results,
      required final Paging paging,
      required final List<LeagueResponse> response}) = _$StandingsResponseImpl;

  factory _StandingsResponse.fromJson(Map<String, dynamic> json) =
      _$StandingsResponseImpl.fromJson;

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
  List<LeagueResponse> get response;

  /// Create a copy of StandingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StandingsResponseImplCopyWith<_$StandingsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LeagueResponse _$LeagueResponseFromJson(Map<String, dynamic> json) {
  return _LeagueResponse.fromJson(json);
}

/// @nodoc
mixin _$LeagueResponse {
  StandingsLeague get league => throw _privateConstructorUsedError;

  /// Serializes this LeagueResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeagueResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeagueResponseCopyWith<LeagueResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeagueResponseCopyWith<$Res> {
  factory $LeagueResponseCopyWith(
          LeagueResponse value, $Res Function(LeagueResponse) then) =
      _$LeagueResponseCopyWithImpl<$Res, LeagueResponse>;
  @useResult
  $Res call({StandingsLeague league});

  $StandingsLeagueCopyWith<$Res> get league;
}

/// @nodoc
class _$LeagueResponseCopyWithImpl<$Res, $Val extends LeagueResponse>
    implements $LeagueResponseCopyWith<$Res> {
  _$LeagueResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeagueResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? league = null,
  }) {
    return _then(_value.copyWith(
      league: null == league
          ? _value.league
          : league // ignore: cast_nullable_to_non_nullable
              as StandingsLeague,
    ) as $Val);
  }

  /// Create a copy of LeagueResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StandingsLeagueCopyWith<$Res> get league {
    return $StandingsLeagueCopyWith<$Res>(_value.league, (value) {
      return _then(_value.copyWith(league: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LeagueResponseImplCopyWith<$Res>
    implements $LeagueResponseCopyWith<$Res> {
  factory _$$LeagueResponseImplCopyWith(_$LeagueResponseImpl value,
          $Res Function(_$LeagueResponseImpl) then) =
      __$$LeagueResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StandingsLeague league});

  @override
  $StandingsLeagueCopyWith<$Res> get league;
}

/// @nodoc
class __$$LeagueResponseImplCopyWithImpl<$Res>
    extends _$LeagueResponseCopyWithImpl<$Res, _$LeagueResponseImpl>
    implements _$$LeagueResponseImplCopyWith<$Res> {
  __$$LeagueResponseImplCopyWithImpl(
      _$LeagueResponseImpl _value, $Res Function(_$LeagueResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeagueResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? league = null,
  }) {
    return _then(_$LeagueResponseImpl(
      league: null == league
          ? _value.league
          : league // ignore: cast_nullable_to_non_nullable
              as StandingsLeague,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeagueResponseImpl implements _LeagueResponse {
  const _$LeagueResponseImpl({required this.league});

  factory _$LeagueResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeagueResponseImplFromJson(json);

  @override
  final StandingsLeague league;

  @override
  String toString() {
    return 'LeagueResponse(league: $league)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeagueResponseImpl &&
            (identical(other.league, league) || other.league == league));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, league);

  /// Create a copy of LeagueResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeagueResponseImplCopyWith<_$LeagueResponseImpl> get copyWith =>
      __$$LeagueResponseImplCopyWithImpl<_$LeagueResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeagueResponseImplToJson(
      this,
    );
  }
}

abstract class _LeagueResponse implements LeagueResponse {
  const factory _LeagueResponse({required final StandingsLeague league}) =
      _$LeagueResponseImpl;

  factory _LeagueResponse.fromJson(Map<String, dynamic> json) =
      _$LeagueResponseImpl.fromJson;

  @override
  StandingsLeague get league;

  /// Create a copy of LeagueResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeagueResponseImplCopyWith<_$LeagueResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StandingsLeague _$StandingsLeagueFromJson(Map<String, dynamic> json) {
  return _StandingsLeague.fromJson(json);
}

/// @nodoc
mixin _$StandingsLeague {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  String get logo => throw _privateConstructorUsedError;
  String get flag => throw _privateConstructorUsedError;
  int get season => throw _privateConstructorUsedError;
  List<List<Standing>> get standings => throw _privateConstructorUsedError;

  /// Serializes this StandingsLeague to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StandingsLeague
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StandingsLeagueCopyWith<StandingsLeague> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StandingsLeagueCopyWith<$Res> {
  factory $StandingsLeagueCopyWith(
          StandingsLeague value, $Res Function(StandingsLeague) then) =
      _$StandingsLeagueCopyWithImpl<$Res, StandingsLeague>;
  @useResult
  $Res call(
      {int id,
      String name,
      String country,
      String logo,
      String flag,
      int season,
      List<List<Standing>> standings});
}

/// @nodoc
class _$StandingsLeagueCopyWithImpl<$Res, $Val extends StandingsLeague>
    implements $StandingsLeagueCopyWith<$Res> {
  _$StandingsLeagueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StandingsLeague
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? country = null,
    Object? logo = null,
    Object? flag = null,
    Object? season = null,
    Object? standings = null,
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
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      logo: null == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String,
      flag: null == flag
          ? _value.flag
          : flag // ignore: cast_nullable_to_non_nullable
              as String,
      season: null == season
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as int,
      standings: null == standings
          ? _value.standings
          : standings // ignore: cast_nullable_to_non_nullable
              as List<List<Standing>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StandingsLeagueImplCopyWith<$Res>
    implements $StandingsLeagueCopyWith<$Res> {
  factory _$$StandingsLeagueImplCopyWith(_$StandingsLeagueImpl value,
          $Res Function(_$StandingsLeagueImpl) then) =
      __$$StandingsLeagueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String country,
      String logo,
      String flag,
      int season,
      List<List<Standing>> standings});
}

/// @nodoc
class __$$StandingsLeagueImplCopyWithImpl<$Res>
    extends _$StandingsLeagueCopyWithImpl<$Res, _$StandingsLeagueImpl>
    implements _$$StandingsLeagueImplCopyWith<$Res> {
  __$$StandingsLeagueImplCopyWithImpl(
      _$StandingsLeagueImpl _value, $Res Function(_$StandingsLeagueImpl) _then)
      : super(_value, _then);

  /// Create a copy of StandingsLeague
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? country = null,
    Object? logo = null,
    Object? flag = null,
    Object? season = null,
    Object? standings = null,
  }) {
    return _then(_$StandingsLeagueImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      logo: null == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String,
      flag: null == flag
          ? _value.flag
          : flag // ignore: cast_nullable_to_non_nullable
              as String,
      season: null == season
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as int,
      standings: null == standings
          ? _value._standings
          : standings // ignore: cast_nullable_to_non_nullable
              as List<List<Standing>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StandingsLeagueImpl implements _StandingsLeague {
  const _$StandingsLeagueImpl(
      {required this.id,
      required this.name,
      required this.country,
      required this.logo,
      required this.flag,
      required this.season,
      required final List<List<Standing>> standings})
      : _standings = standings;

  factory _$StandingsLeagueImpl.fromJson(Map<String, dynamic> json) =>
      _$$StandingsLeagueImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String country;
  @override
  final String logo;
  @override
  final String flag;
  @override
  final int season;
  final List<List<Standing>> _standings;
  @override
  List<List<Standing>> get standings {
    if (_standings is EqualUnmodifiableListView) return _standings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_standings);
  }

  @override
  String toString() {
    return 'StandingsLeague(id: $id, name: $name, country: $country, logo: $logo, flag: $flag, season: $season, standings: $standings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StandingsLeagueImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.flag, flag) || other.flag == flag) &&
            (identical(other.season, season) || other.season == season) &&
            const DeepCollectionEquality()
                .equals(other._standings, _standings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, country, logo, flag,
      season, const DeepCollectionEquality().hash(_standings));

  /// Create a copy of StandingsLeague
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StandingsLeagueImplCopyWith<_$StandingsLeagueImpl> get copyWith =>
      __$$StandingsLeagueImplCopyWithImpl<_$StandingsLeagueImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StandingsLeagueImplToJson(
      this,
    );
  }
}

abstract class _StandingsLeague implements StandingsLeague {
  const factory _StandingsLeague(
      {required final int id,
      required final String name,
      required final String country,
      required final String logo,
      required final String flag,
      required final int season,
      required final List<List<Standing>> standings}) = _$StandingsLeagueImpl;

  factory _StandingsLeague.fromJson(Map<String, dynamic> json) =
      _$StandingsLeagueImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get country;
  @override
  String get logo;
  @override
  String get flag;
  @override
  int get season;
  @override
  List<List<Standing>> get standings;

  /// Create a copy of StandingsLeague
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StandingsLeagueImplCopyWith<_$StandingsLeagueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Standing _$StandingFromJson(Map<String, dynamic> json) {
  return _Standing.fromJson(json);
}

/// @nodoc
mixin _$Standing {
  int get rank => throw _privateConstructorUsedError;
  Team get team => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  int get goalsDiff => throw _privateConstructorUsedError;
  String get group => throw _privateConstructorUsedError;
  String get form => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  MatchStats get all => throw _privateConstructorUsedError;
  MatchStats get home => throw _privateConstructorUsedError;
  MatchStats get away => throw _privateConstructorUsedError;
  String get update => throw _privateConstructorUsedError;

  /// Serializes this Standing to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Standing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StandingCopyWith<Standing> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StandingCopyWith<$Res> {
  factory $StandingCopyWith(Standing value, $Res Function(Standing) then) =
      _$StandingCopyWithImpl<$Res, Standing>;
  @useResult
  $Res call(
      {int rank,
      Team team,
      int points,
      int goalsDiff,
      String group,
      String form,
      String status,
      String description,
      MatchStats all,
      MatchStats home,
      MatchStats away,
      String update});

  $TeamCopyWith<$Res> get team;
  $MatchStatsCopyWith<$Res> get all;
  $MatchStatsCopyWith<$Res> get home;
  $MatchStatsCopyWith<$Res> get away;
}

/// @nodoc
class _$StandingCopyWithImpl<$Res, $Val extends Standing>
    implements $StandingCopyWith<$Res> {
  _$StandingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Standing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rank = null,
    Object? team = null,
    Object? points = null,
    Object? goalsDiff = null,
    Object? group = null,
    Object? form = null,
    Object? status = null,
    Object? description = null,
    Object? all = null,
    Object? home = null,
    Object? away = null,
    Object? update = null,
  }) {
    return _then(_value.copyWith(
      rank: null == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int,
      team: null == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as Team,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      goalsDiff: null == goalsDiff
          ? _value.goalsDiff
          : goalsDiff // ignore: cast_nullable_to_non_nullable
              as int,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String,
      form: null == form
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      all: null == all
          ? _value.all
          : all // ignore: cast_nullable_to_non_nullable
              as MatchStats,
      home: null == home
          ? _value.home
          : home // ignore: cast_nullable_to_non_nullable
              as MatchStats,
      away: null == away
          ? _value.away
          : away // ignore: cast_nullable_to_non_nullable
              as MatchStats,
      update: null == update
          ? _value.update
          : update // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of Standing
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TeamCopyWith<$Res> get team {
    return $TeamCopyWith<$Res>(_value.team, (value) {
      return _then(_value.copyWith(team: value) as $Val);
    });
  }

  /// Create a copy of Standing
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MatchStatsCopyWith<$Res> get all {
    return $MatchStatsCopyWith<$Res>(_value.all, (value) {
      return _then(_value.copyWith(all: value) as $Val);
    });
  }

  /// Create a copy of Standing
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MatchStatsCopyWith<$Res> get home {
    return $MatchStatsCopyWith<$Res>(_value.home, (value) {
      return _then(_value.copyWith(home: value) as $Val);
    });
  }

  /// Create a copy of Standing
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MatchStatsCopyWith<$Res> get away {
    return $MatchStatsCopyWith<$Res>(_value.away, (value) {
      return _then(_value.copyWith(away: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StandingImplCopyWith<$Res>
    implements $StandingCopyWith<$Res> {
  factory _$$StandingImplCopyWith(
          _$StandingImpl value, $Res Function(_$StandingImpl) then) =
      __$$StandingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int rank,
      Team team,
      int points,
      int goalsDiff,
      String group,
      String form,
      String status,
      String description,
      MatchStats all,
      MatchStats home,
      MatchStats away,
      String update});

  @override
  $TeamCopyWith<$Res> get team;
  @override
  $MatchStatsCopyWith<$Res> get all;
  @override
  $MatchStatsCopyWith<$Res> get home;
  @override
  $MatchStatsCopyWith<$Res> get away;
}

/// @nodoc
class __$$StandingImplCopyWithImpl<$Res>
    extends _$StandingCopyWithImpl<$Res, _$StandingImpl>
    implements _$$StandingImplCopyWith<$Res> {
  __$$StandingImplCopyWithImpl(
      _$StandingImpl _value, $Res Function(_$StandingImpl) _then)
      : super(_value, _then);

  /// Create a copy of Standing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rank = null,
    Object? team = null,
    Object? points = null,
    Object? goalsDiff = null,
    Object? group = null,
    Object? form = null,
    Object? status = null,
    Object? description = null,
    Object? all = null,
    Object? home = null,
    Object? away = null,
    Object? update = null,
  }) {
    return _then(_$StandingImpl(
      rank: null == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int,
      team: null == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as Team,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      goalsDiff: null == goalsDiff
          ? _value.goalsDiff
          : goalsDiff // ignore: cast_nullable_to_non_nullable
              as int,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String,
      form: null == form
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      all: null == all
          ? _value.all
          : all // ignore: cast_nullable_to_non_nullable
              as MatchStats,
      home: null == home
          ? _value.home
          : home // ignore: cast_nullable_to_non_nullable
              as MatchStats,
      away: null == away
          ? _value.away
          : away // ignore: cast_nullable_to_non_nullable
              as MatchStats,
      update: null == update
          ? _value.update
          : update // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StandingImpl implements _Standing {
  const _$StandingImpl(
      {required this.rank,
      required this.team,
      required this.points,
      required this.goalsDiff,
      required this.group,
      required this.form,
      required this.status,
      required this.description,
      required this.all,
      required this.home,
      required this.away,
      required this.update});

  factory _$StandingImpl.fromJson(Map<String, dynamic> json) =>
      _$$StandingImplFromJson(json);

  @override
  final int rank;
  @override
  final Team team;
  @override
  final int points;
  @override
  final int goalsDiff;
  @override
  final String group;
  @override
  final String form;
  @override
  final String status;
  @override
  final String description;
  @override
  final MatchStats all;
  @override
  final MatchStats home;
  @override
  final MatchStats away;
  @override
  final String update;

  @override
  String toString() {
    return 'Standing(rank: $rank, team: $team, points: $points, goalsDiff: $goalsDiff, group: $group, form: $form, status: $status, description: $description, all: $all, home: $home, away: $away, update: $update)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StandingImpl &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.team, team) || other.team == team) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.goalsDiff, goalsDiff) ||
                other.goalsDiff == goalsDiff) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.form, form) || other.form == form) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.all, all) || other.all == all) &&
            (identical(other.home, home) || other.home == home) &&
            (identical(other.away, away) || other.away == away) &&
            (identical(other.update, update) || other.update == update));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, rank, team, points, goalsDiff,
      group, form, status, description, all, home, away, update);

  /// Create a copy of Standing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StandingImplCopyWith<_$StandingImpl> get copyWith =>
      __$$StandingImplCopyWithImpl<_$StandingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StandingImplToJson(
      this,
    );
  }
}

abstract class _Standing implements Standing {
  const factory _Standing(
      {required final int rank,
      required final Team team,
      required final int points,
      required final int goalsDiff,
      required final String group,
      required final String form,
      required final String status,
      required final String description,
      required final MatchStats all,
      required final MatchStats home,
      required final MatchStats away,
      required final String update}) = _$StandingImpl;

  factory _Standing.fromJson(Map<String, dynamic> json) =
      _$StandingImpl.fromJson;

  @override
  int get rank;
  @override
  Team get team;
  @override
  int get points;
  @override
  int get goalsDiff;
  @override
  String get group;
  @override
  String get form;
  @override
  String get status;
  @override
  String get description;
  @override
  MatchStats get all;
  @override
  MatchStats get home;
  @override
  MatchStats get away;
  @override
  String get update;

  /// Create a copy of Standing
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StandingImplCopyWith<_$StandingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Team _$TeamFromJson(Map<String, dynamic> json) {
  return _Team.fromJson(json);
}

/// @nodoc
mixin _$Team {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get logo => throw _privateConstructorUsedError;

  /// Serializes this Team to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamCopyWith<Team> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamCopyWith<$Res> {
  factory $TeamCopyWith(Team value, $Res Function(Team) then) =
      _$TeamCopyWithImpl<$Res, Team>;
  @useResult
  $Res call({int id, String name, String logo});
}

/// @nodoc
class _$TeamCopyWithImpl<$Res, $Val extends Team>
    implements $TeamCopyWith<$Res> {
  _$TeamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
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
      logo: null == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamImplCopyWith<$Res> implements $TeamCopyWith<$Res> {
  factory _$$TeamImplCopyWith(
          _$TeamImpl value, $Res Function(_$TeamImpl) then) =
      __$$TeamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String logo});
}

/// @nodoc
class __$$TeamImplCopyWithImpl<$Res>
    extends _$TeamCopyWithImpl<$Res, _$TeamImpl>
    implements _$$TeamImplCopyWith<$Res> {
  __$$TeamImplCopyWithImpl(_$TeamImpl _value, $Res Function(_$TeamImpl) _then)
      : super(_value, _then);

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? logo = null,
  }) {
    return _then(_$TeamImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
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
class _$TeamImpl implements _Team {
  const _$TeamImpl({required this.id, required this.name, required this.logo});

  factory _$TeamImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String logo;

  @override
  String toString() {
    return 'Team(id: $id, name: $name, logo: $logo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.logo, logo) || other.logo == logo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, logo);

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamImplCopyWith<_$TeamImpl> get copyWith =>
      __$$TeamImplCopyWithImpl<_$TeamImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamImplToJson(
      this,
    );
  }
}

abstract class _Team implements Team {
  const factory _Team(
      {required final int id,
      required final String name,
      required final String logo}) = _$TeamImpl;

  factory _Team.fromJson(Map<String, dynamic> json) = _$TeamImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get logo;

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamImplCopyWith<_$TeamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchStats _$MatchStatsFromJson(Map<String, dynamic> json) {
  return _MatchStats.fromJson(json);
}

/// @nodoc
mixin _$MatchStats {
  int get played => throw _privateConstructorUsedError;
  int get win => throw _privateConstructorUsedError;
  int get draw => throw _privateConstructorUsedError;
  int get lose => throw _privateConstructorUsedError;
  Goals get goals => throw _privateConstructorUsedError;

  /// Serializes this MatchStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MatchStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MatchStatsCopyWith<MatchStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchStatsCopyWith<$Res> {
  factory $MatchStatsCopyWith(
          MatchStats value, $Res Function(MatchStats) then) =
      _$MatchStatsCopyWithImpl<$Res, MatchStats>;
  @useResult
  $Res call({int played, int win, int draw, int lose, Goals goals});
}

/// @nodoc
class _$MatchStatsCopyWithImpl<$Res, $Val extends MatchStats>
    implements $MatchStatsCopyWith<$Res> {
  _$MatchStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MatchStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? played = null,
    Object? win = null,
    Object? draw = null,
    Object? lose = null,
    Object? goals = null,
  }) {
    return _then(_value.copyWith(
      played: null == played
          ? _value.played
          : played // ignore: cast_nullable_to_non_nullable
              as int,
      win: null == win
          ? _value.win
          : win // ignore: cast_nullable_to_non_nullable
              as int,
      draw: null == draw
          ? _value.draw
          : draw // ignore: cast_nullable_to_non_nullable
              as int,
      lose: null == lose
          ? _value.lose
          : lose // ignore: cast_nullable_to_non_nullable
              as int,
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as Goals,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchStatsImplCopyWith<$Res>
    implements $MatchStatsCopyWith<$Res> {
  factory _$$MatchStatsImplCopyWith(
          _$MatchStatsImpl value, $Res Function(_$MatchStatsImpl) then) =
      __$$MatchStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int played, int win, int draw, int lose, Goals goals});
}

/// @nodoc
class __$$MatchStatsImplCopyWithImpl<$Res>
    extends _$MatchStatsCopyWithImpl<$Res, _$MatchStatsImpl>
    implements _$$MatchStatsImplCopyWith<$Res> {
  __$$MatchStatsImplCopyWithImpl(
      _$MatchStatsImpl _value, $Res Function(_$MatchStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of MatchStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? played = null,
    Object? win = null,
    Object? draw = null,
    Object? lose = null,
    Object? goals = null,
  }) {
    return _then(_$MatchStatsImpl(
      played: null == played
          ? _value.played
          : played // ignore: cast_nullable_to_non_nullable
              as int,
      win: null == win
          ? _value.win
          : win // ignore: cast_nullable_to_non_nullable
              as int,
      draw: null == draw
          ? _value.draw
          : draw // ignore: cast_nullable_to_non_nullable
              as int,
      lose: null == lose
          ? _value.lose
          : lose // ignore: cast_nullable_to_non_nullable
              as int,
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as Goals,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchStatsImpl implements _MatchStats {
  const _$MatchStatsImpl(
      {required this.played,
      required this.win,
      required this.draw,
      required this.lose,
      required this.goals});

  factory _$MatchStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchStatsImplFromJson(json);

  @override
  final int played;
  @override
  final int win;
  @override
  final int draw;
  @override
  final int lose;
  @override
  final Goals goals;

  @override
  String toString() {
    return 'MatchStats(played: $played, win: $win, draw: $draw, lose: $lose, goals: $goals)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchStatsImpl &&
            (identical(other.played, played) || other.played == played) &&
            (identical(other.win, win) || other.win == win) &&
            (identical(other.draw, draw) || other.draw == draw) &&
            (identical(other.lose, lose) || other.lose == lose) &&
            (identical(other.goals, goals) || other.goals == goals));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, played, win, draw, lose, goals);

  /// Create a copy of MatchStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchStatsImplCopyWith<_$MatchStatsImpl> get copyWith =>
      __$$MatchStatsImplCopyWithImpl<_$MatchStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchStatsImplToJson(
      this,
    );
  }
}

abstract class _MatchStats implements MatchStats {
  const factory _MatchStats(
      {required final int played,
      required final int win,
      required final int draw,
      required final int lose,
      required final Goals goals}) = _$MatchStatsImpl;

  factory _MatchStats.fromJson(Map<String, dynamic> json) =
      _$MatchStatsImpl.fromJson;

  @override
  int get played;
  @override
  int get win;
  @override
  int get draw;
  @override
  int get lose;
  @override
  Goals get goals;

  /// Create a copy of MatchStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchStatsImplCopyWith<_$MatchStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Parameters _$ParametersFromJson(Map<String, dynamic> json) {
  return _Parameters.fromJson(json);
}

/// @nodoc
mixin _$Parameters {
  String get league => throw _privateConstructorUsedError;
  String get season => throw _privateConstructorUsedError;

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
  $Res call({String league, String season});
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
    Object? league = null,
    Object? season = null,
  }) {
    return _then(_value.copyWith(
      league: null == league
          ? _value.league
          : league // ignore: cast_nullable_to_non_nullable
              as String,
      season: null == season
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as String,
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
  $Res call({String league, String season});
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
    Object? league = null,
    Object? season = null,
  }) {
    return _then(_$ParametersImpl(
      league: null == league
          ? _value.league
          : league // ignore: cast_nullable_to_non_nullable
              as String,
      season: null == season
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParametersImpl implements _Parameters {
  const _$ParametersImpl({required this.league, required this.season});

  factory _$ParametersImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParametersImplFromJson(json);

  @override
  final String league;
  @override
  final String season;

  @override
  String toString() {
    return 'Parameters(league: $league, season: $season)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParametersImpl &&
            (identical(other.league, league) || other.league == league) &&
            (identical(other.season, season) || other.season == season));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, league, season);

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
      {required final String league,
      required final String season}) = _$ParametersImpl;

  factory _Parameters.fromJson(Map<String, dynamic> json) =
      _$ParametersImpl.fromJson;

  @override
  String get league;
  @override
  String get season;

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
