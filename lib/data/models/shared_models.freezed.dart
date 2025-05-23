// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shared_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

League _$LeagueFromJson(Map<String, dynamic> json) {
  return _League.fromJson(json);
}

/// @nodoc
mixin _$League {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  String get logo => throw _privateConstructorUsedError;
  String? get flag => throw _privateConstructorUsedError;
  int get season => throw _privateConstructorUsedError;
  String? get round => throw _privateConstructorUsedError;

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
  $Res call(
      {int id,
      String name,
      String country,
      String logo,
      String? flag,
      int season,
      String? round});
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
    Object? country = null,
    Object? logo = null,
    Object? flag = freezed,
    Object? season = null,
    Object? round = freezed,
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
      flag: freezed == flag
          ? _value.flag
          : flag // ignore: cast_nullable_to_non_nullable
              as String?,
      season: null == season
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as int,
      round: freezed == round
          ? _value.round
          : round // ignore: cast_nullable_to_non_nullable
              as String?,
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
  $Res call(
      {int id,
      String name,
      String country,
      String logo,
      String? flag,
      int season,
      String? round});
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
    Object? country = null,
    Object? logo = null,
    Object? flag = freezed,
    Object? season = null,
    Object? round = freezed,
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
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      logo: null == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String,
      flag: freezed == flag
          ? _value.flag
          : flag // ignore: cast_nullable_to_non_nullable
              as String?,
      season: null == season
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as int,
      round: freezed == round
          ? _value.round
          : round // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeagueImpl implements _League {
  const _$LeagueImpl(
      {required this.id,
      required this.name,
      required this.country,
      required this.logo,
      this.flag,
      required this.season,
      this.round});

  factory _$LeagueImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeagueImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String country;
  @override
  final String logo;
  @override
  final String? flag;
  @override
  final int season;
  @override
  final String? round;

  @override
  String toString() {
    return 'League(id: $id, name: $name, country: $country, logo: $logo, flag: $flag, season: $season, round: $round)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeagueImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.flag, flag) || other.flag == flag) &&
            (identical(other.season, season) || other.season == season) &&
            (identical(other.round, round) || other.round == round));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, country, logo, flag, season, round);

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
      required final String country,
      required final String logo,
      final String? flag,
      required final int season,
      final String? round}) = _$LeagueImpl;

  factory _League.fromJson(Map<String, dynamic> json) = _$LeagueImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get country;
  @override
  String get logo;
  @override
  String? get flag;
  @override
  int get season;
  @override
  String? get round;

  /// Create a copy of League
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeagueImplCopyWith<_$LeagueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Teams _$TeamsFromJson(Map<String, dynamic> json) {
  return _Teams.fromJson(json);
}

/// @nodoc
mixin _$Teams {
  Team get home => throw _privateConstructorUsedError;
  Team get away => throw _privateConstructorUsedError;

  /// Serializes this Teams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Teams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamsCopyWith<Teams> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamsCopyWith<$Res> {
  factory $TeamsCopyWith(Teams value, $Res Function(Teams) then) =
      _$TeamsCopyWithImpl<$Res, Teams>;
  @useResult
  $Res call({Team home, Team away});

  $TeamCopyWith<$Res> get home;
  $TeamCopyWith<$Res> get away;
}

/// @nodoc
class _$TeamsCopyWithImpl<$Res, $Val extends Teams>
    implements $TeamsCopyWith<$Res> {
  _$TeamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Teams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? home = null,
    Object? away = null,
  }) {
    return _then(_value.copyWith(
      home: null == home
          ? _value.home
          : home // ignore: cast_nullable_to_non_nullable
              as Team,
      away: null == away
          ? _value.away
          : away // ignore: cast_nullable_to_non_nullable
              as Team,
    ) as $Val);
  }

  /// Create a copy of Teams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TeamCopyWith<$Res> get home {
    return $TeamCopyWith<$Res>(_value.home, (value) {
      return _then(_value.copyWith(home: value) as $Val);
    });
  }

  /// Create a copy of Teams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TeamCopyWith<$Res> get away {
    return $TeamCopyWith<$Res>(_value.away, (value) {
      return _then(_value.copyWith(away: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TeamsImplCopyWith<$Res> implements $TeamsCopyWith<$Res> {
  factory _$$TeamsImplCopyWith(
          _$TeamsImpl value, $Res Function(_$TeamsImpl) then) =
      __$$TeamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Team home, Team away});

  @override
  $TeamCopyWith<$Res> get home;
  @override
  $TeamCopyWith<$Res> get away;
}

/// @nodoc
class __$$TeamsImplCopyWithImpl<$Res>
    extends _$TeamsCopyWithImpl<$Res, _$TeamsImpl>
    implements _$$TeamsImplCopyWith<$Res> {
  __$$TeamsImplCopyWithImpl(
      _$TeamsImpl _value, $Res Function(_$TeamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Teams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? home = null,
    Object? away = null,
  }) {
    return _then(_$TeamsImpl(
      home: null == home
          ? _value.home
          : home // ignore: cast_nullable_to_non_nullable
              as Team,
      away: null == away
          ? _value.away
          : away // ignore: cast_nullable_to_non_nullable
              as Team,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamsImpl implements _Teams {
  const _$TeamsImpl({required this.home, required this.away});

  factory _$TeamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamsImplFromJson(json);

  @override
  final Team home;
  @override
  final Team away;

  @override
  String toString() {
    return 'Teams(home: $home, away: $away)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamsImpl &&
            (identical(other.home, home) || other.home == home) &&
            (identical(other.away, away) || other.away == away));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, home, away);

  /// Create a copy of Teams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamsImplCopyWith<_$TeamsImpl> get copyWith =>
      __$$TeamsImplCopyWithImpl<_$TeamsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamsImplToJson(
      this,
    );
  }
}

abstract class _Teams implements Teams {
  const factory _Teams({required final Team home, required final Team away}) =
      _$TeamsImpl;

  factory _Teams.fromJson(Map<String, dynamic> json) = _$TeamsImpl.fromJson;

  @override
  Team get home;
  @override
  Team get away;

  /// Create a copy of Teams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamsImplCopyWith<_$TeamsImpl> get copyWith =>
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
  bool? get winner => throw _privateConstructorUsedError;
  Map<String, dynamic>? get statistics => throw _privateConstructorUsedError;

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
  $Res call(
      {int id,
      String name,
      String logo,
      bool? winner,
      Map<String, dynamic>? statistics});
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
    Object? winner = freezed,
    Object? statistics = freezed,
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
      winner: freezed == winner
          ? _value.winner
          : winner // ignore: cast_nullable_to_non_nullable
              as bool?,
      statistics: freezed == statistics
          ? _value.statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
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
  $Res call(
      {int id,
      String name,
      String logo,
      bool? winner,
      Map<String, dynamic>? statistics});
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
    Object? winner = freezed,
    Object? statistics = freezed,
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
      winner: freezed == winner
          ? _value.winner
          : winner // ignore: cast_nullable_to_non_nullable
              as bool?,
      statistics: freezed == statistics
          ? _value.statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamImpl implements _Team {
  const _$TeamImpl(
      {required this.id,
      required this.name,
      required this.logo,
      this.winner,
      this.statistics});

  factory _$TeamImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String logo;
  @override
  final bool? winner;
  @override
  final Map<String, dynamic>? statistics;

  @override
  String toString() {
    return 'Team(id: $id, name: $name, logo: $logo, winner: $winner, statistics: $statistics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.winner, winner) || other.winner == winner) &&
            const DeepCollectionEquality()
                .equals(other.statistics, statistics));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, logo, winner,
      const DeepCollectionEquality().hash(statistics));

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
      required final String logo,
      final bool? winner,
      final Map<String, dynamic>? statistics}) = _$TeamImpl;

  factory _Team.fromJson(Map<String, dynamic> json) = _$TeamImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get logo;
  @override
  bool? get winner;
  @override
  Map<String, dynamic>? get statistics;

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamImplCopyWith<_$TeamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Goals _$GoalsFromJson(Map<String, dynamic> json) {
  return _Goals.fromJson(json);
}

/// @nodoc
mixin _$Goals {
  int? get home => throw _privateConstructorUsedError;
  int? get away => throw _privateConstructorUsedError;

  /// Serializes this Goals to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Goals
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoalsCopyWith<Goals> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalsCopyWith<$Res> {
  factory $GoalsCopyWith(Goals value, $Res Function(Goals) then) =
      _$GoalsCopyWithImpl<$Res, Goals>;
  @useResult
  $Res call({int? home, int? away});
}

/// @nodoc
class _$GoalsCopyWithImpl<$Res, $Val extends Goals>
    implements $GoalsCopyWith<$Res> {
  _$GoalsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Goals
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
              as int?,
      away: freezed == away
          ? _value.away
          : away // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GoalsImplCopyWith<$Res> implements $GoalsCopyWith<$Res> {
  factory _$$GoalsImplCopyWith(
          _$GoalsImpl value, $Res Function(_$GoalsImpl) then) =
      __$$GoalsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? home, int? away});
}

/// @nodoc
class __$$GoalsImplCopyWithImpl<$Res>
    extends _$GoalsCopyWithImpl<$Res, _$GoalsImpl>
    implements _$$GoalsImplCopyWith<$Res> {
  __$$GoalsImplCopyWithImpl(
      _$GoalsImpl _value, $Res Function(_$GoalsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Goals
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? home = freezed,
    Object? away = freezed,
  }) {
    return _then(_$GoalsImpl(
      home: freezed == home
          ? _value.home
          : home // ignore: cast_nullable_to_non_nullable
              as int?,
      away: freezed == away
          ? _value.away
          : away // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GoalsImpl implements _Goals {
  const _$GoalsImpl({this.home, this.away});

  factory _$GoalsImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoalsImplFromJson(json);

  @override
  final int? home;
  @override
  final int? away;

  @override
  String toString() {
    return 'Goals(home: $home, away: $away)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalsImpl &&
            (identical(other.home, home) || other.home == home) &&
            (identical(other.away, away) || other.away == away));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, home, away);

  /// Create a copy of Goals
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalsImplCopyWith<_$GoalsImpl> get copyWith =>
      __$$GoalsImplCopyWithImpl<_$GoalsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GoalsImplToJson(
      this,
    );
  }
}

abstract class _Goals implements Goals {
  const factory _Goals({final int? home, final int? away}) = _$GoalsImpl;

  factory _Goals.fromJson(Map<String, dynamic> json) = _$GoalsImpl.fromJson;

  @override
  int? get home;
  @override
  int? get away;

  /// Create a copy of Goals
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoalsImplCopyWith<_$GoalsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Score _$ScoreFromJson(Map<String, dynamic> json) {
  return _Score.fromJson(json);
}

/// @nodoc
mixin _$Score {
  Goals get halftime => throw _privateConstructorUsedError;
  Goals get fulltime => throw _privateConstructorUsedError;
  Goals? get extratime => throw _privateConstructorUsedError;
  Goals? get penalty => throw _privateConstructorUsedError;

  /// Serializes this Score to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Score
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScoreCopyWith<Score> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScoreCopyWith<$Res> {
  factory $ScoreCopyWith(Score value, $Res Function(Score) then) =
      _$ScoreCopyWithImpl<$Res, Score>;
  @useResult
  $Res call({Goals halftime, Goals fulltime, Goals? extratime, Goals? penalty});

  $GoalsCopyWith<$Res> get halftime;
  $GoalsCopyWith<$Res> get fulltime;
  $GoalsCopyWith<$Res>? get extratime;
  $GoalsCopyWith<$Res>? get penalty;
}

/// @nodoc
class _$ScoreCopyWithImpl<$Res, $Val extends Score>
    implements $ScoreCopyWith<$Res> {
  _$ScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Score
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? halftime = null,
    Object? fulltime = null,
    Object? extratime = freezed,
    Object? penalty = freezed,
  }) {
    return _then(_value.copyWith(
      halftime: null == halftime
          ? _value.halftime
          : halftime // ignore: cast_nullable_to_non_nullable
              as Goals,
      fulltime: null == fulltime
          ? _value.fulltime
          : fulltime // ignore: cast_nullable_to_non_nullable
              as Goals,
      extratime: freezed == extratime
          ? _value.extratime
          : extratime // ignore: cast_nullable_to_non_nullable
              as Goals?,
      penalty: freezed == penalty
          ? _value.penalty
          : penalty // ignore: cast_nullable_to_non_nullable
              as Goals?,
    ) as $Val);
  }

  /// Create a copy of Score
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GoalsCopyWith<$Res> get halftime {
    return $GoalsCopyWith<$Res>(_value.halftime, (value) {
      return _then(_value.copyWith(halftime: value) as $Val);
    });
  }

  /// Create a copy of Score
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GoalsCopyWith<$Res> get fulltime {
    return $GoalsCopyWith<$Res>(_value.fulltime, (value) {
      return _then(_value.copyWith(fulltime: value) as $Val);
    });
  }

  /// Create a copy of Score
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GoalsCopyWith<$Res>? get extratime {
    if (_value.extratime == null) {
      return null;
    }

    return $GoalsCopyWith<$Res>(_value.extratime!, (value) {
      return _then(_value.copyWith(extratime: value) as $Val);
    });
  }

  /// Create a copy of Score
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GoalsCopyWith<$Res>? get penalty {
    if (_value.penalty == null) {
      return null;
    }

    return $GoalsCopyWith<$Res>(_value.penalty!, (value) {
      return _then(_value.copyWith(penalty: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ScoreImplCopyWith<$Res> implements $ScoreCopyWith<$Res> {
  factory _$$ScoreImplCopyWith(
          _$ScoreImpl value, $Res Function(_$ScoreImpl) then) =
      __$$ScoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Goals halftime, Goals fulltime, Goals? extratime, Goals? penalty});

  @override
  $GoalsCopyWith<$Res> get halftime;
  @override
  $GoalsCopyWith<$Res> get fulltime;
  @override
  $GoalsCopyWith<$Res>? get extratime;
  @override
  $GoalsCopyWith<$Res>? get penalty;
}

/// @nodoc
class __$$ScoreImplCopyWithImpl<$Res>
    extends _$ScoreCopyWithImpl<$Res, _$ScoreImpl>
    implements _$$ScoreImplCopyWith<$Res> {
  __$$ScoreImplCopyWithImpl(
      _$ScoreImpl _value, $Res Function(_$ScoreImpl) _then)
      : super(_value, _then);

  /// Create a copy of Score
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? halftime = null,
    Object? fulltime = null,
    Object? extratime = freezed,
    Object? penalty = freezed,
  }) {
    return _then(_$ScoreImpl(
      halftime: null == halftime
          ? _value.halftime
          : halftime // ignore: cast_nullable_to_non_nullable
              as Goals,
      fulltime: null == fulltime
          ? _value.fulltime
          : fulltime // ignore: cast_nullable_to_non_nullable
              as Goals,
      extratime: freezed == extratime
          ? _value.extratime
          : extratime // ignore: cast_nullable_to_non_nullable
              as Goals?,
      penalty: freezed == penalty
          ? _value.penalty
          : penalty // ignore: cast_nullable_to_non_nullable
              as Goals?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScoreImpl implements _Score {
  const _$ScoreImpl(
      {required this.halftime,
      required this.fulltime,
      this.extratime,
      this.penalty});

  factory _$ScoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScoreImplFromJson(json);

  @override
  final Goals halftime;
  @override
  final Goals fulltime;
  @override
  final Goals? extratime;
  @override
  final Goals? penalty;

  @override
  String toString() {
    return 'Score(halftime: $halftime, fulltime: $fulltime, extratime: $extratime, penalty: $penalty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScoreImpl &&
            (identical(other.halftime, halftime) ||
                other.halftime == halftime) &&
            (identical(other.fulltime, fulltime) ||
                other.fulltime == fulltime) &&
            (identical(other.extratime, extratime) ||
                other.extratime == extratime) &&
            (identical(other.penalty, penalty) || other.penalty == penalty));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, halftime, fulltime, extratime, penalty);

  /// Create a copy of Score
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScoreImplCopyWith<_$ScoreImpl> get copyWith =>
      __$$ScoreImplCopyWithImpl<_$ScoreImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScoreImplToJson(
      this,
    );
  }
}

abstract class _Score implements Score {
  const factory _Score(
      {required final Goals halftime,
      required final Goals fulltime,
      final Goals? extratime,
      final Goals? penalty}) = _$ScoreImpl;

  factory _Score.fromJson(Map<String, dynamic> json) = _$ScoreImpl.fromJson;

  @override
  Goals get halftime;
  @override
  Goals get fulltime;
  @override
  Goals? get extratime;
  @override
  Goals? get penalty;

  /// Create a copy of Score
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScoreImplCopyWith<_$ScoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Fixture _$FixtureFromJson(Map<String, dynamic> json) {
  return _Fixture.fromJson(json);
}

/// @nodoc
mixin _$Fixture {
  int get id => throw _privateConstructorUsedError;
  String? get referee => throw _privateConstructorUsedError;
  String get timezone => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;
  FixturePeriods? get periods => throw _privateConstructorUsedError;
  FixtureVenue get venue => throw _privateConstructorUsedError;
  FixtureStatus get status => throw _privateConstructorUsedError;

  /// Serializes this Fixture to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Fixture
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FixtureCopyWith<Fixture> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FixtureCopyWith<$Res> {
  factory $FixtureCopyWith(Fixture value, $Res Function(Fixture) then) =
      _$FixtureCopyWithImpl<$Res, Fixture>;
  @useResult
  $Res call(
      {int id,
      String? referee,
      String timezone,
      String date,
      int timestamp,
      FixturePeriods? periods,
      FixtureVenue venue,
      FixtureStatus status});

  $FixturePeriodsCopyWith<$Res>? get periods;
  $FixtureVenueCopyWith<$Res> get venue;
  $FixtureStatusCopyWith<$Res> get status;
}

/// @nodoc
class _$FixtureCopyWithImpl<$Res, $Val extends Fixture>
    implements $FixtureCopyWith<$Res> {
  _$FixtureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Fixture
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? referee = freezed,
    Object? timezone = null,
    Object? date = null,
    Object? timestamp = null,
    Object? periods = freezed,
    Object? venue = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      referee: freezed == referee
          ? _value.referee
          : referee // ignore: cast_nullable_to_non_nullable
              as String?,
      timezone: null == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      periods: freezed == periods
          ? _value.periods
          : periods // ignore: cast_nullable_to_non_nullable
              as FixturePeriods?,
      venue: null == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as FixtureVenue,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FixtureStatus,
    ) as $Val);
  }

  /// Create a copy of Fixture
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FixturePeriodsCopyWith<$Res>? get periods {
    if (_value.periods == null) {
      return null;
    }

    return $FixturePeriodsCopyWith<$Res>(_value.periods!, (value) {
      return _then(_value.copyWith(periods: value) as $Val);
    });
  }

  /// Create a copy of Fixture
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FixtureVenueCopyWith<$Res> get venue {
    return $FixtureVenueCopyWith<$Res>(_value.venue, (value) {
      return _then(_value.copyWith(venue: value) as $Val);
    });
  }

  /// Create a copy of Fixture
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FixtureStatusCopyWith<$Res> get status {
    return $FixtureStatusCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FixtureImplCopyWith<$Res> implements $FixtureCopyWith<$Res> {
  factory _$$FixtureImplCopyWith(
          _$FixtureImpl value, $Res Function(_$FixtureImpl) then) =
      __$$FixtureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? referee,
      String timezone,
      String date,
      int timestamp,
      FixturePeriods? periods,
      FixtureVenue venue,
      FixtureStatus status});

  @override
  $FixturePeriodsCopyWith<$Res>? get periods;
  @override
  $FixtureVenueCopyWith<$Res> get venue;
  @override
  $FixtureStatusCopyWith<$Res> get status;
}

/// @nodoc
class __$$FixtureImplCopyWithImpl<$Res>
    extends _$FixtureCopyWithImpl<$Res, _$FixtureImpl>
    implements _$$FixtureImplCopyWith<$Res> {
  __$$FixtureImplCopyWithImpl(
      _$FixtureImpl _value, $Res Function(_$FixtureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Fixture
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? referee = freezed,
    Object? timezone = null,
    Object? date = null,
    Object? timestamp = null,
    Object? periods = freezed,
    Object? venue = null,
    Object? status = null,
  }) {
    return _then(_$FixtureImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      referee: freezed == referee
          ? _value.referee
          : referee // ignore: cast_nullable_to_non_nullable
              as String?,
      timezone: null == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      periods: freezed == periods
          ? _value.periods
          : periods // ignore: cast_nullable_to_non_nullable
              as FixturePeriods?,
      venue: null == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as FixtureVenue,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FixtureStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FixtureImpl implements _Fixture {
  const _$FixtureImpl(
      {required this.id,
      this.referee,
      required this.timezone,
      required this.date,
      required this.timestamp,
      this.periods,
      required this.venue,
      required this.status});

  factory _$FixtureImpl.fromJson(Map<String, dynamic> json) =>
      _$$FixtureImplFromJson(json);

  @override
  final int id;
  @override
  final String? referee;
  @override
  final String timezone;
  @override
  final String date;
  @override
  final int timestamp;
  @override
  final FixturePeriods? periods;
  @override
  final FixtureVenue venue;
  @override
  final FixtureStatus status;

  @override
  String toString() {
    return 'Fixture(id: $id, referee: $referee, timezone: $timezone, date: $date, timestamp: $timestamp, periods: $periods, venue: $venue, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FixtureImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.referee, referee) || other.referee == referee) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.periods, periods) || other.periods == periods) &&
            (identical(other.venue, venue) || other.venue == venue) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, referee, timezone, date,
      timestamp, periods, venue, status);

  /// Create a copy of Fixture
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FixtureImplCopyWith<_$FixtureImpl> get copyWith =>
      __$$FixtureImplCopyWithImpl<_$FixtureImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FixtureImplToJson(
      this,
    );
  }
}

abstract class _Fixture implements Fixture {
  const factory _Fixture(
      {required final int id,
      final String? referee,
      required final String timezone,
      required final String date,
      required final int timestamp,
      final FixturePeriods? periods,
      required final FixtureVenue venue,
      required final FixtureStatus status}) = _$FixtureImpl;

  factory _Fixture.fromJson(Map<String, dynamic> json) = _$FixtureImpl.fromJson;

  @override
  int get id;
  @override
  String? get referee;
  @override
  String get timezone;
  @override
  String get date;
  @override
  int get timestamp;
  @override
  FixturePeriods? get periods;
  @override
  FixtureVenue get venue;
  @override
  FixtureStatus get status;

  /// Create a copy of Fixture
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FixtureImplCopyWith<_$FixtureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FixturePeriods _$FixturePeriodsFromJson(Map<String, dynamic> json) {
  return _FixturePeriods.fromJson(json);
}

/// @nodoc
mixin _$FixturePeriods {
  int? get first => throw _privateConstructorUsedError;
  int? get second => throw _privateConstructorUsedError;

  /// Serializes this FixturePeriods to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FixturePeriods
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FixturePeriodsCopyWith<FixturePeriods> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FixturePeriodsCopyWith<$Res> {
  factory $FixturePeriodsCopyWith(
          FixturePeriods value, $Res Function(FixturePeriods) then) =
      _$FixturePeriodsCopyWithImpl<$Res, FixturePeriods>;
  @useResult
  $Res call({int? first, int? second});
}

/// @nodoc
class _$FixturePeriodsCopyWithImpl<$Res, $Val extends FixturePeriods>
    implements $FixturePeriodsCopyWith<$Res> {
  _$FixturePeriodsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FixturePeriods
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? first = freezed,
    Object? second = freezed,
  }) {
    return _then(_value.copyWith(
      first: freezed == first
          ? _value.first
          : first // ignore: cast_nullable_to_non_nullable
              as int?,
      second: freezed == second
          ? _value.second
          : second // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FixturePeriodsImplCopyWith<$Res>
    implements $FixturePeriodsCopyWith<$Res> {
  factory _$$FixturePeriodsImplCopyWith(_$FixturePeriodsImpl value,
          $Res Function(_$FixturePeriodsImpl) then) =
      __$$FixturePeriodsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? first, int? second});
}

/// @nodoc
class __$$FixturePeriodsImplCopyWithImpl<$Res>
    extends _$FixturePeriodsCopyWithImpl<$Res, _$FixturePeriodsImpl>
    implements _$$FixturePeriodsImplCopyWith<$Res> {
  __$$FixturePeriodsImplCopyWithImpl(
      _$FixturePeriodsImpl _value, $Res Function(_$FixturePeriodsImpl) _then)
      : super(_value, _then);

  /// Create a copy of FixturePeriods
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? first = freezed,
    Object? second = freezed,
  }) {
    return _then(_$FixturePeriodsImpl(
      first: freezed == first
          ? _value.first
          : first // ignore: cast_nullable_to_non_nullable
              as int?,
      second: freezed == second
          ? _value.second
          : second // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FixturePeriodsImpl implements _FixturePeriods {
  const _$FixturePeriodsImpl({this.first, this.second});

  factory _$FixturePeriodsImpl.fromJson(Map<String, dynamic> json) =>
      _$$FixturePeriodsImplFromJson(json);

  @override
  final int? first;
  @override
  final int? second;

  @override
  String toString() {
    return 'FixturePeriods(first: $first, second: $second)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FixturePeriodsImpl &&
            (identical(other.first, first) || other.first == first) &&
            (identical(other.second, second) || other.second == second));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, first, second);

  /// Create a copy of FixturePeriods
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FixturePeriodsImplCopyWith<_$FixturePeriodsImpl> get copyWith =>
      __$$FixturePeriodsImplCopyWithImpl<_$FixturePeriodsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FixturePeriodsImplToJson(
      this,
    );
  }
}

abstract class _FixturePeriods implements FixturePeriods {
  const factory _FixturePeriods({final int? first, final int? second}) =
      _$FixturePeriodsImpl;

  factory _FixturePeriods.fromJson(Map<String, dynamic> json) =
      _$FixturePeriodsImpl.fromJson;

  @override
  int? get first;
  @override
  int? get second;

  /// Create a copy of FixturePeriods
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FixturePeriodsImplCopyWith<_$FixturePeriodsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FixtureVenue _$FixtureVenueFromJson(Map<String, dynamic> json) {
  return _FixtureVenue.fromJson(json);
}

/// @nodoc
mixin _$FixtureVenue {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;

  /// Serializes this FixtureVenue to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FixtureVenue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FixtureVenueCopyWith<FixtureVenue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FixtureVenueCopyWith<$Res> {
  factory $FixtureVenueCopyWith(
          FixtureVenue value, $Res Function(FixtureVenue) then) =
      _$FixtureVenueCopyWithImpl<$Res, FixtureVenue>;
  @useResult
  $Res call({int? id, String? name, String? city});
}

/// @nodoc
class _$FixtureVenueCopyWithImpl<$Res, $Val extends FixtureVenue>
    implements $FixtureVenueCopyWith<$Res> {
  _$FixtureVenueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FixtureVenue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? city = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FixtureVenueImplCopyWith<$Res>
    implements $FixtureVenueCopyWith<$Res> {
  factory _$$FixtureVenueImplCopyWith(
          _$FixtureVenueImpl value, $Res Function(_$FixtureVenueImpl) then) =
      __$$FixtureVenueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name, String? city});
}

/// @nodoc
class __$$FixtureVenueImplCopyWithImpl<$Res>
    extends _$FixtureVenueCopyWithImpl<$Res, _$FixtureVenueImpl>
    implements _$$FixtureVenueImplCopyWith<$Res> {
  __$$FixtureVenueImplCopyWithImpl(
      _$FixtureVenueImpl _value, $Res Function(_$FixtureVenueImpl) _then)
      : super(_value, _then);

  /// Create a copy of FixtureVenue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? city = freezed,
  }) {
    return _then(_$FixtureVenueImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FixtureVenueImpl implements _FixtureVenue {
  const _$FixtureVenueImpl({this.id, this.name, this.city});

  factory _$FixtureVenueImpl.fromJson(Map<String, dynamic> json) =>
      _$$FixtureVenueImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? city;

  @override
  String toString() {
    return 'FixtureVenue(id: $id, name: $name, city: $city)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FixtureVenueImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.city, city) || other.city == city));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, city);

  /// Create a copy of FixtureVenue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FixtureVenueImplCopyWith<_$FixtureVenueImpl> get copyWith =>
      __$$FixtureVenueImplCopyWithImpl<_$FixtureVenueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FixtureVenueImplToJson(
      this,
    );
  }
}

abstract class _FixtureVenue implements FixtureVenue {
  const factory _FixtureVenue(
      {final int? id,
      final String? name,
      final String? city}) = _$FixtureVenueImpl;

  factory _FixtureVenue.fromJson(Map<String, dynamic> json) =
      _$FixtureVenueImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get city;

  /// Create a copy of FixtureVenue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FixtureVenueImplCopyWith<_$FixtureVenueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FixtureStatus _$FixtureStatusFromJson(Map<String, dynamic> json) {
  return _FixtureStatus.fromJson(json);
}

/// @nodoc
mixin _$FixtureStatus {
  String get long => throw _privateConstructorUsedError;
  String get short => throw _privateConstructorUsedError;
  int? get elapsed => throw _privateConstructorUsedError;

  /// Serializes this FixtureStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FixtureStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FixtureStatusCopyWith<FixtureStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FixtureStatusCopyWith<$Res> {
  factory $FixtureStatusCopyWith(
          FixtureStatus value, $Res Function(FixtureStatus) then) =
      _$FixtureStatusCopyWithImpl<$Res, FixtureStatus>;
  @useResult
  $Res call({String long, String short, int? elapsed});
}

/// @nodoc
class _$FixtureStatusCopyWithImpl<$Res, $Val extends FixtureStatus>
    implements $FixtureStatusCopyWith<$Res> {
  _$FixtureStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FixtureStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? long = null,
    Object? short = null,
    Object? elapsed = freezed,
  }) {
    return _then(_value.copyWith(
      long: null == long
          ? _value.long
          : long // ignore: cast_nullable_to_non_nullable
              as String,
      short: null == short
          ? _value.short
          : short // ignore: cast_nullable_to_non_nullable
              as String,
      elapsed: freezed == elapsed
          ? _value.elapsed
          : elapsed // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FixtureStatusImplCopyWith<$Res>
    implements $FixtureStatusCopyWith<$Res> {
  factory _$$FixtureStatusImplCopyWith(
          _$FixtureStatusImpl value, $Res Function(_$FixtureStatusImpl) then) =
      __$$FixtureStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String long, String short, int? elapsed});
}

/// @nodoc
class __$$FixtureStatusImplCopyWithImpl<$Res>
    extends _$FixtureStatusCopyWithImpl<$Res, _$FixtureStatusImpl>
    implements _$$FixtureStatusImplCopyWith<$Res> {
  __$$FixtureStatusImplCopyWithImpl(
      _$FixtureStatusImpl _value, $Res Function(_$FixtureStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of FixtureStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? long = null,
    Object? short = null,
    Object? elapsed = freezed,
  }) {
    return _then(_$FixtureStatusImpl(
      long: null == long
          ? _value.long
          : long // ignore: cast_nullable_to_non_nullable
              as String,
      short: null == short
          ? _value.short
          : short // ignore: cast_nullable_to_non_nullable
              as String,
      elapsed: freezed == elapsed
          ? _value.elapsed
          : elapsed // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FixtureStatusImpl implements _FixtureStatus {
  const _$FixtureStatusImpl(
      {required this.long, required this.short, this.elapsed});

  factory _$FixtureStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$FixtureStatusImplFromJson(json);

  @override
  final String long;
  @override
  final String short;
  @override
  final int? elapsed;

  @override
  String toString() {
    return 'FixtureStatus(long: $long, short: $short, elapsed: $elapsed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FixtureStatusImpl &&
            (identical(other.long, long) || other.long == long) &&
            (identical(other.short, short) || other.short == short) &&
            (identical(other.elapsed, elapsed) || other.elapsed == elapsed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, long, short, elapsed);

  /// Create a copy of FixtureStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FixtureStatusImplCopyWith<_$FixtureStatusImpl> get copyWith =>
      __$$FixtureStatusImplCopyWithImpl<_$FixtureStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FixtureStatusImplToJson(
      this,
    );
  }
}

abstract class _FixtureStatus implements FixtureStatus {
  const factory _FixtureStatus(
      {required final String long,
      required final String short,
      final int? elapsed}) = _$FixtureStatusImpl;

  factory _FixtureStatus.fromJson(Map<String, dynamic> json) =
      _$FixtureStatusImpl.fromJson;

  @override
  String get long;
  @override
  String get short;
  @override
  int? get elapsed;

  /// Create a copy of FixtureStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FixtureStatusImplCopyWith<_$FixtureStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
