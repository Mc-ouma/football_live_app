// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fixture_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FixtureResponse _$FixtureResponseFromJson(Map<String, dynamic> json) {
  return _FixtureResponse.fromJson(json);
}

/// @nodoc
mixin _$FixtureResponse {
  String get get => throw _privateConstructorUsedError;
  Map<String, dynamic> get parameters => throw _privateConstructorUsedError;
  Map<String, dynamic> get errors => throw _privateConstructorUsedError;
  int get results => throw _privateConstructorUsedError;
  int get paging => throw _privateConstructorUsedError;
  List<FixtureData> get response => throw _privateConstructorUsedError;

  /// Serializes this FixtureResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FixtureResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FixtureResponseCopyWith<FixtureResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FixtureResponseCopyWith<$Res> {
  factory $FixtureResponseCopyWith(
          FixtureResponse value, $Res Function(FixtureResponse) then) =
      _$FixtureResponseCopyWithImpl<$Res, FixtureResponse>;
  @useResult
  $Res call(
      {String get,
      Map<String, dynamic> parameters,
      Map<String, dynamic> errors,
      int results,
      int paging,
      List<FixtureData> response});
}

/// @nodoc
class _$FixtureResponseCopyWithImpl<$Res, $Val extends FixtureResponse>
    implements $FixtureResponseCopyWith<$Res> {
  _$FixtureResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FixtureResponse
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
              as Map<String, dynamic>,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as int,
      paging: null == paging
          ? _value.paging
          : paging // ignore: cast_nullable_to_non_nullable
              as int,
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as List<FixtureData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FixtureResponseImplCopyWith<$Res>
    implements $FixtureResponseCopyWith<$Res> {
  factory _$$FixtureResponseImplCopyWith(_$FixtureResponseImpl value,
          $Res Function(_$FixtureResponseImpl) then) =
      __$$FixtureResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String get,
      Map<String, dynamic> parameters,
      Map<String, dynamic> errors,
      int results,
      int paging,
      List<FixtureData> response});
}

/// @nodoc
class __$$FixtureResponseImplCopyWithImpl<$Res>
    extends _$FixtureResponseCopyWithImpl<$Res, _$FixtureResponseImpl>
    implements _$$FixtureResponseImplCopyWith<$Res> {
  __$$FixtureResponseImplCopyWithImpl(
      _$FixtureResponseImpl _value, $Res Function(_$FixtureResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of FixtureResponse
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
    return _then(_$FixtureResponseImpl(
      get: null == get
          ? _value.get
          : get // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: null == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as int,
      paging: null == paging
          ? _value.paging
          : paging // ignore: cast_nullable_to_non_nullable
              as int,
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as List<FixtureData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FixtureResponseImpl implements _FixtureResponse {
  const _$FixtureResponseImpl(
      {required this.get,
      required this.parameters,
      required this.errors,
      required this.results,
      required this.paging,
      required this.response});

  factory _$FixtureResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$FixtureResponseImplFromJson(json);

  @override
  final String get;
  @override
  final Map<String, dynamic> parameters;
  @override
  final Map<String, dynamic> errors;
  @override
  final int results;
  @override
  final int paging;
  @override
  final List<FixtureData> response;

  @override
  String toString() {
    return 'FixtureResponse(get: $get, parameters: $parameters, errors: $errors, results: $results, paging: $paging, response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FixtureResponseImpl &&
            (identical(other.get, get) || other.get == get) &&
            const DeepCollectionEquality()
                .equals(other.parameters, parameters) &&
            const DeepCollectionEquality().equals(other.errors, errors) &&
            (identical(other.results, results) || other.results == results) &&
            (identical(other.paging, paging) || other.paging == paging) &&
            const DeepCollectionEquality().equals(other.response, response));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      get,
      const DeepCollectionEquality().hash(parameters),
      const DeepCollectionEquality().hash(errors),
      results,
      paging,
      const DeepCollectionEquality().hash(response));

  /// Create a copy of FixtureResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FixtureResponseImplCopyWith<_$FixtureResponseImpl> get copyWith =>
      __$$FixtureResponseImplCopyWithImpl<_$FixtureResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FixtureResponseImplToJson(
      this,
    );
  }
}

abstract class _FixtureResponse implements FixtureResponse {
  const factory _FixtureResponse(
      {required final String get,
      required final Map<String, dynamic> parameters,
      required final Map<String, dynamic> errors,
      required final int results,
      required final int paging,
      required final List<FixtureData> response}) = _$FixtureResponseImpl;

  factory _FixtureResponse.fromJson(Map<String, dynamic> json) =
      _$FixtureResponseImpl.fromJson;

  @override
  String get get;
  @override
  Map<String, dynamic> get parameters;
  @override
  Map<String, dynamic> get errors;
  @override
  int get results;
  @override
  int get paging;
  @override
  List<FixtureData> get response;

  /// Create a copy of FixtureResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FixtureResponseImplCopyWith<_$FixtureResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FixtureData {
  Fixture get fixture => throw _privateConstructorUsedError;
  League get league => throw _privateConstructorUsedError;
  Teams get teams => throw _privateConstructorUsedError;
  Goals get goals => throw _privateConstructorUsedError;
  Score get score => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(Fixture fixture, League league, Teams teams, Goals goals,
            Score score)
        $default, {
    required TResult Function(
            Fixture fixture,
            League league,
            Teams teams,
            Goals goals,
            Score score,
            List<Event>? events,
            List<LineupData>? lineups,
            Statistics? statistics,
            List<PlayerStatistics>? players)
        detailed,
    required TResult Function(Fixture fixture, League league, Teams teams,
            Goals goals, Score score, List<Event> events)
        live,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(Fixture fixture, League league, Teams teams, Goals goals,
            Score score)?
        $default, {
    TResult? Function(
            Fixture fixture,
            League league,
            Teams teams,
            Goals goals,
            Score score,
            List<Event>? events,
            List<LineupData>? lineups,
            Statistics? statistics,
            List<PlayerStatistics>? players)?
        detailed,
    TResult? Function(Fixture fixture, League league, Teams teams, Goals goals,
            Score score, List<Event> events)?
        live,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(Fixture fixture, League league, Teams teams, Goals goals,
            Score score)?
        $default, {
    TResult Function(
            Fixture fixture,
            League league,
            Teams teams,
            Goals goals,
            Score score,
            List<Event>? events,
            List<LineupData>? lineups,
            Statistics? statistics,
            List<PlayerStatistics>? players)?
        detailed,
    TResult Function(Fixture fixture, League league, Teams teams, Goals goals,
            Score score, List<Event> events)?
        live,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_FixtureData value) $default, {
    required TResult Function(_FixtureDataDetailed value) detailed,
    required TResult Function(_FixtureDataLive value) live,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_FixtureData value)? $default, {
    TResult? Function(_FixtureDataDetailed value)? detailed,
    TResult? Function(_FixtureDataLive value)? live,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_FixtureData value)? $default, {
    TResult Function(_FixtureDataDetailed value)? detailed,
    TResult Function(_FixtureDataLive value)? live,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of FixtureData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FixtureDataCopyWith<FixtureData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FixtureDataCopyWith<$Res> {
  factory $FixtureDataCopyWith(
          FixtureData value, $Res Function(FixtureData) then) =
      _$FixtureDataCopyWithImpl<$Res, FixtureData>;
  @useResult
  $Res call(
      {Fixture fixture, League league, Teams teams, Goals goals, Score score});

  $FixtureCopyWith<$Res> get fixture;
  $LeagueCopyWith<$Res> get league;
  $TeamsCopyWith<$Res> get teams;
  $GoalsCopyWith<$Res> get goals;
  $ScoreCopyWith<$Res> get score;
}

/// @nodoc
class _$FixtureDataCopyWithImpl<$Res, $Val extends FixtureData>
    implements $FixtureDataCopyWith<$Res> {
  _$FixtureDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FixtureData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fixture = null,
    Object? league = null,
    Object? teams = null,
    Object? goals = null,
    Object? score = null,
  }) {
    return _then(_value.copyWith(
      fixture: null == fixture
          ? _value.fixture
          : fixture // ignore: cast_nullable_to_non_nullable
              as Fixture,
      league: null == league
          ? _value.league
          : league // ignore: cast_nullable_to_non_nullable
              as League,
      teams: null == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as Teams,
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as Goals,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as Score,
    ) as $Val);
  }

  /// Create a copy of FixtureData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FixtureCopyWith<$Res> get fixture {
    return $FixtureCopyWith<$Res>(_value.fixture, (value) {
      return _then(_value.copyWith(fixture: value) as $Val);
    });
  }

  /// Create a copy of FixtureData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LeagueCopyWith<$Res> get league {
    return $LeagueCopyWith<$Res>(_value.league, (value) {
      return _then(_value.copyWith(league: value) as $Val);
    });
  }

  /// Create a copy of FixtureData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TeamsCopyWith<$Res> get teams {
    return $TeamsCopyWith<$Res>(_value.teams, (value) {
      return _then(_value.copyWith(teams: value) as $Val);
    });
  }

  /// Create a copy of FixtureData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GoalsCopyWith<$Res> get goals {
    return $GoalsCopyWith<$Res>(_value.goals, (value) {
      return _then(_value.copyWith(goals: value) as $Val);
    });
  }

  /// Create a copy of FixtureData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ScoreCopyWith<$Res> get score {
    return $ScoreCopyWith<$Res>(_value.score, (value) {
      return _then(_value.copyWith(score: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FixtureDataImplCopyWith<$Res>
    implements $FixtureDataCopyWith<$Res> {
  factory _$$FixtureDataImplCopyWith(
          _$FixtureDataImpl value, $Res Function(_$FixtureDataImpl) then) =
      __$$FixtureDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Fixture fixture, League league, Teams teams, Goals goals, Score score});

  @override
  $FixtureCopyWith<$Res> get fixture;
  @override
  $LeagueCopyWith<$Res> get league;
  @override
  $TeamsCopyWith<$Res> get teams;
  @override
  $GoalsCopyWith<$Res> get goals;
  @override
  $ScoreCopyWith<$Res> get score;
}

/// @nodoc
class __$$FixtureDataImplCopyWithImpl<$Res>
    extends _$FixtureDataCopyWithImpl<$Res, _$FixtureDataImpl>
    implements _$$FixtureDataImplCopyWith<$Res> {
  __$$FixtureDataImplCopyWithImpl(
      _$FixtureDataImpl _value, $Res Function(_$FixtureDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of FixtureData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fixture = null,
    Object? league = null,
    Object? teams = null,
    Object? goals = null,
    Object? score = null,
  }) {
    return _then(_$FixtureDataImpl(
      fixture: null == fixture
          ? _value.fixture
          : fixture // ignore: cast_nullable_to_non_nullable
              as Fixture,
      league: null == league
          ? _value.league
          : league // ignore: cast_nullable_to_non_nullable
              as League,
      teams: null == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as Teams,
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as Goals,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as Score,
    ));
  }
}

/// @nodoc

class _$FixtureDataImpl implements _FixtureData {
  const _$FixtureDataImpl(
      {required this.fixture,
      required this.league,
      required this.teams,
      required this.goals,
      required this.score});

  @override
  final Fixture fixture;
  @override
  final League league;
  @override
  final Teams teams;
  @override
  final Goals goals;
  @override
  final Score score;

  @override
  String toString() {
    return 'FixtureData(fixture: $fixture, league: $league, teams: $teams, goals: $goals, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FixtureDataImpl &&
            (identical(other.fixture, fixture) || other.fixture == fixture) &&
            (identical(other.league, league) || other.league == league) &&
            (identical(other.teams, teams) || other.teams == teams) &&
            (identical(other.goals, goals) || other.goals == goals) &&
            (identical(other.score, score) || other.score == score));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, fixture, league, teams, goals, score);

  /// Create a copy of FixtureData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FixtureDataImplCopyWith<_$FixtureDataImpl> get copyWith =>
      __$$FixtureDataImplCopyWithImpl<_$FixtureDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(Fixture fixture, League league, Teams teams, Goals goals,
            Score score)
        $default, {
    required TResult Function(
            Fixture fixture,
            League league,
            Teams teams,
            Goals goals,
            Score score,
            List<Event>? events,
            List<LineupData>? lineups,
            Statistics? statistics,
            List<PlayerStatistics>? players)
        detailed,
    required TResult Function(Fixture fixture, League league, Teams teams,
            Goals goals, Score score, List<Event> events)
        live,
  }) {
    return $default(fixture, league, teams, goals, score);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(Fixture fixture, League league, Teams teams, Goals goals,
            Score score)?
        $default, {
    TResult? Function(
            Fixture fixture,
            League league,
            Teams teams,
            Goals goals,
            Score score,
            List<Event>? events,
            List<LineupData>? lineups,
            Statistics? statistics,
            List<PlayerStatistics>? players)?
        detailed,
    TResult? Function(Fixture fixture, League league, Teams teams, Goals goals,
            Score score, List<Event> events)?
        live,
  }) {
    return $default?.call(fixture, league, teams, goals, score);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(Fixture fixture, League league, Teams teams, Goals goals,
            Score score)?
        $default, {
    TResult Function(
            Fixture fixture,
            League league,
            Teams teams,
            Goals goals,
            Score score,
            List<Event>? events,
            List<LineupData>? lineups,
            Statistics? statistics,
            List<PlayerStatistics>? players)?
        detailed,
    TResult Function(Fixture fixture, League league, Teams teams, Goals goals,
            Score score, List<Event> events)?
        live,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(fixture, league, teams, goals, score);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_FixtureData value) $default, {
    required TResult Function(_FixtureDataDetailed value) detailed,
    required TResult Function(_FixtureDataLive value) live,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_FixtureData value)? $default, {
    TResult? Function(_FixtureDataDetailed value)? detailed,
    TResult? Function(_FixtureDataLive value)? live,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_FixtureData value)? $default, {
    TResult Function(_FixtureDataDetailed value)? detailed,
    TResult Function(_FixtureDataLive value)? live,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _FixtureData implements FixtureData {
  const factory _FixtureData(
      {required final Fixture fixture,
      required final League league,
      required final Teams teams,
      required final Goals goals,
      required final Score score}) = _$FixtureDataImpl;

  @override
  Fixture get fixture;
  @override
  League get league;
  @override
  Teams get teams;
  @override
  Goals get goals;
  @override
  Score get score;

  /// Create a copy of FixtureData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FixtureDataImplCopyWith<_$FixtureDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FixtureDataDetailedImplCopyWith<$Res>
    implements $FixtureDataCopyWith<$Res> {
  factory _$$FixtureDataDetailedImplCopyWith(_$FixtureDataDetailedImpl value,
          $Res Function(_$FixtureDataDetailedImpl) then) =
      __$$FixtureDataDetailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Fixture fixture,
      League league,
      Teams teams,
      Goals goals,
      Score score,
      List<Event>? events,
      List<LineupData>? lineups,
      Statistics? statistics,
      List<PlayerStatistics>? players});

  @override
  $FixtureCopyWith<$Res> get fixture;
  @override
  $LeagueCopyWith<$Res> get league;
  @override
  $TeamsCopyWith<$Res> get teams;
  @override
  $GoalsCopyWith<$Res> get goals;
  @override
  $ScoreCopyWith<$Res> get score;
  $StatisticsCopyWith<$Res>? get statistics;
}

/// @nodoc
class __$$FixtureDataDetailedImplCopyWithImpl<$Res>
    extends _$FixtureDataCopyWithImpl<$Res, _$FixtureDataDetailedImpl>
    implements _$$FixtureDataDetailedImplCopyWith<$Res> {
  __$$FixtureDataDetailedImplCopyWithImpl(_$FixtureDataDetailedImpl _value,
      $Res Function(_$FixtureDataDetailedImpl) _then)
      : super(_value, _then);

  /// Create a copy of FixtureData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fixture = null,
    Object? league = null,
    Object? teams = null,
    Object? goals = null,
    Object? score = null,
    Object? events = freezed,
    Object? lineups = freezed,
    Object? statistics = freezed,
    Object? players = freezed,
  }) {
    return _then(_$FixtureDataDetailedImpl(
      fixture: null == fixture
          ? _value.fixture
          : fixture // ignore: cast_nullable_to_non_nullable
              as Fixture,
      league: null == league
          ? _value.league
          : league // ignore: cast_nullable_to_non_nullable
              as League,
      teams: null == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as Teams,
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as Goals,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as Score,
      events: freezed == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as List<Event>?,
      lineups: freezed == lineups
          ? _value.lineups
          : lineups // ignore: cast_nullable_to_non_nullable
              as List<LineupData>?,
      statistics: freezed == statistics
          ? _value.statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as Statistics?,
      players: freezed == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<PlayerStatistics>?,
    ));
  }

  /// Create a copy of FixtureData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StatisticsCopyWith<$Res>? get statistics {
    if (_value.statistics == null) {
      return null;
    }

    return $StatisticsCopyWith<$Res>(_value.statistics!, (value) {
      return _then(_value.copyWith(statistics: value));
    });
  }
}

/// @nodoc

class _$FixtureDataDetailedImpl implements _FixtureDataDetailed {
  const _$FixtureDataDetailedImpl(
      {required this.fixture,
      required this.league,
      required this.teams,
      required this.goals,
      required this.score,
      this.events,
      this.lineups,
      this.statistics,
      this.players});

  @override
  final Fixture fixture;
  @override
  final League league;
  @override
  final Teams teams;
  @override
  final Goals goals;
  @override
  final Score score;
  @override
  final List<Event>? events;
  @override
  final List<LineupData>? lineups;
  @override
  final Statistics? statistics;
  @override
  final List<PlayerStatistics>? players;

  @override
  String toString() {
    return 'FixtureData.detailed(fixture: $fixture, league: $league, teams: $teams, goals: $goals, score: $score, events: $events, lineups: $lineups, statistics: $statistics, players: $players)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FixtureDataDetailedImpl &&
            (identical(other.fixture, fixture) || other.fixture == fixture) &&
            (identical(other.league, league) || other.league == league) &&
            (identical(other.teams, teams) || other.teams == teams) &&
            (identical(other.goals, goals) || other.goals == goals) &&
            (identical(other.score, score) || other.score == score) &&
            const DeepCollectionEquality().equals(other.events, events) &&
            const DeepCollectionEquality().equals(other.lineups, lineups) &&
            (identical(other.statistics, statistics) ||
                other.statistics == statistics) &&
            const DeepCollectionEquality().equals(other.players, players));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      fixture,
      league,
      teams,
      goals,
      score,
      const DeepCollectionEquality().hash(events),
      const DeepCollectionEquality().hash(lineups),
      statistics,
      const DeepCollectionEquality().hash(players));

  /// Create a copy of FixtureData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FixtureDataDetailedImplCopyWith<_$FixtureDataDetailedImpl> get copyWith =>
      __$$FixtureDataDetailedImplCopyWithImpl<_$FixtureDataDetailedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(Fixture fixture, League league, Teams teams, Goals goals,
            Score score)
        $default, {
    required TResult Function(
            Fixture fixture,
            League league,
            Teams teams,
            Goals goals,
            Score score,
            List<Event>? events,
            List<LineupData>? lineups,
            Statistics? statistics,
            List<PlayerStatistics>? players)
        detailed,
    required TResult Function(Fixture fixture, League league, Teams teams,
            Goals goals, Score score, List<Event> events)
        live,
  }) {
    return detailed(fixture, league, teams, goals, score, events, lineups,
        statistics, players);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(Fixture fixture, League league, Teams teams, Goals goals,
            Score score)?
        $default, {
    TResult? Function(
            Fixture fixture,
            League league,
            Teams teams,
            Goals goals,
            Score score,
            List<Event>? events,
            List<LineupData>? lineups,
            Statistics? statistics,
            List<PlayerStatistics>? players)?
        detailed,
    TResult? Function(Fixture fixture, League league, Teams teams, Goals goals,
            Score score, List<Event> events)?
        live,
  }) {
    return detailed?.call(fixture, league, teams, goals, score, events, lineups,
        statistics, players);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(Fixture fixture, League league, Teams teams, Goals goals,
            Score score)?
        $default, {
    TResult Function(
            Fixture fixture,
            League league,
            Teams teams,
            Goals goals,
            Score score,
            List<Event>? events,
            List<LineupData>? lineups,
            Statistics? statistics,
            List<PlayerStatistics>? players)?
        detailed,
    TResult Function(Fixture fixture, League league, Teams teams, Goals goals,
            Score score, List<Event> events)?
        live,
    required TResult orElse(),
  }) {
    if (detailed != null) {
      return detailed(fixture, league, teams, goals, score, events, lineups,
          statistics, players);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_FixtureData value) $default, {
    required TResult Function(_FixtureDataDetailed value) detailed,
    required TResult Function(_FixtureDataLive value) live,
  }) {
    return detailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_FixtureData value)? $default, {
    TResult? Function(_FixtureDataDetailed value)? detailed,
    TResult? Function(_FixtureDataLive value)? live,
  }) {
    return detailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_FixtureData value)? $default, {
    TResult Function(_FixtureDataDetailed value)? detailed,
    TResult Function(_FixtureDataLive value)? live,
    required TResult orElse(),
  }) {
    if (detailed != null) {
      return detailed(this);
    }
    return orElse();
  }
}

abstract class _FixtureDataDetailed implements FixtureData {
  const factory _FixtureDataDetailed(
      {required final Fixture fixture,
      required final League league,
      required final Teams teams,
      required final Goals goals,
      required final Score score,
      final List<Event>? events,
      final List<LineupData>? lineups,
      final Statistics? statistics,
      final List<PlayerStatistics>? players}) = _$FixtureDataDetailedImpl;

  @override
  Fixture get fixture;
  @override
  League get league;
  @override
  Teams get teams;
  @override
  Goals get goals;
  @override
  Score get score;
  List<Event>? get events;
  List<LineupData>? get lineups;
  Statistics? get statistics;
  List<PlayerStatistics>? get players;

  /// Create a copy of FixtureData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FixtureDataDetailedImplCopyWith<_$FixtureDataDetailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FixtureDataLiveImplCopyWith<$Res>
    implements $FixtureDataCopyWith<$Res> {
  factory _$$FixtureDataLiveImplCopyWith(_$FixtureDataLiveImpl value,
          $Res Function(_$FixtureDataLiveImpl) then) =
      __$$FixtureDataLiveImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Fixture fixture,
      League league,
      Teams teams,
      Goals goals,
      Score score,
      List<Event> events});

  @override
  $FixtureCopyWith<$Res> get fixture;
  @override
  $LeagueCopyWith<$Res> get league;
  @override
  $TeamsCopyWith<$Res> get teams;
  @override
  $GoalsCopyWith<$Res> get goals;
  @override
  $ScoreCopyWith<$Res> get score;
}

/// @nodoc
class __$$FixtureDataLiveImplCopyWithImpl<$Res>
    extends _$FixtureDataCopyWithImpl<$Res, _$FixtureDataLiveImpl>
    implements _$$FixtureDataLiveImplCopyWith<$Res> {
  __$$FixtureDataLiveImplCopyWithImpl(
      _$FixtureDataLiveImpl _value, $Res Function(_$FixtureDataLiveImpl) _then)
      : super(_value, _then);

  /// Create a copy of FixtureData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fixture = null,
    Object? league = null,
    Object? teams = null,
    Object? goals = null,
    Object? score = null,
    Object? events = null,
  }) {
    return _then(_$FixtureDataLiveImpl(
      fixture: null == fixture
          ? _value.fixture
          : fixture // ignore: cast_nullable_to_non_nullable
              as Fixture,
      league: null == league
          ? _value.league
          : league // ignore: cast_nullable_to_non_nullable
              as League,
      teams: null == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as Teams,
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as Goals,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as Score,
      events: null == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as List<Event>,
    ));
  }
}

/// @nodoc

class _$FixtureDataLiveImpl implements _FixtureDataLive {
  const _$FixtureDataLiveImpl(
      {required this.fixture,
      required this.league,
      required this.teams,
      required this.goals,
      required this.score,
      required this.events});

  @override
  final Fixture fixture;
  @override
  final League league;
  @override
  final Teams teams;
  @override
  final Goals goals;
  @override
  final Score score;
  @override
  final List<Event> events;

  @override
  String toString() {
    return 'FixtureData.live(fixture: $fixture, league: $league, teams: $teams, goals: $goals, score: $score, events: $events)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FixtureDataLiveImpl &&
            (identical(other.fixture, fixture) || other.fixture == fixture) &&
            (identical(other.league, league) || other.league == league) &&
            (identical(other.teams, teams) || other.teams == teams) &&
            (identical(other.goals, goals) || other.goals == goals) &&
            (identical(other.score, score) || other.score == score) &&
            const DeepCollectionEquality().equals(other.events, events));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fixture, league, teams, goals,
      score, const DeepCollectionEquality().hash(events));

  /// Create a copy of FixtureData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FixtureDataLiveImplCopyWith<_$FixtureDataLiveImpl> get copyWith =>
      __$$FixtureDataLiveImplCopyWithImpl<_$FixtureDataLiveImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(Fixture fixture, League league, Teams teams, Goals goals,
            Score score)
        $default, {
    required TResult Function(
            Fixture fixture,
            League league,
            Teams teams,
            Goals goals,
            Score score,
            List<Event>? events,
            List<LineupData>? lineups,
            Statistics? statistics,
            List<PlayerStatistics>? players)
        detailed,
    required TResult Function(Fixture fixture, League league, Teams teams,
            Goals goals, Score score, List<Event> events)
        live,
  }) {
    return live(fixture, league, teams, goals, score, events);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(Fixture fixture, League league, Teams teams, Goals goals,
            Score score)?
        $default, {
    TResult? Function(
            Fixture fixture,
            League league,
            Teams teams,
            Goals goals,
            Score score,
            List<Event>? events,
            List<LineupData>? lineups,
            Statistics? statistics,
            List<PlayerStatistics>? players)?
        detailed,
    TResult? Function(Fixture fixture, League league, Teams teams, Goals goals,
            Score score, List<Event> events)?
        live,
  }) {
    return live?.call(fixture, league, teams, goals, score, events);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(Fixture fixture, League league, Teams teams, Goals goals,
            Score score)?
        $default, {
    TResult Function(
            Fixture fixture,
            League league,
            Teams teams,
            Goals goals,
            Score score,
            List<Event>? events,
            List<LineupData>? lineups,
            Statistics? statistics,
            List<PlayerStatistics>? players)?
        detailed,
    TResult Function(Fixture fixture, League league, Teams teams, Goals goals,
            Score score, List<Event> events)?
        live,
    required TResult orElse(),
  }) {
    if (live != null) {
      return live(fixture, league, teams, goals, score, events);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_FixtureData value) $default, {
    required TResult Function(_FixtureDataDetailed value) detailed,
    required TResult Function(_FixtureDataLive value) live,
  }) {
    return live(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_FixtureData value)? $default, {
    TResult? Function(_FixtureDataDetailed value)? detailed,
    TResult? Function(_FixtureDataLive value)? live,
  }) {
    return live?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_FixtureData value)? $default, {
    TResult Function(_FixtureDataDetailed value)? detailed,
    TResult Function(_FixtureDataLive value)? live,
    required TResult orElse(),
  }) {
    if (live != null) {
      return live(this);
    }
    return orElse();
  }
}

abstract class _FixtureDataLive implements FixtureData {
  const factory _FixtureDataLive(
      {required final Fixture fixture,
      required final League league,
      required final Teams teams,
      required final Goals goals,
      required final Score score,
      required final List<Event> events}) = _$FixtureDataLiveImpl;

  @override
  Fixture get fixture;
  @override
  League get league;
  @override
  Teams get teams;
  @override
  Goals get goals;
  @override
  Score get score;
  List<Event> get events;

  /// Create a copy of FixtureData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FixtureDataLiveImplCopyWith<_$FixtureDataLiveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Event _$EventFromJson(Map<String, dynamic> json) {
  return _Event.fromJson(json);
}

/// @nodoc
mixin _$Event {
  Time get time => throw _privateConstructorUsedError;
  Team get team => throw _privateConstructorUsedError;
  Player get player => throw _privateConstructorUsedError;
  Player? get assist => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get detail => throw _privateConstructorUsedError;
  String? get comments => throw _privateConstructorUsedError;

  /// Serializes this Event to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventCopyWith<Event> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCopyWith<$Res> {
  factory $EventCopyWith(Event value, $Res Function(Event) then) =
      _$EventCopyWithImpl<$Res, Event>;
  @useResult
  $Res call(
      {Time time,
      Team team,
      Player player,
      Player? assist,
      String type,
      String detail,
      String? comments});

  $TimeCopyWith<$Res> get time;
  $TeamCopyWith<$Res> get team;
  $PlayerCopyWith<$Res> get player;
  $PlayerCopyWith<$Res>? get assist;
}

/// @nodoc
class _$EventCopyWithImpl<$Res, $Val extends Event>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? team = null,
    Object? player = null,
    Object? assist = freezed,
    Object? type = null,
    Object? detail = null,
    Object? comments = freezed,
  }) {
    return _then(_value.copyWith(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as Time,
      team: null == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as Team,
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as Player,
      assist: freezed == assist
          ? _value.assist
          : assist // ignore: cast_nullable_to_non_nullable
              as Player?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      detail: null == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as String,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimeCopyWith<$Res> get time {
    return $TimeCopyWith<$Res>(_value.time, (value) {
      return _then(_value.copyWith(time: value) as $Val);
    });
  }

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TeamCopyWith<$Res> get team {
    return $TeamCopyWith<$Res>(_value.team, (value) {
      return _then(_value.copyWith(team: value) as $Val);
    });
  }

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayerCopyWith<$Res> get player {
    return $PlayerCopyWith<$Res>(_value.player, (value) {
      return _then(_value.copyWith(player: value) as $Val);
    });
  }

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayerCopyWith<$Res>? get assist {
    if (_value.assist == null) {
      return null;
    }

    return $PlayerCopyWith<$Res>(_value.assist!, (value) {
      return _then(_value.copyWith(assist: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EventImplCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$$EventImplCopyWith(
          _$EventImpl value, $Res Function(_$EventImpl) then) =
      __$$EventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Time time,
      Team team,
      Player player,
      Player? assist,
      String type,
      String detail,
      String? comments});

  @override
  $TimeCopyWith<$Res> get time;
  @override
  $TeamCopyWith<$Res> get team;
  @override
  $PlayerCopyWith<$Res> get player;
  @override
  $PlayerCopyWith<$Res>? get assist;
}

/// @nodoc
class __$$EventImplCopyWithImpl<$Res>
    extends _$EventCopyWithImpl<$Res, _$EventImpl>
    implements _$$EventImplCopyWith<$Res> {
  __$$EventImplCopyWithImpl(
      _$EventImpl _value, $Res Function(_$EventImpl) _then)
      : super(_value, _then);

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? team = null,
    Object? player = null,
    Object? assist = freezed,
    Object? type = null,
    Object? detail = null,
    Object? comments = freezed,
  }) {
    return _then(_$EventImpl(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as Time,
      team: null == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as Team,
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as Player,
      assist: freezed == assist
          ? _value.assist
          : assist // ignore: cast_nullable_to_non_nullable
              as Player?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      detail: null == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as String,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventImpl implements _Event {
  const _$EventImpl(
      {required this.time,
      required this.team,
      required this.player,
      this.assist,
      required this.type,
      required this.detail,
      this.comments});

  factory _$EventImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventImplFromJson(json);

  @override
  final Time time;
  @override
  final Team team;
  @override
  final Player player;
  @override
  final Player? assist;
  @override
  final String type;
  @override
  final String detail;
  @override
  final String? comments;

  @override
  String toString() {
    return 'Event(time: $time, team: $team, player: $player, assist: $assist, type: $type, detail: $detail, comments: $comments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventImpl &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.team, team) || other.team == team) &&
            (identical(other.player, player) || other.player == player) &&
            (identical(other.assist, assist) || other.assist == assist) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.detail, detail) || other.detail == detail) &&
            (identical(other.comments, comments) ||
                other.comments == comments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, time, team, player, assist, type, detail, comments);

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      __$$EventImplCopyWithImpl<_$EventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventImplToJson(
      this,
    );
  }
}

abstract class _Event implements Event {
  const factory _Event(
      {required final Time time,
      required final Team team,
      required final Player player,
      final Player? assist,
      required final String type,
      required final String detail,
      final String? comments}) = _$EventImpl;

  factory _Event.fromJson(Map<String, dynamic> json) = _$EventImpl.fromJson;

  @override
  Time get time;
  @override
  Team get team;
  @override
  Player get player;
  @override
  Player? get assist;
  @override
  String get type;
  @override
  String get detail;
  @override
  String? get comments;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Time _$TimeFromJson(Map<String, dynamic> json) {
  return _Time.fromJson(json);
}

/// @nodoc
mixin _$Time {
  int get elapsed => throw _privateConstructorUsedError;
  int? get extra => throw _privateConstructorUsedError;

  /// Serializes this Time to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Time
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimeCopyWith<Time> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeCopyWith<$Res> {
  factory $TimeCopyWith(Time value, $Res Function(Time) then) =
      _$TimeCopyWithImpl<$Res, Time>;
  @useResult
  $Res call({int elapsed, int? extra});
}

/// @nodoc
class _$TimeCopyWithImpl<$Res, $Val extends Time>
    implements $TimeCopyWith<$Res> {
  _$TimeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Time
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? elapsed = null,
    Object? extra = freezed,
  }) {
    return _then(_value.copyWith(
      elapsed: null == elapsed
          ? _value.elapsed
          : elapsed // ignore: cast_nullable_to_non_nullable
              as int,
      extra: freezed == extra
          ? _value.extra
          : extra // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeImplCopyWith<$Res> implements $TimeCopyWith<$Res> {
  factory _$$TimeImplCopyWith(
          _$TimeImpl value, $Res Function(_$TimeImpl) then) =
      __$$TimeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int elapsed, int? extra});
}

/// @nodoc
class __$$TimeImplCopyWithImpl<$Res>
    extends _$TimeCopyWithImpl<$Res, _$TimeImpl>
    implements _$$TimeImplCopyWith<$Res> {
  __$$TimeImplCopyWithImpl(_$TimeImpl _value, $Res Function(_$TimeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Time
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? elapsed = null,
    Object? extra = freezed,
  }) {
    return _then(_$TimeImpl(
      elapsed: null == elapsed
          ? _value.elapsed
          : elapsed // ignore: cast_nullable_to_non_nullable
              as int,
      extra: freezed == extra
          ? _value.extra
          : extra // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeImpl implements _Time {
  const _$TimeImpl({required this.elapsed, this.extra});

  factory _$TimeImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeImplFromJson(json);

  @override
  final int elapsed;
  @override
  final int? extra;

  @override
  String toString() {
    return 'Time(elapsed: $elapsed, extra: $extra)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeImpl &&
            (identical(other.elapsed, elapsed) || other.elapsed == elapsed) &&
            (identical(other.extra, extra) || other.extra == extra));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, elapsed, extra);

  /// Create a copy of Time
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeImplCopyWith<_$TimeImpl> get copyWith =>
      __$$TimeImplCopyWithImpl<_$TimeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeImplToJson(
      this,
    );
  }
}

abstract class _Time implements Time {
  const factory _Time({required final int elapsed, final int? extra}) =
      _$TimeImpl;

  factory _Time.fromJson(Map<String, dynamic> json) = _$TimeImpl.fromJson;

  @override
  int get elapsed;
  @override
  int? get extra;

  /// Create a copy of Time
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeImplCopyWith<_$TimeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Player _$PlayerFromJson(Map<String, dynamic> json) {
  return _Player.fromJson(json);
}

/// @nodoc
mixin _$Player {
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this Player to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerCopyWith<Player> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerCopyWith<$Res> {
  factory $PlayerCopyWith(Player value, $Res Function(Player) then) =
      _$PlayerCopyWithImpl<$Res, Player>;
  @useResult
  $Res call({int? id, String name});
}

/// @nodoc
class _$PlayerCopyWithImpl<$Res, $Val extends Player>
    implements $PlayerCopyWith<$Res> {
  _$PlayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerImplCopyWith<$Res> implements $PlayerCopyWith<$Res> {
  factory _$$PlayerImplCopyWith(
          _$PlayerImpl value, $Res Function(_$PlayerImpl) then) =
      __$$PlayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String name});
}

/// @nodoc
class __$$PlayerImplCopyWithImpl<$Res>
    extends _$PlayerCopyWithImpl<$Res, _$PlayerImpl>
    implements _$$PlayerImplCopyWith<$Res> {
  __$$PlayerImplCopyWithImpl(
      _$PlayerImpl _value, $Res Function(_$PlayerImpl) _then)
      : super(_value, _then);

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
  }) {
    return _then(_$PlayerImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerImpl implements _Player {
  const _$PlayerImpl({this.id, required this.name});

  factory _$PlayerImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerImplFromJson(json);

  @override
  final int? id;
  @override
  final String name;

  @override
  String toString() {
    return 'Player(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerImplCopyWith<_$PlayerImpl> get copyWith =>
      __$$PlayerImplCopyWithImpl<_$PlayerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerImplToJson(
      this,
    );
  }
}

abstract class _Player implements Player {
  const factory _Player({final int? id, required final String name}) =
      _$PlayerImpl;

  factory _Player.fromJson(Map<String, dynamic> json) = _$PlayerImpl.fromJson;

  @override
  int? get id;
  @override
  String get name;

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerImplCopyWith<_$PlayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LineupData _$LineupDataFromJson(Map<String, dynamic> json) {
  return _LineupData.fromJson(json);
}

/// @nodoc
mixin _$LineupData {
  Team get team => throw _privateConstructorUsedError;
  Coach get coach => throw _privateConstructorUsedError;
  String get formation => throw _privateConstructorUsedError;
  List<StartXI> get startXI => throw _privateConstructorUsedError;
  List<StartXI> get substitutes => throw _privateConstructorUsedError;

  /// Serializes this LineupData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LineupData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LineupDataCopyWith<LineupData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LineupDataCopyWith<$Res> {
  factory $LineupDataCopyWith(
          LineupData value, $Res Function(LineupData) then) =
      _$LineupDataCopyWithImpl<$Res, LineupData>;
  @useResult
  $Res call(
      {Team team,
      Coach coach,
      String formation,
      List<StartXI> startXI,
      List<StartXI> substitutes});

  $TeamCopyWith<$Res> get team;
  $CoachCopyWith<$Res> get coach;
}

/// @nodoc
class _$LineupDataCopyWithImpl<$Res, $Val extends LineupData>
    implements $LineupDataCopyWith<$Res> {
  _$LineupDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LineupData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? team = null,
    Object? coach = null,
    Object? formation = null,
    Object? startXI = null,
    Object? substitutes = null,
  }) {
    return _then(_value.copyWith(
      team: null == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as Team,
      coach: null == coach
          ? _value.coach
          : coach // ignore: cast_nullable_to_non_nullable
              as Coach,
      formation: null == formation
          ? _value.formation
          : formation // ignore: cast_nullable_to_non_nullable
              as String,
      startXI: null == startXI
          ? _value.startXI
          : startXI // ignore: cast_nullable_to_non_nullable
              as List<StartXI>,
      substitutes: null == substitutes
          ? _value.substitutes
          : substitutes // ignore: cast_nullable_to_non_nullable
              as List<StartXI>,
    ) as $Val);
  }

  /// Create a copy of LineupData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TeamCopyWith<$Res> get team {
    return $TeamCopyWith<$Res>(_value.team, (value) {
      return _then(_value.copyWith(team: value) as $Val);
    });
  }

  /// Create a copy of LineupData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CoachCopyWith<$Res> get coach {
    return $CoachCopyWith<$Res>(_value.coach, (value) {
      return _then(_value.copyWith(coach: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LineupDataImplCopyWith<$Res>
    implements $LineupDataCopyWith<$Res> {
  factory _$$LineupDataImplCopyWith(
          _$LineupDataImpl value, $Res Function(_$LineupDataImpl) then) =
      __$$LineupDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Team team,
      Coach coach,
      String formation,
      List<StartXI> startXI,
      List<StartXI> substitutes});

  @override
  $TeamCopyWith<$Res> get team;
  @override
  $CoachCopyWith<$Res> get coach;
}

/// @nodoc
class __$$LineupDataImplCopyWithImpl<$Res>
    extends _$LineupDataCopyWithImpl<$Res, _$LineupDataImpl>
    implements _$$LineupDataImplCopyWith<$Res> {
  __$$LineupDataImplCopyWithImpl(
      _$LineupDataImpl _value, $Res Function(_$LineupDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of LineupData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? team = null,
    Object? coach = null,
    Object? formation = null,
    Object? startXI = null,
    Object? substitutes = null,
  }) {
    return _then(_$LineupDataImpl(
      team: null == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as Team,
      coach: null == coach
          ? _value.coach
          : coach // ignore: cast_nullable_to_non_nullable
              as Coach,
      formation: null == formation
          ? _value.formation
          : formation // ignore: cast_nullable_to_non_nullable
              as String,
      startXI: null == startXI
          ? _value.startXI
          : startXI // ignore: cast_nullable_to_non_nullable
              as List<StartXI>,
      substitutes: null == substitutes
          ? _value.substitutes
          : substitutes // ignore: cast_nullable_to_non_nullable
              as List<StartXI>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LineupDataImpl implements _LineupData {
  const _$LineupDataImpl(
      {required this.team,
      required this.coach,
      required this.formation,
      required this.startXI,
      required this.substitutes});

  factory _$LineupDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$LineupDataImplFromJson(json);

  @override
  final Team team;
  @override
  final Coach coach;
  @override
  final String formation;
  @override
  final List<StartXI> startXI;
  @override
  final List<StartXI> substitutes;

  @override
  String toString() {
    return 'LineupData(team: $team, coach: $coach, formation: $formation, startXI: $startXI, substitutes: $substitutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LineupDataImpl &&
            (identical(other.team, team) || other.team == team) &&
            (identical(other.coach, coach) || other.coach == coach) &&
            (identical(other.formation, formation) ||
                other.formation == formation) &&
            const DeepCollectionEquality().equals(other.startXI, startXI) &&
            const DeepCollectionEquality()
                .equals(other.substitutes, substitutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      team,
      coach,
      formation,
      const DeepCollectionEquality().hash(startXI),
      const DeepCollectionEquality().hash(substitutes));

  /// Create a copy of LineupData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LineupDataImplCopyWith<_$LineupDataImpl> get copyWith =>
      __$$LineupDataImplCopyWithImpl<_$LineupDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LineupDataImplToJson(
      this,
    );
  }
}

abstract class _LineupData implements LineupData {
  const factory _LineupData(
      {required final Team team,
      required final Coach coach,
      required final String formation,
      required final List<StartXI> startXI,
      required final List<StartXI> substitutes}) = _$LineupDataImpl;

  factory _LineupData.fromJson(Map<String, dynamic> json) =
      _$LineupDataImpl.fromJson;

  @override
  Team get team;
  @override
  Coach get coach;
  @override
  String get formation;
  @override
  List<StartXI> get startXI;
  @override
  List<StartXI> get substitutes;

  /// Create a copy of LineupData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LineupDataImplCopyWith<_$LineupDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Coach _$CoachFromJson(Map<String, dynamic> json) {
  return _Coach.fromJson(json);
}

/// @nodoc
mixin _$Coach {
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get photo => throw _privateConstructorUsedError;

  /// Serializes this Coach to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Coach
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CoachCopyWith<Coach> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoachCopyWith<$Res> {
  factory $CoachCopyWith(Coach value, $Res Function(Coach) then) =
      _$CoachCopyWithImpl<$Res, Coach>;
  @useResult
  $Res call({int? id, String name, String? photo});
}

/// @nodoc
class _$CoachCopyWithImpl<$Res, $Val extends Coach>
    implements $CoachCopyWith<$Res> {
  _$CoachCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Coach
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? photo = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CoachImplCopyWith<$Res> implements $CoachCopyWith<$Res> {
  factory _$$CoachImplCopyWith(
          _$CoachImpl value, $Res Function(_$CoachImpl) then) =
      __$$CoachImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String name, String? photo});
}

/// @nodoc
class __$$CoachImplCopyWithImpl<$Res>
    extends _$CoachCopyWithImpl<$Res, _$CoachImpl>
    implements _$$CoachImplCopyWith<$Res> {
  __$$CoachImplCopyWithImpl(
      _$CoachImpl _value, $Res Function(_$CoachImpl) _then)
      : super(_value, _then);

  /// Create a copy of Coach
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? photo = freezed,
  }) {
    return _then(_$CoachImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CoachImpl implements _Coach {
  const _$CoachImpl({this.id, required this.name, this.photo});

  factory _$CoachImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoachImplFromJson(json);

  @override
  final int? id;
  @override
  final String name;
  @override
  final String? photo;

  @override
  String toString() {
    return 'Coach(id: $id, name: $name, photo: $photo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoachImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.photo, photo) || other.photo == photo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, photo);

  /// Create a copy of Coach
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoachImplCopyWith<_$CoachImpl> get copyWith =>
      __$$CoachImplCopyWithImpl<_$CoachImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CoachImplToJson(
      this,
    );
  }
}

abstract class _Coach implements Coach {
  const factory _Coach(
      {final int? id,
      required final String name,
      final String? photo}) = _$CoachImpl;

  factory _Coach.fromJson(Map<String, dynamic> json) = _$CoachImpl.fromJson;

  @override
  int? get id;
  @override
  String get name;
  @override
  String? get photo;

  /// Create a copy of Coach
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoachImplCopyWith<_$CoachImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StartXI _$StartXIFromJson(Map<String, dynamic> json) {
  return _StartXI.fromJson(json);
}

/// @nodoc
mixin _$StartXI {
  PlayerDetails get player => throw _privateConstructorUsedError;

  /// Serializes this StartXI to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StartXI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StartXICopyWith<StartXI> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StartXICopyWith<$Res> {
  factory $StartXICopyWith(StartXI value, $Res Function(StartXI) then) =
      _$StartXICopyWithImpl<$Res, StartXI>;
  @useResult
  $Res call({PlayerDetails player});

  $PlayerDetailsCopyWith<$Res> get player;
}

/// @nodoc
class _$StartXICopyWithImpl<$Res, $Val extends StartXI>
    implements $StartXICopyWith<$Res> {
  _$StartXICopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StartXI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
  }) {
    return _then(_value.copyWith(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as PlayerDetails,
    ) as $Val);
  }

  /// Create a copy of StartXI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayerDetailsCopyWith<$Res> get player {
    return $PlayerDetailsCopyWith<$Res>(_value.player, (value) {
      return _then(_value.copyWith(player: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StartXIImplCopyWith<$Res> implements $StartXICopyWith<$Res> {
  factory _$$StartXIImplCopyWith(
          _$StartXIImpl value, $Res Function(_$StartXIImpl) then) =
      __$$StartXIImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PlayerDetails player});

  @override
  $PlayerDetailsCopyWith<$Res> get player;
}

/// @nodoc
class __$$StartXIImplCopyWithImpl<$Res>
    extends _$StartXICopyWithImpl<$Res, _$StartXIImpl>
    implements _$$StartXIImplCopyWith<$Res> {
  __$$StartXIImplCopyWithImpl(
      _$StartXIImpl _value, $Res Function(_$StartXIImpl) _then)
      : super(_value, _then);

  /// Create a copy of StartXI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
  }) {
    return _then(_$StartXIImpl(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as PlayerDetails,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StartXIImpl implements _StartXI {
  const _$StartXIImpl({required this.player});

  factory _$StartXIImpl.fromJson(Map<String, dynamic> json) =>
      _$$StartXIImplFromJson(json);

  @override
  final PlayerDetails player;

  @override
  String toString() {
    return 'StartXI(player: $player)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StartXIImpl &&
            (identical(other.player, player) || other.player == player));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, player);

  /// Create a copy of StartXI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StartXIImplCopyWith<_$StartXIImpl> get copyWith =>
      __$$StartXIImplCopyWithImpl<_$StartXIImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StartXIImplToJson(
      this,
    );
  }
}

abstract class _StartXI implements StartXI {
  const factory _StartXI({required final PlayerDetails player}) = _$StartXIImpl;

  factory _StartXI.fromJson(Map<String, dynamic> json) = _$StartXIImpl.fromJson;

  @override
  PlayerDetails get player;

  /// Create a copy of StartXI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StartXIImplCopyWith<_$StartXIImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlayerDetails _$PlayerDetailsFromJson(Map<String, dynamic> json) {
  return _PlayerDetails.fromJson(json);
}

/// @nodoc
mixin _$PlayerDetails {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int? get number => throw _privateConstructorUsedError;
  String? get pos => throw _privateConstructorUsedError;
  String? get grid => throw _privateConstructorUsedError;

  /// Serializes this PlayerDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlayerDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerDetailsCopyWith<PlayerDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerDetailsCopyWith<$Res> {
  factory $PlayerDetailsCopyWith(
          PlayerDetails value, $Res Function(PlayerDetails) then) =
      _$PlayerDetailsCopyWithImpl<$Res, PlayerDetails>;
  @useResult
  $Res call({int id, String name, int? number, String? pos, String? grid});
}

/// @nodoc
class _$PlayerDetailsCopyWithImpl<$Res, $Val extends PlayerDetails>
    implements $PlayerDetailsCopyWith<$Res> {
  _$PlayerDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayerDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? number = freezed,
    Object? pos = freezed,
    Object? grid = freezed,
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
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int?,
      pos: freezed == pos
          ? _value.pos
          : pos // ignore: cast_nullable_to_non_nullable
              as String?,
      grid: freezed == grid
          ? _value.grid
          : grid // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerDetailsImplCopyWith<$Res>
    implements $PlayerDetailsCopyWith<$Res> {
  factory _$$PlayerDetailsImplCopyWith(
          _$PlayerDetailsImpl value, $Res Function(_$PlayerDetailsImpl) then) =
      __$$PlayerDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, int? number, String? pos, String? grid});
}

/// @nodoc
class __$$PlayerDetailsImplCopyWithImpl<$Res>
    extends _$PlayerDetailsCopyWithImpl<$Res, _$PlayerDetailsImpl>
    implements _$$PlayerDetailsImplCopyWith<$Res> {
  __$$PlayerDetailsImplCopyWithImpl(
      _$PlayerDetailsImpl _value, $Res Function(_$PlayerDetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlayerDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? number = freezed,
    Object? pos = freezed,
    Object? grid = freezed,
  }) {
    return _then(_$PlayerDetailsImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int?,
      pos: freezed == pos
          ? _value.pos
          : pos // ignore: cast_nullable_to_non_nullable
              as String?,
      grid: freezed == grid
          ? _value.grid
          : grid // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerDetailsImpl implements _PlayerDetails {
  const _$PlayerDetailsImpl(
      {required this.id, required this.name, this.number, this.pos, this.grid});

  factory _$PlayerDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerDetailsImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final int? number;
  @override
  final String? pos;
  @override
  final String? grid;

  @override
  String toString() {
    return 'PlayerDetails(id: $id, name: $name, number: $number, pos: $pos, grid: $grid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerDetailsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.pos, pos) || other.pos == pos) &&
            (identical(other.grid, grid) || other.grid == grid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, number, pos, grid);

  /// Create a copy of PlayerDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerDetailsImplCopyWith<_$PlayerDetailsImpl> get copyWith =>
      __$$PlayerDetailsImplCopyWithImpl<_$PlayerDetailsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerDetailsImplToJson(
      this,
    );
  }
}

abstract class _PlayerDetails implements PlayerDetails {
  const factory _PlayerDetails(
      {required final int id,
      required final String name,
      final int? number,
      final String? pos,
      final String? grid}) = _$PlayerDetailsImpl;

  factory _PlayerDetails.fromJson(Map<String, dynamic> json) =
      _$PlayerDetailsImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  int? get number;
  @override
  String? get pos;
  @override
  String? get grid;

  /// Create a copy of PlayerDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerDetailsImplCopyWith<_$PlayerDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Statistics _$StatisticsFromJson(Map<String, dynamic> json) {
  return _Statistics.fromJson(json);
}

/// @nodoc
mixin _$Statistics {
  List<TeamStatistics>? get home => throw _privateConstructorUsedError;
  List<TeamStatistics>? get away => throw _privateConstructorUsedError;

  /// Serializes this Statistics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Statistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatisticsCopyWith<Statistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatisticsCopyWith<$Res> {
  factory $StatisticsCopyWith(
          Statistics value, $Res Function(Statistics) then) =
      _$StatisticsCopyWithImpl<$Res, Statistics>;
  @useResult
  $Res call({List<TeamStatistics>? home, List<TeamStatistics>? away});
}

/// @nodoc
class _$StatisticsCopyWithImpl<$Res, $Val extends Statistics>
    implements $StatisticsCopyWith<$Res> {
  _$StatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Statistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? home = freezed,
    Object? away = freezed,
  }) {
    return _then(_value.copyWith(
      home: freezed == home
          ? _value.home
          : home // ignore: cast_nullable_to_non_nullable
              as List<TeamStatistics>?,
      away: freezed == away
          ? _value.away
          : away // ignore: cast_nullable_to_non_nullable
              as List<TeamStatistics>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatisticsImplCopyWith<$Res>
    implements $StatisticsCopyWith<$Res> {
  factory _$$StatisticsImplCopyWith(
          _$StatisticsImpl value, $Res Function(_$StatisticsImpl) then) =
      __$$StatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TeamStatistics>? home, List<TeamStatistics>? away});
}

/// @nodoc
class __$$StatisticsImplCopyWithImpl<$Res>
    extends _$StatisticsCopyWithImpl<$Res, _$StatisticsImpl>
    implements _$$StatisticsImplCopyWith<$Res> {
  __$$StatisticsImplCopyWithImpl(
      _$StatisticsImpl _value, $Res Function(_$StatisticsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Statistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? home = freezed,
    Object? away = freezed,
  }) {
    return _then(_$StatisticsImpl(
      home: freezed == home
          ? _value.home
          : home // ignore: cast_nullable_to_non_nullable
              as List<TeamStatistics>?,
      away: freezed == away
          ? _value.away
          : away // ignore: cast_nullable_to_non_nullable
              as List<TeamStatistics>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatisticsImpl implements _Statistics {
  const _$StatisticsImpl({this.home, this.away});

  factory _$StatisticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatisticsImplFromJson(json);

  @override
  final List<TeamStatistics>? home;
  @override
  final List<TeamStatistics>? away;

  @override
  String toString() {
    return 'Statistics(home: $home, away: $away)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatisticsImpl &&
            const DeepCollectionEquality().equals(other.home, home) &&
            const DeepCollectionEquality().equals(other.away, away));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(home),
      const DeepCollectionEquality().hash(away));

  /// Create a copy of Statistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatisticsImplCopyWith<_$StatisticsImpl> get copyWith =>
      __$$StatisticsImplCopyWithImpl<_$StatisticsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatisticsImplToJson(
      this,
    );
  }
}

abstract class _Statistics implements Statistics {
  const factory _Statistics(
      {final List<TeamStatistics>? home,
      final List<TeamStatistics>? away}) = _$StatisticsImpl;

  factory _Statistics.fromJson(Map<String, dynamic> json) =
      _$StatisticsImpl.fromJson;

  @override
  List<TeamStatistics>? get home;
  @override
  List<TeamStatistics>? get away;

  /// Create a copy of Statistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatisticsImplCopyWith<_$StatisticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TeamStatistics _$TeamStatisticsFromJson(Map<String, dynamic> json) {
  return _TeamStatistics.fromJson(json);
}

/// @nodoc
mixin _$TeamStatistics {
  String get type => throw _privateConstructorUsedError;
  dynamic get value => throw _privateConstructorUsedError;

  /// Serializes this TeamStatistics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TeamStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamStatisticsCopyWith<TeamStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamStatisticsCopyWith<$Res> {
  factory $TeamStatisticsCopyWith(
          TeamStatistics value, $Res Function(TeamStatistics) then) =
      _$TeamStatisticsCopyWithImpl<$Res, TeamStatistics>;
  @useResult
  $Res call({String type, dynamic value});
}

/// @nodoc
class _$TeamStatisticsCopyWithImpl<$Res, $Val extends TeamStatistics>
    implements $TeamStatisticsCopyWith<$Res> {
  _$TeamStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeamStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamStatisticsImplCopyWith<$Res>
    implements $TeamStatisticsCopyWith<$Res> {
  factory _$$TeamStatisticsImplCopyWith(_$TeamStatisticsImpl value,
          $Res Function(_$TeamStatisticsImpl) then) =
      __$$TeamStatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, dynamic value});
}

/// @nodoc
class __$$TeamStatisticsImplCopyWithImpl<$Res>
    extends _$TeamStatisticsCopyWithImpl<$Res, _$TeamStatisticsImpl>
    implements _$$TeamStatisticsImplCopyWith<$Res> {
  __$$TeamStatisticsImplCopyWithImpl(
      _$TeamStatisticsImpl _value, $Res Function(_$TeamStatisticsImpl) _then)
      : super(_value, _then);

  /// Create a copy of TeamStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? value = freezed,
  }) {
    return _then(_$TeamStatisticsImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamStatisticsImpl implements _TeamStatistics {
  const _$TeamStatisticsImpl({required this.type, required this.value});

  factory _$TeamStatisticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamStatisticsImplFromJson(json);

  @override
  final String type;
  @override
  final dynamic value;

  @override
  String toString() {
    return 'TeamStatistics(type: $type, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamStatisticsImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, const DeepCollectionEquality().hash(value));

  /// Create a copy of TeamStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamStatisticsImplCopyWith<_$TeamStatisticsImpl> get copyWith =>
      __$$TeamStatisticsImplCopyWithImpl<_$TeamStatisticsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamStatisticsImplToJson(
      this,
    );
  }
}

abstract class _TeamStatistics implements TeamStatistics {
  const factory _TeamStatistics(
      {required final String type,
      required final dynamic value}) = _$TeamStatisticsImpl;

  factory _TeamStatistics.fromJson(Map<String, dynamic> json) =
      _$TeamStatisticsImpl.fromJson;

  @override
  String get type;
  @override
  dynamic get value;

  /// Create a copy of TeamStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamStatisticsImplCopyWith<_$TeamStatisticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlayerStatistics _$PlayerStatisticsFromJson(Map<String, dynamic> json) {
  return _PlayerStatistics.fromJson(json);
}

/// @nodoc
mixin _$PlayerStatistics {
  Team get team => throw _privateConstructorUsedError;
  List<PlayerStatDetail> get players => throw _privateConstructorUsedError;

  /// Serializes this PlayerStatistics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlayerStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerStatisticsCopyWith<PlayerStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerStatisticsCopyWith<$Res> {
  factory $PlayerStatisticsCopyWith(
          PlayerStatistics value, $Res Function(PlayerStatistics) then) =
      _$PlayerStatisticsCopyWithImpl<$Res, PlayerStatistics>;
  @useResult
  $Res call({Team team, List<PlayerStatDetail> players});

  $TeamCopyWith<$Res> get team;
}

/// @nodoc
class _$PlayerStatisticsCopyWithImpl<$Res, $Val extends PlayerStatistics>
    implements $PlayerStatisticsCopyWith<$Res> {
  _$PlayerStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayerStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? team = null,
    Object? players = null,
  }) {
    return _then(_value.copyWith(
      team: null == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as Team,
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<PlayerStatDetail>,
    ) as $Val);
  }

  /// Create a copy of PlayerStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TeamCopyWith<$Res> get team {
    return $TeamCopyWith<$Res>(_value.team, (value) {
      return _then(_value.copyWith(team: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlayerStatisticsImplCopyWith<$Res>
    implements $PlayerStatisticsCopyWith<$Res> {
  factory _$$PlayerStatisticsImplCopyWith(_$PlayerStatisticsImpl value,
          $Res Function(_$PlayerStatisticsImpl) then) =
      __$$PlayerStatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Team team, List<PlayerStatDetail> players});

  @override
  $TeamCopyWith<$Res> get team;
}

/// @nodoc
class __$$PlayerStatisticsImplCopyWithImpl<$Res>
    extends _$PlayerStatisticsCopyWithImpl<$Res, _$PlayerStatisticsImpl>
    implements _$$PlayerStatisticsImplCopyWith<$Res> {
  __$$PlayerStatisticsImplCopyWithImpl(_$PlayerStatisticsImpl _value,
      $Res Function(_$PlayerStatisticsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlayerStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? team = null,
    Object? players = null,
  }) {
    return _then(_$PlayerStatisticsImpl(
      team: null == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as Team,
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<PlayerStatDetail>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerStatisticsImpl implements _PlayerStatistics {
  const _$PlayerStatisticsImpl({required this.team, required this.players});

  factory _$PlayerStatisticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerStatisticsImplFromJson(json);

  @override
  final Team team;
  @override
  final List<PlayerStatDetail> players;

  @override
  String toString() {
    return 'PlayerStatistics(team: $team, players: $players)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerStatisticsImpl &&
            (identical(other.team, team) || other.team == team) &&
            const DeepCollectionEquality().equals(other.players, players));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, team, const DeepCollectionEquality().hash(players));

  /// Create a copy of PlayerStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerStatisticsImplCopyWith<_$PlayerStatisticsImpl> get copyWith =>
      __$$PlayerStatisticsImplCopyWithImpl<_$PlayerStatisticsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerStatisticsImplToJson(
      this,
    );
  }
}

abstract class _PlayerStatistics implements PlayerStatistics {
  const factory _PlayerStatistics(
      {required final Team team,
      required final List<PlayerStatDetail> players}) = _$PlayerStatisticsImpl;

  factory _PlayerStatistics.fromJson(Map<String, dynamic> json) =
      _$PlayerStatisticsImpl.fromJson;

  @override
  Team get team;
  @override
  List<PlayerStatDetail> get players;

  /// Create a copy of PlayerStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerStatisticsImplCopyWith<_$PlayerStatisticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlayerStatDetail _$PlayerStatDetailFromJson(Map<String, dynamic> json) {
  return _PlayerStatDetail.fromJson(json);
}

/// @nodoc
mixin _$PlayerStatDetail {
  PlayerDetails get player => throw _privateConstructorUsedError;
  List<Statistic> get statistics => throw _privateConstructorUsedError;

  /// Serializes this PlayerStatDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlayerStatDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerStatDetailCopyWith<PlayerStatDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerStatDetailCopyWith<$Res> {
  factory $PlayerStatDetailCopyWith(
          PlayerStatDetail value, $Res Function(PlayerStatDetail) then) =
      _$PlayerStatDetailCopyWithImpl<$Res, PlayerStatDetail>;
  @useResult
  $Res call({PlayerDetails player, List<Statistic> statistics});

  $PlayerDetailsCopyWith<$Res> get player;
}

/// @nodoc
class _$PlayerStatDetailCopyWithImpl<$Res, $Val extends PlayerStatDetail>
    implements $PlayerStatDetailCopyWith<$Res> {
  _$PlayerStatDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayerStatDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
    Object? statistics = null,
  }) {
    return _then(_value.copyWith(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as PlayerDetails,
      statistics: null == statistics
          ? _value.statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as List<Statistic>,
    ) as $Val);
  }

  /// Create a copy of PlayerStatDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayerDetailsCopyWith<$Res> get player {
    return $PlayerDetailsCopyWith<$Res>(_value.player, (value) {
      return _then(_value.copyWith(player: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlayerStatDetailImplCopyWith<$Res>
    implements $PlayerStatDetailCopyWith<$Res> {
  factory _$$PlayerStatDetailImplCopyWith(_$PlayerStatDetailImpl value,
          $Res Function(_$PlayerStatDetailImpl) then) =
      __$$PlayerStatDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PlayerDetails player, List<Statistic> statistics});

  @override
  $PlayerDetailsCopyWith<$Res> get player;
}

/// @nodoc
class __$$PlayerStatDetailImplCopyWithImpl<$Res>
    extends _$PlayerStatDetailCopyWithImpl<$Res, _$PlayerStatDetailImpl>
    implements _$$PlayerStatDetailImplCopyWith<$Res> {
  __$$PlayerStatDetailImplCopyWithImpl(_$PlayerStatDetailImpl _value,
      $Res Function(_$PlayerStatDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlayerStatDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
    Object? statistics = null,
  }) {
    return _then(_$PlayerStatDetailImpl(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as PlayerDetails,
      statistics: null == statistics
          ? _value.statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as List<Statistic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerStatDetailImpl implements _PlayerStatDetail {
  const _$PlayerStatDetailImpl(
      {required this.player, required this.statistics});

  factory _$PlayerStatDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerStatDetailImplFromJson(json);

  @override
  final PlayerDetails player;
  @override
  final List<Statistic> statistics;

  @override
  String toString() {
    return 'PlayerStatDetail(player: $player, statistics: $statistics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerStatDetailImpl &&
            (identical(other.player, player) || other.player == player) &&
            const DeepCollectionEquality()
                .equals(other.statistics, statistics));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, player, const DeepCollectionEquality().hash(statistics));

  /// Create a copy of PlayerStatDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerStatDetailImplCopyWith<_$PlayerStatDetailImpl> get copyWith =>
      __$$PlayerStatDetailImplCopyWithImpl<_$PlayerStatDetailImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerStatDetailImplToJson(
      this,
    );
  }
}

abstract class _PlayerStatDetail implements PlayerStatDetail {
  const factory _PlayerStatDetail(
      {required final PlayerDetails player,
      required final List<Statistic> statistics}) = _$PlayerStatDetailImpl;

  factory _PlayerStatDetail.fromJson(Map<String, dynamic> json) =
      _$PlayerStatDetailImpl.fromJson;

  @override
  PlayerDetails get player;
  @override
  List<Statistic> get statistics;

  /// Create a copy of PlayerStatDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerStatDetailImplCopyWith<_$PlayerStatDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Statistic _$StatisticFromJson(Map<String, dynamic> json) {
  return _Statistic.fromJson(json);
}

/// @nodoc
mixin _$Statistic {
  Map<String, dynamic> get games => throw _privateConstructorUsedError;
  Map<String, dynamic>? get offsides => throw _privateConstructorUsedError;
  Map<String, dynamic>? get shots => throw _privateConstructorUsedError;
  Map<String, dynamic>? get goals => throw _privateConstructorUsedError;
  Map<String, dynamic>? get passes => throw _privateConstructorUsedError;
  Map<String, dynamic>? get tackles => throw _privateConstructorUsedError;
  Map<String, dynamic>? get duels => throw _privateConstructorUsedError;
  Map<String, dynamic>? get dribbles => throw _privateConstructorUsedError;
  Map<String, dynamic>? get fouls => throw _privateConstructorUsedError;
  Map<String, dynamic>? get cards => throw _privateConstructorUsedError;
  Map<String, dynamic>? get penalty => throw _privateConstructorUsedError;

  /// Serializes this Statistic to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Statistic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatisticCopyWith<Statistic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatisticCopyWith<$Res> {
  factory $StatisticCopyWith(Statistic value, $Res Function(Statistic) then) =
      _$StatisticCopyWithImpl<$Res, Statistic>;
  @useResult
  $Res call(
      {Map<String, dynamic> games,
      Map<String, dynamic>? offsides,
      Map<String, dynamic>? shots,
      Map<String, dynamic>? goals,
      Map<String, dynamic>? passes,
      Map<String, dynamic>? tackles,
      Map<String, dynamic>? duels,
      Map<String, dynamic>? dribbles,
      Map<String, dynamic>? fouls,
      Map<String, dynamic>? cards,
      Map<String, dynamic>? penalty});
}

/// @nodoc
class _$StatisticCopyWithImpl<$Res, $Val extends Statistic>
    implements $StatisticCopyWith<$Res> {
  _$StatisticCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Statistic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? games = null,
    Object? offsides = freezed,
    Object? shots = freezed,
    Object? goals = freezed,
    Object? passes = freezed,
    Object? tackles = freezed,
    Object? duels = freezed,
    Object? dribbles = freezed,
    Object? fouls = freezed,
    Object? cards = freezed,
    Object? penalty = freezed,
  }) {
    return _then(_value.copyWith(
      games: null == games
          ? _value.games
          : games // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      offsides: freezed == offsides
          ? _value.offsides
          : offsides // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      shots: freezed == shots
          ? _value.shots
          : shots // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      goals: freezed == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      passes: freezed == passes
          ? _value.passes
          : passes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      tackles: freezed == tackles
          ? _value.tackles
          : tackles // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      duels: freezed == duels
          ? _value.duels
          : duels // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      dribbles: freezed == dribbles
          ? _value.dribbles
          : dribbles // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      fouls: freezed == fouls
          ? _value.fouls
          : fouls // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      cards: freezed == cards
          ? _value.cards
          : cards // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      penalty: freezed == penalty
          ? _value.penalty
          : penalty // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatisticImplCopyWith<$Res>
    implements $StatisticCopyWith<$Res> {
  factory _$$StatisticImplCopyWith(
          _$StatisticImpl value, $Res Function(_$StatisticImpl) then) =
      __$$StatisticImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, dynamic> games,
      Map<String, dynamic>? offsides,
      Map<String, dynamic>? shots,
      Map<String, dynamic>? goals,
      Map<String, dynamic>? passes,
      Map<String, dynamic>? tackles,
      Map<String, dynamic>? duels,
      Map<String, dynamic>? dribbles,
      Map<String, dynamic>? fouls,
      Map<String, dynamic>? cards,
      Map<String, dynamic>? penalty});
}

/// @nodoc
class __$$StatisticImplCopyWithImpl<$Res>
    extends _$StatisticCopyWithImpl<$Res, _$StatisticImpl>
    implements _$$StatisticImplCopyWith<$Res> {
  __$$StatisticImplCopyWithImpl(
      _$StatisticImpl _value, $Res Function(_$StatisticImpl) _then)
      : super(_value, _then);

  /// Create a copy of Statistic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? games = null,
    Object? offsides = freezed,
    Object? shots = freezed,
    Object? goals = freezed,
    Object? passes = freezed,
    Object? tackles = freezed,
    Object? duels = freezed,
    Object? dribbles = freezed,
    Object? fouls = freezed,
    Object? cards = freezed,
    Object? penalty = freezed,
  }) {
    return _then(_$StatisticImpl(
      games: null == games
          ? _value.games
          : games // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      offsides: freezed == offsides
          ? _value.offsides
          : offsides // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      shots: freezed == shots
          ? _value.shots
          : shots // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      goals: freezed == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      passes: freezed == passes
          ? _value.passes
          : passes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      tackles: freezed == tackles
          ? _value.tackles
          : tackles // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      duels: freezed == duels
          ? _value.duels
          : duels // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      dribbles: freezed == dribbles
          ? _value.dribbles
          : dribbles // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      fouls: freezed == fouls
          ? _value.fouls
          : fouls // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      cards: freezed == cards
          ? _value.cards
          : cards // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      penalty: freezed == penalty
          ? _value.penalty
          : penalty // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatisticImpl implements _Statistic {
  const _$StatisticImpl(
      {required this.games,
      this.offsides,
      this.shots,
      this.goals,
      this.passes,
      this.tackles,
      this.duels,
      this.dribbles,
      this.fouls,
      this.cards,
      this.penalty});

  factory _$StatisticImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatisticImplFromJson(json);

  @override
  final Map<String, dynamic> games;
  @override
  final Map<String, dynamic>? offsides;
  @override
  final Map<String, dynamic>? shots;
  @override
  final Map<String, dynamic>? goals;
  @override
  final Map<String, dynamic>? passes;
  @override
  final Map<String, dynamic>? tackles;
  @override
  final Map<String, dynamic>? duels;
  @override
  final Map<String, dynamic>? dribbles;
  @override
  final Map<String, dynamic>? fouls;
  @override
  final Map<String, dynamic>? cards;
  @override
  final Map<String, dynamic>? penalty;

  @override
  String toString() {
    return 'Statistic(games: $games, offsides: $offsides, shots: $shots, goals: $goals, passes: $passes, tackles: $tackles, duels: $duels, dribbles: $dribbles, fouls: $fouls, cards: $cards, penalty: $penalty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatisticImpl &&
            const DeepCollectionEquality().equals(other.games, games) &&
            const DeepCollectionEquality().equals(other.offsides, offsides) &&
            const DeepCollectionEquality().equals(other.shots, shots) &&
            const DeepCollectionEquality().equals(other.goals, goals) &&
            const DeepCollectionEquality().equals(other.passes, passes) &&
            const DeepCollectionEquality().equals(other.tackles, tackles) &&
            const DeepCollectionEquality().equals(other.duels, duels) &&
            const DeepCollectionEquality().equals(other.dribbles, dribbles) &&
            const DeepCollectionEquality().equals(other.fouls, fouls) &&
            const DeepCollectionEquality().equals(other.cards, cards) &&
            const DeepCollectionEquality().equals(other.penalty, penalty));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(games),
      const DeepCollectionEquality().hash(offsides),
      const DeepCollectionEquality().hash(shots),
      const DeepCollectionEquality().hash(goals),
      const DeepCollectionEquality().hash(passes),
      const DeepCollectionEquality().hash(tackles),
      const DeepCollectionEquality().hash(duels),
      const DeepCollectionEquality().hash(dribbles),
      const DeepCollectionEquality().hash(fouls),
      const DeepCollectionEquality().hash(cards),
      const DeepCollectionEquality().hash(penalty));

  /// Create a copy of Statistic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatisticImplCopyWith<_$StatisticImpl> get copyWith =>
      __$$StatisticImplCopyWithImpl<_$StatisticImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatisticImplToJson(
      this,
    );
  }
}

abstract class _Statistic implements Statistic {
  const factory _Statistic(
      {required final Map<String, dynamic> games,
      final Map<String, dynamic>? offsides,
      final Map<String, dynamic>? shots,
      final Map<String, dynamic>? goals,
      final Map<String, dynamic>? passes,
      final Map<String, dynamic>? tackles,
      final Map<String, dynamic>? duels,
      final Map<String, dynamic>? dribbles,
      final Map<String, dynamic>? fouls,
      final Map<String, dynamic>? cards,
      final Map<String, dynamic>? penalty}) = _$StatisticImpl;

  factory _Statistic.fromJson(Map<String, dynamic> json) =
      _$StatisticImpl.fromJson;

  @override
  Map<String, dynamic> get games;
  @override
  Map<String, dynamic>? get offsides;
  @override
  Map<String, dynamic>? get shots;
  @override
  Map<String, dynamic>? get goals;
  @override
  Map<String, dynamic>? get passes;
  @override
  Map<String, dynamic>? get tackles;
  @override
  Map<String, dynamic>? get duels;
  @override
  Map<String, dynamic>? get dribbles;
  @override
  Map<String, dynamic>? get fouls;
  @override
  Map<String, dynamic>? get cards;
  @override
  Map<String, dynamic>? get penalty;

  /// Create a copy of Statistic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatisticImplCopyWith<_$StatisticImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
