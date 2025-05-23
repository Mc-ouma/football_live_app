// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prediction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PredictionResponse _$PredictionResponseFromJson(Map<String, dynamic> json) {
  return _PredictionResponse.fromJson(json);
}

/// @nodoc
mixin _$PredictionResponse {
  String get get => throw _privateConstructorUsedError;
  Map<String, dynamic> get parameters => throw _privateConstructorUsedError;
  Map<String, dynamic> get errors => throw _privateConstructorUsedError;
  int get results => throw _privateConstructorUsedError;
  List<PredictionData> get response => throw _privateConstructorUsedError;

  /// Serializes this PredictionResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PredictionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PredictionResponseCopyWith<PredictionResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PredictionResponseCopyWith<$Res> {
  factory $PredictionResponseCopyWith(
          PredictionResponse value, $Res Function(PredictionResponse) then) =
      _$PredictionResponseCopyWithImpl<$Res, PredictionResponse>;
  @useResult
  $Res call(
      {String get,
      Map<String, dynamic> parameters,
      Map<String, dynamic> errors,
      int results,
      List<PredictionData> response});
}

/// @nodoc
class _$PredictionResponseCopyWithImpl<$Res, $Val extends PredictionResponse>
    implements $PredictionResponseCopyWith<$Res> {
  _$PredictionResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PredictionResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? get = null,
    Object? parameters = null,
    Object? errors = null,
    Object? results = null,
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
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as List<PredictionData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PredictionResponseImplCopyWith<$Res>
    implements $PredictionResponseCopyWith<$Res> {
  factory _$$PredictionResponseImplCopyWith(_$PredictionResponseImpl value,
          $Res Function(_$PredictionResponseImpl) then) =
      __$$PredictionResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String get,
      Map<String, dynamic> parameters,
      Map<String, dynamic> errors,
      int results,
      List<PredictionData> response});
}

/// @nodoc
class __$$PredictionResponseImplCopyWithImpl<$Res>
    extends _$PredictionResponseCopyWithImpl<$Res, _$PredictionResponseImpl>
    implements _$$PredictionResponseImplCopyWith<$Res> {
  __$$PredictionResponseImplCopyWithImpl(_$PredictionResponseImpl _value,
      $Res Function(_$PredictionResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PredictionResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? get = null,
    Object? parameters = null,
    Object? errors = null,
    Object? results = null,
    Object? response = null,
  }) {
    return _then(_$PredictionResponseImpl(
      get: null == get
          ? _value.get
          : get // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: null == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      errors: null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as int,
      response: null == response
          ? _value._response
          : response // ignore: cast_nullable_to_non_nullable
              as List<PredictionData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PredictionResponseImpl implements _PredictionResponse {
  const _$PredictionResponseImpl(
      {required this.get,
      required final Map<String, dynamic> parameters,
      required final Map<String, dynamic> errors,
      required this.results,
      required final List<PredictionData> response})
      : _parameters = parameters,
        _errors = errors,
        _response = response;

  factory _$PredictionResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PredictionResponseImplFromJson(json);

  @override
  final String get;
  final Map<String, dynamic> _parameters;
  @override
  Map<String, dynamic> get parameters {
    if (_parameters is EqualUnmodifiableMapView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_parameters);
  }

  final Map<String, dynamic> _errors;
  @override
  Map<String, dynamic> get errors {
    if (_errors is EqualUnmodifiableMapView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_errors);
  }

  @override
  final int results;
  final List<PredictionData> _response;
  @override
  List<PredictionData> get response {
    if (_response is EqualUnmodifiableListView) return _response;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_response);
  }

  @override
  String toString() {
    return 'PredictionResponse(get: $get, parameters: $parameters, errors: $errors, results: $results, response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PredictionResponseImpl &&
            (identical(other.get, get) || other.get == get) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters) &&
            const DeepCollectionEquality().equals(other._errors, _errors) &&
            (identical(other.results, results) || other.results == results) &&
            const DeepCollectionEquality().equals(other._response, _response));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      get,
      const DeepCollectionEquality().hash(_parameters),
      const DeepCollectionEquality().hash(_errors),
      results,
      const DeepCollectionEquality().hash(_response));

  /// Create a copy of PredictionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PredictionResponseImplCopyWith<_$PredictionResponseImpl> get copyWith =>
      __$$PredictionResponseImplCopyWithImpl<_$PredictionResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PredictionResponseImplToJson(
      this,
    );
  }
}

abstract class _PredictionResponse implements PredictionResponse {
  const factory _PredictionResponse(
      {required final String get,
      required final Map<String, dynamic> parameters,
      required final Map<String, dynamic> errors,
      required final int results,
      required final List<PredictionData> response}) = _$PredictionResponseImpl;

  factory _PredictionResponse.fromJson(Map<String, dynamic> json) =
      _$PredictionResponseImpl.fromJson;

  @override
  String get get;
  @override
  Map<String, dynamic> get parameters;
  @override
  Map<String, dynamic> get errors;
  @override
  int get results;
  @override
  List<PredictionData> get response;

  /// Create a copy of PredictionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PredictionResponseImplCopyWith<_$PredictionResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PredictionData _$PredictionDataFromJson(Map<String, dynamic> json) {
  return _PredictionData.fromJson(json);
}

/// @nodoc
mixin _$PredictionData {
  Predictions get predictions => throw _privateConstructorUsedError;
  League get league => throw _privateConstructorUsedError;
  Fixture get fixture => throw _privateConstructorUsedError;
  Teams get teams => throw _privateConstructorUsedError;

  /// Serializes this PredictionData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PredictionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PredictionDataCopyWith<PredictionData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PredictionDataCopyWith<$Res> {
  factory $PredictionDataCopyWith(
          PredictionData value, $Res Function(PredictionData) then) =
      _$PredictionDataCopyWithImpl<$Res, PredictionData>;
  @useResult
  $Res call(
      {Predictions predictions, League league, Fixture fixture, Teams teams});

  $PredictionsCopyWith<$Res> get predictions;
  $LeagueCopyWith<$Res> get league;
  $FixtureCopyWith<$Res> get fixture;
  $TeamsCopyWith<$Res> get teams;
}

/// @nodoc
class _$PredictionDataCopyWithImpl<$Res, $Val extends PredictionData>
    implements $PredictionDataCopyWith<$Res> {
  _$PredictionDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PredictionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? predictions = null,
    Object? league = null,
    Object? fixture = null,
    Object? teams = null,
  }) {
    return _then(_value.copyWith(
      predictions: null == predictions
          ? _value.predictions
          : predictions // ignore: cast_nullable_to_non_nullable
              as Predictions,
      league: null == league
          ? _value.league
          : league // ignore: cast_nullable_to_non_nullable
              as League,
      fixture: null == fixture
          ? _value.fixture
          : fixture // ignore: cast_nullable_to_non_nullable
              as Fixture,
      teams: null == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as Teams,
    ) as $Val);
  }

  /// Create a copy of PredictionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PredictionsCopyWith<$Res> get predictions {
    return $PredictionsCopyWith<$Res>(_value.predictions, (value) {
      return _then(_value.copyWith(predictions: value) as $Val);
    });
  }

  /// Create a copy of PredictionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LeagueCopyWith<$Res> get league {
    return $LeagueCopyWith<$Res>(_value.league, (value) {
      return _then(_value.copyWith(league: value) as $Val);
    });
  }

  /// Create a copy of PredictionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FixtureCopyWith<$Res> get fixture {
    return $FixtureCopyWith<$Res>(_value.fixture, (value) {
      return _then(_value.copyWith(fixture: value) as $Val);
    });
  }

  /// Create a copy of PredictionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TeamsCopyWith<$Res> get teams {
    return $TeamsCopyWith<$Res>(_value.teams, (value) {
      return _then(_value.copyWith(teams: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PredictionDataImplCopyWith<$Res>
    implements $PredictionDataCopyWith<$Res> {
  factory _$$PredictionDataImplCopyWith(_$PredictionDataImpl value,
          $Res Function(_$PredictionDataImpl) then) =
      __$$PredictionDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Predictions predictions, League league, Fixture fixture, Teams teams});

  @override
  $PredictionsCopyWith<$Res> get predictions;
  @override
  $LeagueCopyWith<$Res> get league;
  @override
  $FixtureCopyWith<$Res> get fixture;
  @override
  $TeamsCopyWith<$Res> get teams;
}

/// @nodoc
class __$$PredictionDataImplCopyWithImpl<$Res>
    extends _$PredictionDataCopyWithImpl<$Res, _$PredictionDataImpl>
    implements _$$PredictionDataImplCopyWith<$Res> {
  __$$PredictionDataImplCopyWithImpl(
      _$PredictionDataImpl _value, $Res Function(_$PredictionDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of PredictionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? predictions = null,
    Object? league = null,
    Object? fixture = null,
    Object? teams = null,
  }) {
    return _then(_$PredictionDataImpl(
      predictions: null == predictions
          ? _value.predictions
          : predictions // ignore: cast_nullable_to_non_nullable
              as Predictions,
      league: null == league
          ? _value.league
          : league // ignore: cast_nullable_to_non_nullable
              as League,
      fixture: null == fixture
          ? _value.fixture
          : fixture // ignore: cast_nullable_to_non_nullable
              as Fixture,
      teams: null == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as Teams,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PredictionDataImpl implements _PredictionData {
  const _$PredictionDataImpl(
      {required this.predictions,
      required this.league,
      required this.fixture,
      required this.teams});

  factory _$PredictionDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PredictionDataImplFromJson(json);

  @override
  final Predictions predictions;
  @override
  final League league;
  @override
  final Fixture fixture;
  @override
  final Teams teams;

  @override
  String toString() {
    return 'PredictionData(predictions: $predictions, league: $league, fixture: $fixture, teams: $teams)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PredictionDataImpl &&
            (identical(other.predictions, predictions) ||
                other.predictions == predictions) &&
            (identical(other.league, league) || other.league == league) &&
            (identical(other.fixture, fixture) || other.fixture == fixture) &&
            (identical(other.teams, teams) || other.teams == teams));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, predictions, league, fixture, teams);

  /// Create a copy of PredictionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PredictionDataImplCopyWith<_$PredictionDataImpl> get copyWith =>
      __$$PredictionDataImplCopyWithImpl<_$PredictionDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PredictionDataImplToJson(
      this,
    );
  }
}

abstract class _PredictionData implements PredictionData {
  const factory _PredictionData(
      {required final Predictions predictions,
      required final League league,
      required final Fixture fixture,
      required final Teams teams}) = _$PredictionDataImpl;

  factory _PredictionData.fromJson(Map<String, dynamic> json) =
      _$PredictionDataImpl.fromJson;

  @override
  Predictions get predictions;
  @override
  League get league;
  @override
  Fixture get fixture;
  @override
  Teams get teams;

  /// Create a copy of PredictionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PredictionDataImplCopyWith<_$PredictionDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Predictions _$PredictionsFromJson(Map<String, dynamic> json) {
  return _Predictions.fromJson(json);
}

/// @nodoc
mixin _$Predictions {
  String get winner => throw _privateConstructorUsedError;
  WinnerPercentage get winnerSide => throw _privateConstructorUsedError;
  bool get underOver => throw _privateConstructorUsedError;
  bool get goals => throw _privateConstructorUsedError;
  bool get advice => throw _privateConstructorUsedError;
  double? get percent => throw _privateConstructorUsedError;

  /// Serializes this Predictions to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Predictions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PredictionsCopyWith<Predictions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PredictionsCopyWith<$Res> {
  factory $PredictionsCopyWith(
          Predictions value, $Res Function(Predictions) then) =
      _$PredictionsCopyWithImpl<$Res, Predictions>;
  @useResult
  $Res call(
      {String winner,
      WinnerPercentage winnerSide,
      bool underOver,
      bool goals,
      bool advice,
      double? percent});

  $WinnerPercentageCopyWith<$Res> get winnerSide;
}

/// @nodoc
class _$PredictionsCopyWithImpl<$Res, $Val extends Predictions>
    implements $PredictionsCopyWith<$Res> {
  _$PredictionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Predictions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? winner = null,
    Object? winnerSide = null,
    Object? underOver = null,
    Object? goals = null,
    Object? advice = null,
    Object? percent = freezed,
  }) {
    return _then(_value.copyWith(
      winner: null == winner
          ? _value.winner
          : winner // ignore: cast_nullable_to_non_nullable
              as String,
      winnerSide: null == winnerSide
          ? _value.winnerSide
          : winnerSide // ignore: cast_nullable_to_non_nullable
              as WinnerPercentage,
      underOver: null == underOver
          ? _value.underOver
          : underOver // ignore: cast_nullable_to_non_nullable
              as bool,
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as bool,
      advice: null == advice
          ? _value.advice
          : advice // ignore: cast_nullable_to_non_nullable
              as bool,
      percent: freezed == percent
          ? _value.percent
          : percent // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }

  /// Create a copy of Predictions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WinnerPercentageCopyWith<$Res> get winnerSide {
    return $WinnerPercentageCopyWith<$Res>(_value.winnerSide, (value) {
      return _then(_value.copyWith(winnerSide: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PredictionsImplCopyWith<$Res>
    implements $PredictionsCopyWith<$Res> {
  factory _$$PredictionsImplCopyWith(
          _$PredictionsImpl value, $Res Function(_$PredictionsImpl) then) =
      __$$PredictionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String winner,
      WinnerPercentage winnerSide,
      bool underOver,
      bool goals,
      bool advice,
      double? percent});

  @override
  $WinnerPercentageCopyWith<$Res> get winnerSide;
}

/// @nodoc
class __$$PredictionsImplCopyWithImpl<$Res>
    extends _$PredictionsCopyWithImpl<$Res, _$PredictionsImpl>
    implements _$$PredictionsImplCopyWith<$Res> {
  __$$PredictionsImplCopyWithImpl(
      _$PredictionsImpl _value, $Res Function(_$PredictionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Predictions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? winner = null,
    Object? winnerSide = null,
    Object? underOver = null,
    Object? goals = null,
    Object? advice = null,
    Object? percent = freezed,
  }) {
    return _then(_$PredictionsImpl(
      winner: null == winner
          ? _value.winner
          : winner // ignore: cast_nullable_to_non_nullable
              as String,
      winnerSide: null == winnerSide
          ? _value.winnerSide
          : winnerSide // ignore: cast_nullable_to_non_nullable
              as WinnerPercentage,
      underOver: null == underOver
          ? _value.underOver
          : underOver // ignore: cast_nullable_to_non_nullable
              as bool,
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as bool,
      advice: null == advice
          ? _value.advice
          : advice // ignore: cast_nullable_to_non_nullable
              as bool,
      percent: freezed == percent
          ? _value.percent
          : percent // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PredictionsImpl implements _Predictions {
  const _$PredictionsImpl(
      {required this.winner,
      required this.winnerSide,
      required this.underOver,
      required this.goals,
      required this.advice,
      required this.percent});

  factory _$PredictionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PredictionsImplFromJson(json);

  @override
  final String winner;
  @override
  final WinnerPercentage winnerSide;
  @override
  final bool underOver;
  @override
  final bool goals;
  @override
  final bool advice;
  @override
  final double? percent;

  @override
  String toString() {
    return 'Predictions(winner: $winner, winnerSide: $winnerSide, underOver: $underOver, goals: $goals, advice: $advice, percent: $percent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PredictionsImpl &&
            (identical(other.winner, winner) || other.winner == winner) &&
            (identical(other.winnerSide, winnerSide) ||
                other.winnerSide == winnerSide) &&
            (identical(other.underOver, underOver) ||
                other.underOver == underOver) &&
            (identical(other.goals, goals) || other.goals == goals) &&
            (identical(other.advice, advice) || other.advice == advice) &&
            (identical(other.percent, percent) || other.percent == percent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, winner, winnerSide, underOver, goals, advice, percent);

  /// Create a copy of Predictions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PredictionsImplCopyWith<_$PredictionsImpl> get copyWith =>
      __$$PredictionsImplCopyWithImpl<_$PredictionsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PredictionsImplToJson(
      this,
    );
  }
}

abstract class _Predictions implements Predictions {
  const factory _Predictions(
      {required final String winner,
      required final WinnerPercentage winnerSide,
      required final bool underOver,
      required final bool goals,
      required final bool advice,
      required final double? percent}) = _$PredictionsImpl;

  factory _Predictions.fromJson(Map<String, dynamic> json) =
      _$PredictionsImpl.fromJson;

  @override
  String get winner;
  @override
  WinnerPercentage get winnerSide;
  @override
  bool get underOver;
  @override
  bool get goals;
  @override
  bool get advice;
  @override
  double? get percent;

  /// Create a copy of Predictions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PredictionsImplCopyWith<_$PredictionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WinnerPercentage _$WinnerPercentageFromJson(Map<String, dynamic> json) {
  return _WinnerPercentage.fromJson(json);
}

/// @nodoc
mixin _$WinnerPercentage {
  String get home => throw _privateConstructorUsedError;
  String get draw => throw _privateConstructorUsedError;
  String get away => throw _privateConstructorUsedError;

  /// Serializes this WinnerPercentage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WinnerPercentage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WinnerPercentageCopyWith<WinnerPercentage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WinnerPercentageCopyWith<$Res> {
  factory $WinnerPercentageCopyWith(
          WinnerPercentage value, $Res Function(WinnerPercentage) then) =
      _$WinnerPercentageCopyWithImpl<$Res, WinnerPercentage>;
  @useResult
  $Res call({String home, String draw, String away});
}

/// @nodoc
class _$WinnerPercentageCopyWithImpl<$Res, $Val extends WinnerPercentage>
    implements $WinnerPercentageCopyWith<$Res> {
  _$WinnerPercentageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WinnerPercentage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? home = null,
    Object? draw = null,
    Object? away = null,
  }) {
    return _then(_value.copyWith(
      home: null == home
          ? _value.home
          : home // ignore: cast_nullable_to_non_nullable
              as String,
      draw: null == draw
          ? _value.draw
          : draw // ignore: cast_nullable_to_non_nullable
              as String,
      away: null == away
          ? _value.away
          : away // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WinnerPercentageImplCopyWith<$Res>
    implements $WinnerPercentageCopyWith<$Res> {
  factory _$$WinnerPercentageImplCopyWith(_$WinnerPercentageImpl value,
          $Res Function(_$WinnerPercentageImpl) then) =
      __$$WinnerPercentageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String home, String draw, String away});
}

/// @nodoc
class __$$WinnerPercentageImplCopyWithImpl<$Res>
    extends _$WinnerPercentageCopyWithImpl<$Res, _$WinnerPercentageImpl>
    implements _$$WinnerPercentageImplCopyWith<$Res> {
  __$$WinnerPercentageImplCopyWithImpl(_$WinnerPercentageImpl _value,
      $Res Function(_$WinnerPercentageImpl) _then)
      : super(_value, _then);

  /// Create a copy of WinnerPercentage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? home = null,
    Object? draw = null,
    Object? away = null,
  }) {
    return _then(_$WinnerPercentageImpl(
      home: null == home
          ? _value.home
          : home // ignore: cast_nullable_to_non_nullable
              as String,
      draw: null == draw
          ? _value.draw
          : draw // ignore: cast_nullable_to_non_nullable
              as String,
      away: null == away
          ? _value.away
          : away // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WinnerPercentageImpl implements _WinnerPercentage {
  const _$WinnerPercentageImpl(
      {required this.home, required this.draw, required this.away});

  factory _$WinnerPercentageImpl.fromJson(Map<String, dynamic> json) =>
      _$$WinnerPercentageImplFromJson(json);

  @override
  final String home;
  @override
  final String draw;
  @override
  final String away;

  @override
  String toString() {
    return 'WinnerPercentage(home: $home, draw: $draw, away: $away)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WinnerPercentageImpl &&
            (identical(other.home, home) || other.home == home) &&
            (identical(other.draw, draw) || other.draw == draw) &&
            (identical(other.away, away) || other.away == away));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, home, draw, away);

  /// Create a copy of WinnerPercentage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WinnerPercentageImplCopyWith<_$WinnerPercentageImpl> get copyWith =>
      __$$WinnerPercentageImplCopyWithImpl<_$WinnerPercentageImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WinnerPercentageImplToJson(
      this,
    );
  }
}

abstract class _WinnerPercentage implements WinnerPercentage {
  const factory _WinnerPercentage(
      {required final String home,
      required final String draw,
      required final String away}) = _$WinnerPercentageImpl;

  factory _WinnerPercentage.fromJson(Map<String, dynamic> json) =
      _$WinnerPercentageImpl.fromJson;

  @override
  String get home;
  @override
  String get draw;
  @override
  String get away;

  /// Create a copy of WinnerPercentage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WinnerPercentageImplCopyWith<_$WinnerPercentageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Comparison _$ComparisonFromJson(Map<String, dynamic> json) {
  return _Comparison.fromJson(json);
}

/// @nodoc
mixin _$Comparison {
  FormComparison get form => throw _privateConstructorUsedError;
  AttackComparison get att => throw _privateConstructorUsedError;
  DefenseComparison get def => throw _privateConstructorUsedError;
  PoissionDistribution get poisson_distribution =>
      throw _privateConstructorUsedError;
  GoalsComparison get goals => throw _privateConstructorUsedError;
  TotalComparison get total => throw _privateConstructorUsedError;

  /// Serializes this Comparison to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Comparison
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ComparisonCopyWith<Comparison> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComparisonCopyWith<$Res> {
  factory $ComparisonCopyWith(
          Comparison value, $Res Function(Comparison) then) =
      _$ComparisonCopyWithImpl<$Res, Comparison>;
  @useResult
  $Res call(
      {FormComparison form,
      AttackComparison att,
      DefenseComparison def,
      PoissionDistribution poisson_distribution,
      GoalsComparison goals,
      TotalComparison total});

  $FormComparisonCopyWith<$Res> get form;
  $AttackComparisonCopyWith<$Res> get att;
  $DefenseComparisonCopyWith<$Res> get def;
  $PoissionDistributionCopyWith<$Res> get poisson_distribution;
  $GoalsComparisonCopyWith<$Res> get goals;
  $TotalComparisonCopyWith<$Res> get total;
}

/// @nodoc
class _$ComparisonCopyWithImpl<$Res, $Val extends Comparison>
    implements $ComparisonCopyWith<$Res> {
  _$ComparisonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Comparison
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? form = null,
    Object? att = null,
    Object? def = null,
    Object? poisson_distribution = null,
    Object? goals = null,
    Object? total = null,
  }) {
    return _then(_value.copyWith(
      form: null == form
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as FormComparison,
      att: null == att
          ? _value.att
          : att // ignore: cast_nullable_to_non_nullable
              as AttackComparison,
      def: null == def
          ? _value.def
          : def // ignore: cast_nullable_to_non_nullable
              as DefenseComparison,
      poisson_distribution: null == poisson_distribution
          ? _value.poisson_distribution
          : poisson_distribution // ignore: cast_nullable_to_non_nullable
              as PoissionDistribution,
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as GoalsComparison,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as TotalComparison,
    ) as $Val);
  }

  /// Create a copy of Comparison
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FormComparisonCopyWith<$Res> get form {
    return $FormComparisonCopyWith<$Res>(_value.form, (value) {
      return _then(_value.copyWith(form: value) as $Val);
    });
  }

  /// Create a copy of Comparison
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AttackComparisonCopyWith<$Res> get att {
    return $AttackComparisonCopyWith<$Res>(_value.att, (value) {
      return _then(_value.copyWith(att: value) as $Val);
    });
  }

  /// Create a copy of Comparison
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DefenseComparisonCopyWith<$Res> get def {
    return $DefenseComparisonCopyWith<$Res>(_value.def, (value) {
      return _then(_value.copyWith(def: value) as $Val);
    });
  }

  /// Create a copy of Comparison
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PoissionDistributionCopyWith<$Res> get poisson_distribution {
    return $PoissionDistributionCopyWith<$Res>(_value.poisson_distribution,
        (value) {
      return _then(_value.copyWith(poisson_distribution: value) as $Val);
    });
  }

  /// Create a copy of Comparison
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GoalsComparisonCopyWith<$Res> get goals {
    return $GoalsComparisonCopyWith<$Res>(_value.goals, (value) {
      return _then(_value.copyWith(goals: value) as $Val);
    });
  }

  /// Create a copy of Comparison
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TotalComparisonCopyWith<$Res> get total {
    return $TotalComparisonCopyWith<$Res>(_value.total, (value) {
      return _then(_value.copyWith(total: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ComparisonImplCopyWith<$Res>
    implements $ComparisonCopyWith<$Res> {
  factory _$$ComparisonImplCopyWith(
          _$ComparisonImpl value, $Res Function(_$ComparisonImpl) then) =
      __$$ComparisonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {FormComparison form,
      AttackComparison att,
      DefenseComparison def,
      PoissionDistribution poisson_distribution,
      GoalsComparison goals,
      TotalComparison total});

  @override
  $FormComparisonCopyWith<$Res> get form;
  @override
  $AttackComparisonCopyWith<$Res> get att;
  @override
  $DefenseComparisonCopyWith<$Res> get def;
  @override
  $PoissionDistributionCopyWith<$Res> get poisson_distribution;
  @override
  $GoalsComparisonCopyWith<$Res> get goals;
  @override
  $TotalComparisonCopyWith<$Res> get total;
}

/// @nodoc
class __$$ComparisonImplCopyWithImpl<$Res>
    extends _$ComparisonCopyWithImpl<$Res, _$ComparisonImpl>
    implements _$$ComparisonImplCopyWith<$Res> {
  __$$ComparisonImplCopyWithImpl(
      _$ComparisonImpl _value, $Res Function(_$ComparisonImpl) _then)
      : super(_value, _then);

  /// Create a copy of Comparison
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? form = null,
    Object? att = null,
    Object? def = null,
    Object? poisson_distribution = null,
    Object? goals = null,
    Object? total = null,
  }) {
    return _then(_$ComparisonImpl(
      form: null == form
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as FormComparison,
      att: null == att
          ? _value.att
          : att // ignore: cast_nullable_to_non_nullable
              as AttackComparison,
      def: null == def
          ? _value.def
          : def // ignore: cast_nullable_to_non_nullable
              as DefenseComparison,
      poisson_distribution: null == poisson_distribution
          ? _value.poisson_distribution
          : poisson_distribution // ignore: cast_nullable_to_non_nullable
              as PoissionDistribution,
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as GoalsComparison,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as TotalComparison,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ComparisonImpl implements _Comparison {
  const _$ComparisonImpl(
      {required this.form,
      required this.att,
      required this.def,
      required this.poisson_distribution,
      required this.goals,
      required this.total});

  factory _$ComparisonImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComparisonImplFromJson(json);

  @override
  final FormComparison form;
  @override
  final AttackComparison att;
  @override
  final DefenseComparison def;
  @override
  final PoissionDistribution poisson_distribution;
  @override
  final GoalsComparison goals;
  @override
  final TotalComparison total;

  @override
  String toString() {
    return 'Comparison(form: $form, att: $att, def: $def, poisson_distribution: $poisson_distribution, goals: $goals, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComparisonImpl &&
            (identical(other.form, form) || other.form == form) &&
            (identical(other.att, att) || other.att == att) &&
            (identical(other.def, def) || other.def == def) &&
            (identical(other.poisson_distribution, poisson_distribution) ||
                other.poisson_distribution == poisson_distribution) &&
            (identical(other.goals, goals) || other.goals == goals) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, form, att, def, poisson_distribution, goals, total);

  /// Create a copy of Comparison
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ComparisonImplCopyWith<_$ComparisonImpl> get copyWith =>
      __$$ComparisonImplCopyWithImpl<_$ComparisonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComparisonImplToJson(
      this,
    );
  }
}

abstract class _Comparison implements Comparison {
  const factory _Comparison(
      {required final FormComparison form,
      required final AttackComparison att,
      required final DefenseComparison def,
      required final PoissionDistribution poisson_distribution,
      required final GoalsComparison goals,
      required final TotalComparison total}) = _$ComparisonImpl;

  factory _Comparison.fromJson(Map<String, dynamic> json) =
      _$ComparisonImpl.fromJson;

  @override
  FormComparison get form;
  @override
  AttackComparison get att;
  @override
  DefenseComparison get def;
  @override
  PoissionDistribution get poisson_distribution;
  @override
  GoalsComparison get goals;
  @override
  TotalComparison get total;

  /// Create a copy of Comparison
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ComparisonImplCopyWith<_$ComparisonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FormComparison _$FormComparisonFromJson(Map<String, dynamic> json) {
  return _FormComparison.fromJson(json);
}

/// @nodoc
mixin _$FormComparison {
  String get home => throw _privateConstructorUsedError;
  String get away => throw _privateConstructorUsedError;

  /// Serializes this FormComparison to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FormComparison
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FormComparisonCopyWith<FormComparison> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormComparisonCopyWith<$Res> {
  factory $FormComparisonCopyWith(
          FormComparison value, $Res Function(FormComparison) then) =
      _$FormComparisonCopyWithImpl<$Res, FormComparison>;
  @useResult
  $Res call({String home, String away});
}

/// @nodoc
class _$FormComparisonCopyWithImpl<$Res, $Val extends FormComparison>
    implements $FormComparisonCopyWith<$Res> {
  _$FormComparisonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FormComparison
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
              as String,
      away: null == away
          ? _value.away
          : away // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FormComparisonImplCopyWith<$Res>
    implements $FormComparisonCopyWith<$Res> {
  factory _$$FormComparisonImplCopyWith(_$FormComparisonImpl value,
          $Res Function(_$FormComparisonImpl) then) =
      __$$FormComparisonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String home, String away});
}

/// @nodoc
class __$$FormComparisonImplCopyWithImpl<$Res>
    extends _$FormComparisonCopyWithImpl<$Res, _$FormComparisonImpl>
    implements _$$FormComparisonImplCopyWith<$Res> {
  __$$FormComparisonImplCopyWithImpl(
      _$FormComparisonImpl _value, $Res Function(_$FormComparisonImpl) _then)
      : super(_value, _then);

  /// Create a copy of FormComparison
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? home = null,
    Object? away = null,
  }) {
    return _then(_$FormComparisonImpl(
      home: null == home
          ? _value.home
          : home // ignore: cast_nullable_to_non_nullable
              as String,
      away: null == away
          ? _value.away
          : away // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FormComparisonImpl implements _FormComparison {
  const _$FormComparisonImpl({required this.home, required this.away});

  factory _$FormComparisonImpl.fromJson(Map<String, dynamic> json) =>
      _$$FormComparisonImplFromJson(json);

  @override
  final String home;
  @override
  final String away;

  @override
  String toString() {
    return 'FormComparison(home: $home, away: $away)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FormComparisonImpl &&
            (identical(other.home, home) || other.home == home) &&
            (identical(other.away, away) || other.away == away));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, home, away);

  /// Create a copy of FormComparison
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FormComparisonImplCopyWith<_$FormComparisonImpl> get copyWith =>
      __$$FormComparisonImplCopyWithImpl<_$FormComparisonImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FormComparisonImplToJson(
      this,
    );
  }
}

abstract class _FormComparison implements FormComparison {
  const factory _FormComparison(
      {required final String home,
      required final String away}) = _$FormComparisonImpl;

  factory _FormComparison.fromJson(Map<String, dynamic> json) =
      _$FormComparisonImpl.fromJson;

  @override
  String get home;
  @override
  String get away;

  /// Create a copy of FormComparison
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FormComparisonImplCopyWith<_$FormComparisonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AttackComparison _$AttackComparisonFromJson(Map<String, dynamic> json) {
  return _AttackComparison.fromJson(json);
}

/// @nodoc
mixin _$AttackComparison {
  String get home => throw _privateConstructorUsedError;
  String get away => throw _privateConstructorUsedError;

  /// Serializes this AttackComparison to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttackComparison
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttackComparisonCopyWith<AttackComparison> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttackComparisonCopyWith<$Res> {
  factory $AttackComparisonCopyWith(
          AttackComparison value, $Res Function(AttackComparison) then) =
      _$AttackComparisonCopyWithImpl<$Res, AttackComparison>;
  @useResult
  $Res call({String home, String away});
}

/// @nodoc
class _$AttackComparisonCopyWithImpl<$Res, $Val extends AttackComparison>
    implements $AttackComparisonCopyWith<$Res> {
  _$AttackComparisonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttackComparison
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
              as String,
      away: null == away
          ? _value.away
          : away // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttackComparisonImplCopyWith<$Res>
    implements $AttackComparisonCopyWith<$Res> {
  factory _$$AttackComparisonImplCopyWith(_$AttackComparisonImpl value,
          $Res Function(_$AttackComparisonImpl) then) =
      __$$AttackComparisonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String home, String away});
}

/// @nodoc
class __$$AttackComparisonImplCopyWithImpl<$Res>
    extends _$AttackComparisonCopyWithImpl<$Res, _$AttackComparisonImpl>
    implements _$$AttackComparisonImplCopyWith<$Res> {
  __$$AttackComparisonImplCopyWithImpl(_$AttackComparisonImpl _value,
      $Res Function(_$AttackComparisonImpl) _then)
      : super(_value, _then);

  /// Create a copy of AttackComparison
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? home = null,
    Object? away = null,
  }) {
    return _then(_$AttackComparisonImpl(
      home: null == home
          ? _value.home
          : home // ignore: cast_nullable_to_non_nullable
              as String,
      away: null == away
          ? _value.away
          : away // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttackComparisonImpl implements _AttackComparison {
  const _$AttackComparisonImpl({required this.home, required this.away});

  factory _$AttackComparisonImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttackComparisonImplFromJson(json);

  @override
  final String home;
  @override
  final String away;

  @override
  String toString() {
    return 'AttackComparison(home: $home, away: $away)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttackComparisonImpl &&
            (identical(other.home, home) || other.home == home) &&
            (identical(other.away, away) || other.away == away));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, home, away);

  /// Create a copy of AttackComparison
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttackComparisonImplCopyWith<_$AttackComparisonImpl> get copyWith =>
      __$$AttackComparisonImplCopyWithImpl<_$AttackComparisonImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttackComparisonImplToJson(
      this,
    );
  }
}

abstract class _AttackComparison implements AttackComparison {
  const factory _AttackComparison(
      {required final String home,
      required final String away}) = _$AttackComparisonImpl;

  factory _AttackComparison.fromJson(Map<String, dynamic> json) =
      _$AttackComparisonImpl.fromJson;

  @override
  String get home;
  @override
  String get away;

  /// Create a copy of AttackComparison
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttackComparisonImplCopyWith<_$AttackComparisonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DefenseComparison _$DefenseComparisonFromJson(Map<String, dynamic> json) {
  return _DefenseComparison.fromJson(json);
}

/// @nodoc
mixin _$DefenseComparison {
  String get home => throw _privateConstructorUsedError;
  String get away => throw _privateConstructorUsedError;

  /// Serializes this DefenseComparison to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DefenseComparison
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DefenseComparisonCopyWith<DefenseComparison> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DefenseComparisonCopyWith<$Res> {
  factory $DefenseComparisonCopyWith(
          DefenseComparison value, $Res Function(DefenseComparison) then) =
      _$DefenseComparisonCopyWithImpl<$Res, DefenseComparison>;
  @useResult
  $Res call({String home, String away});
}

/// @nodoc
class _$DefenseComparisonCopyWithImpl<$Res, $Val extends DefenseComparison>
    implements $DefenseComparisonCopyWith<$Res> {
  _$DefenseComparisonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DefenseComparison
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
              as String,
      away: null == away
          ? _value.away
          : away // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DefenseComparisonImplCopyWith<$Res>
    implements $DefenseComparisonCopyWith<$Res> {
  factory _$$DefenseComparisonImplCopyWith(_$DefenseComparisonImpl value,
          $Res Function(_$DefenseComparisonImpl) then) =
      __$$DefenseComparisonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String home, String away});
}

/// @nodoc
class __$$DefenseComparisonImplCopyWithImpl<$Res>
    extends _$DefenseComparisonCopyWithImpl<$Res, _$DefenseComparisonImpl>
    implements _$$DefenseComparisonImplCopyWith<$Res> {
  __$$DefenseComparisonImplCopyWithImpl(_$DefenseComparisonImpl _value,
      $Res Function(_$DefenseComparisonImpl) _then)
      : super(_value, _then);

  /// Create a copy of DefenseComparison
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? home = null,
    Object? away = null,
  }) {
    return _then(_$DefenseComparisonImpl(
      home: null == home
          ? _value.home
          : home // ignore: cast_nullable_to_non_nullable
              as String,
      away: null == away
          ? _value.away
          : away // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DefenseComparisonImpl implements _DefenseComparison {
  const _$DefenseComparisonImpl({required this.home, required this.away});

  factory _$DefenseComparisonImpl.fromJson(Map<String, dynamic> json) =>
      _$$DefenseComparisonImplFromJson(json);

  @override
  final String home;
  @override
  final String away;

  @override
  String toString() {
    return 'DefenseComparison(home: $home, away: $away)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DefenseComparisonImpl &&
            (identical(other.home, home) || other.home == home) &&
            (identical(other.away, away) || other.away == away));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, home, away);

  /// Create a copy of DefenseComparison
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DefenseComparisonImplCopyWith<_$DefenseComparisonImpl> get copyWith =>
      __$$DefenseComparisonImplCopyWithImpl<_$DefenseComparisonImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DefenseComparisonImplToJson(
      this,
    );
  }
}

abstract class _DefenseComparison implements DefenseComparison {
  const factory _DefenseComparison(
      {required final String home,
      required final String away}) = _$DefenseComparisonImpl;

  factory _DefenseComparison.fromJson(Map<String, dynamic> json) =
      _$DefenseComparisonImpl.fromJson;

  @override
  String get home;
  @override
  String get away;

  /// Create a copy of DefenseComparison
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DefenseComparisonImplCopyWith<_$DefenseComparisonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PoissionDistribution _$PoissionDistributionFromJson(Map<String, dynamic> json) {
  return _PoissionDistribution.fromJson(json);
}

/// @nodoc
mixin _$PoissionDistribution {
  String get home => throw _privateConstructorUsedError;
  String get away => throw _privateConstructorUsedError;

  /// Serializes this PoissionDistribution to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PoissionDistribution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PoissionDistributionCopyWith<PoissionDistribution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PoissionDistributionCopyWith<$Res> {
  factory $PoissionDistributionCopyWith(PoissionDistribution value,
          $Res Function(PoissionDistribution) then) =
      _$PoissionDistributionCopyWithImpl<$Res, PoissionDistribution>;
  @useResult
  $Res call({String home, String away});
}

/// @nodoc
class _$PoissionDistributionCopyWithImpl<$Res,
        $Val extends PoissionDistribution>
    implements $PoissionDistributionCopyWith<$Res> {
  _$PoissionDistributionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PoissionDistribution
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
              as String,
      away: null == away
          ? _value.away
          : away // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PoissionDistributionImplCopyWith<$Res>
    implements $PoissionDistributionCopyWith<$Res> {
  factory _$$PoissionDistributionImplCopyWith(_$PoissionDistributionImpl value,
          $Res Function(_$PoissionDistributionImpl) then) =
      __$$PoissionDistributionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String home, String away});
}

/// @nodoc
class __$$PoissionDistributionImplCopyWithImpl<$Res>
    extends _$PoissionDistributionCopyWithImpl<$Res, _$PoissionDistributionImpl>
    implements _$$PoissionDistributionImplCopyWith<$Res> {
  __$$PoissionDistributionImplCopyWithImpl(_$PoissionDistributionImpl _value,
      $Res Function(_$PoissionDistributionImpl) _then)
      : super(_value, _then);

  /// Create a copy of PoissionDistribution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? home = null,
    Object? away = null,
  }) {
    return _then(_$PoissionDistributionImpl(
      home: null == home
          ? _value.home
          : home // ignore: cast_nullable_to_non_nullable
              as String,
      away: null == away
          ? _value.away
          : away // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PoissionDistributionImpl implements _PoissionDistribution {
  const _$PoissionDistributionImpl({required this.home, required this.away});

  factory _$PoissionDistributionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PoissionDistributionImplFromJson(json);

  @override
  final String home;
  @override
  final String away;

  @override
  String toString() {
    return 'PoissionDistribution(home: $home, away: $away)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PoissionDistributionImpl &&
            (identical(other.home, home) || other.home == home) &&
            (identical(other.away, away) || other.away == away));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, home, away);

  /// Create a copy of PoissionDistribution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PoissionDistributionImplCopyWith<_$PoissionDistributionImpl>
      get copyWith =>
          __$$PoissionDistributionImplCopyWithImpl<_$PoissionDistributionImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PoissionDistributionImplToJson(
      this,
    );
  }
}

abstract class _PoissionDistribution implements PoissionDistribution {
  const factory _PoissionDistribution(
      {required final String home,
      required final String away}) = _$PoissionDistributionImpl;

  factory _PoissionDistribution.fromJson(Map<String, dynamic> json) =
      _$PoissionDistributionImpl.fromJson;

  @override
  String get home;
  @override
  String get away;

  /// Create a copy of PoissionDistribution
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PoissionDistributionImplCopyWith<_$PoissionDistributionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GoalsComparison _$GoalsComparisonFromJson(Map<String, dynamic> json) {
  return _GoalsComparison.fromJson(json);
}

/// @nodoc
mixin _$GoalsComparison {
  String get home => throw _privateConstructorUsedError;
  String get away => throw _privateConstructorUsedError;

  /// Serializes this GoalsComparison to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GoalsComparison
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoalsComparisonCopyWith<GoalsComparison> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalsComparisonCopyWith<$Res> {
  factory $GoalsComparisonCopyWith(
          GoalsComparison value, $Res Function(GoalsComparison) then) =
      _$GoalsComparisonCopyWithImpl<$Res, GoalsComparison>;
  @useResult
  $Res call({String home, String away});
}

/// @nodoc
class _$GoalsComparisonCopyWithImpl<$Res, $Val extends GoalsComparison>
    implements $GoalsComparisonCopyWith<$Res> {
  _$GoalsComparisonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GoalsComparison
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
              as String,
      away: null == away
          ? _value.away
          : away // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GoalsComparisonImplCopyWith<$Res>
    implements $GoalsComparisonCopyWith<$Res> {
  factory _$$GoalsComparisonImplCopyWith(_$GoalsComparisonImpl value,
          $Res Function(_$GoalsComparisonImpl) then) =
      __$$GoalsComparisonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String home, String away});
}

/// @nodoc
class __$$GoalsComparisonImplCopyWithImpl<$Res>
    extends _$GoalsComparisonCopyWithImpl<$Res, _$GoalsComparisonImpl>
    implements _$$GoalsComparisonImplCopyWith<$Res> {
  __$$GoalsComparisonImplCopyWithImpl(
      _$GoalsComparisonImpl _value, $Res Function(_$GoalsComparisonImpl) _then)
      : super(_value, _then);

  /// Create a copy of GoalsComparison
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? home = null,
    Object? away = null,
  }) {
    return _then(_$GoalsComparisonImpl(
      home: null == home
          ? _value.home
          : home // ignore: cast_nullable_to_non_nullable
              as String,
      away: null == away
          ? _value.away
          : away // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GoalsComparisonImpl implements _GoalsComparison {
  const _$GoalsComparisonImpl({required this.home, required this.away});

  factory _$GoalsComparisonImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoalsComparisonImplFromJson(json);

  @override
  final String home;
  @override
  final String away;

  @override
  String toString() {
    return 'GoalsComparison(home: $home, away: $away)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalsComparisonImpl &&
            (identical(other.home, home) || other.home == home) &&
            (identical(other.away, away) || other.away == away));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, home, away);

  /// Create a copy of GoalsComparison
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalsComparisonImplCopyWith<_$GoalsComparisonImpl> get copyWith =>
      __$$GoalsComparisonImplCopyWithImpl<_$GoalsComparisonImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GoalsComparisonImplToJson(
      this,
    );
  }
}

abstract class _GoalsComparison implements GoalsComparison {
  const factory _GoalsComparison(
      {required final String home,
      required final String away}) = _$GoalsComparisonImpl;

  factory _GoalsComparison.fromJson(Map<String, dynamic> json) =
      _$GoalsComparisonImpl.fromJson;

  @override
  String get home;
  @override
  String get away;

  /// Create a copy of GoalsComparison
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoalsComparisonImplCopyWith<_$GoalsComparisonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TotalComparison _$TotalComparisonFromJson(Map<String, dynamic> json) {
  return _TotalComparison.fromJson(json);
}

/// @nodoc
mixin _$TotalComparison {
  String get home => throw _privateConstructorUsedError;
  String get away => throw _privateConstructorUsedError;

  /// Serializes this TotalComparison to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TotalComparison
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TotalComparisonCopyWith<TotalComparison> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TotalComparisonCopyWith<$Res> {
  factory $TotalComparisonCopyWith(
          TotalComparison value, $Res Function(TotalComparison) then) =
      _$TotalComparisonCopyWithImpl<$Res, TotalComparison>;
  @useResult
  $Res call({String home, String away});
}

/// @nodoc
class _$TotalComparisonCopyWithImpl<$Res, $Val extends TotalComparison>
    implements $TotalComparisonCopyWith<$Res> {
  _$TotalComparisonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TotalComparison
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
              as String,
      away: null == away
          ? _value.away
          : away // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TotalComparisonImplCopyWith<$Res>
    implements $TotalComparisonCopyWith<$Res> {
  factory _$$TotalComparisonImplCopyWith(_$TotalComparisonImpl value,
          $Res Function(_$TotalComparisonImpl) then) =
      __$$TotalComparisonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String home, String away});
}

/// @nodoc
class __$$TotalComparisonImplCopyWithImpl<$Res>
    extends _$TotalComparisonCopyWithImpl<$Res, _$TotalComparisonImpl>
    implements _$$TotalComparisonImplCopyWith<$Res> {
  __$$TotalComparisonImplCopyWithImpl(
      _$TotalComparisonImpl _value, $Res Function(_$TotalComparisonImpl) _then)
      : super(_value, _then);

  /// Create a copy of TotalComparison
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? home = null,
    Object? away = null,
  }) {
    return _then(_$TotalComparisonImpl(
      home: null == home
          ? _value.home
          : home // ignore: cast_nullable_to_non_nullable
              as String,
      away: null == away
          ? _value.away
          : away // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TotalComparisonImpl implements _TotalComparison {
  const _$TotalComparisonImpl({required this.home, required this.away});

  factory _$TotalComparisonImpl.fromJson(Map<String, dynamic> json) =>
      _$$TotalComparisonImplFromJson(json);

  @override
  final String home;
  @override
  final String away;

  @override
  String toString() {
    return 'TotalComparison(home: $home, away: $away)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TotalComparisonImpl &&
            (identical(other.home, home) || other.home == home) &&
            (identical(other.away, away) || other.away == away));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, home, away);

  /// Create a copy of TotalComparison
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TotalComparisonImplCopyWith<_$TotalComparisonImpl> get copyWith =>
      __$$TotalComparisonImplCopyWithImpl<_$TotalComparisonImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TotalComparisonImplToJson(
      this,
    );
  }
}

abstract class _TotalComparison implements TotalComparison {
  const factory _TotalComparison(
      {required final String home,
      required final String away}) = _$TotalComparisonImpl;

  factory _TotalComparison.fromJson(Map<String, dynamic> json) =
      _$TotalComparisonImpl.fromJson;

  @override
  String get home;
  @override
  String get away;

  /// Create a copy of TotalComparison
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TotalComparisonImplCopyWith<_$TotalComparisonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

H2H _$H2HFromJson(Map<String, dynamic> json) {
  return _H2H.fromJson(json);
}

/// @nodoc
mixin _$H2H {
  Fixture get fixture => throw _privateConstructorUsedError;
  League get league => throw _privateConstructorUsedError;
  Teams get teams => throw _privateConstructorUsedError;
  Goals get goals => throw _privateConstructorUsedError;
  Score get score => throw _privateConstructorUsedError;

  /// Serializes this H2H to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of H2H
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $H2HCopyWith<H2H> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $H2HCopyWith<$Res> {
  factory $H2HCopyWith(H2H value, $Res Function(H2H) then) =
      _$H2HCopyWithImpl<$Res, H2H>;
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
class _$H2HCopyWithImpl<$Res, $Val extends H2H> implements $H2HCopyWith<$Res> {
  _$H2HCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of H2H
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

  /// Create a copy of H2H
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FixtureCopyWith<$Res> get fixture {
    return $FixtureCopyWith<$Res>(_value.fixture, (value) {
      return _then(_value.copyWith(fixture: value) as $Val);
    });
  }

  /// Create a copy of H2H
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LeagueCopyWith<$Res> get league {
    return $LeagueCopyWith<$Res>(_value.league, (value) {
      return _then(_value.copyWith(league: value) as $Val);
    });
  }

  /// Create a copy of H2H
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TeamsCopyWith<$Res> get teams {
    return $TeamsCopyWith<$Res>(_value.teams, (value) {
      return _then(_value.copyWith(teams: value) as $Val);
    });
  }

  /// Create a copy of H2H
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GoalsCopyWith<$Res> get goals {
    return $GoalsCopyWith<$Res>(_value.goals, (value) {
      return _then(_value.copyWith(goals: value) as $Val);
    });
  }

  /// Create a copy of H2H
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
abstract class _$$H2HImplCopyWith<$Res> implements $H2HCopyWith<$Res> {
  factory _$$H2HImplCopyWith(_$H2HImpl value, $Res Function(_$H2HImpl) then) =
      __$$H2HImplCopyWithImpl<$Res>;
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
class __$$H2HImplCopyWithImpl<$Res> extends _$H2HCopyWithImpl<$Res, _$H2HImpl>
    implements _$$H2HImplCopyWith<$Res> {
  __$$H2HImplCopyWithImpl(_$H2HImpl _value, $Res Function(_$H2HImpl) _then)
      : super(_value, _then);

  /// Create a copy of H2H
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
    return _then(_$H2HImpl(
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
@JsonSerializable()
class _$H2HImpl implements _H2H {
  const _$H2HImpl(
      {required this.fixture,
      required this.league,
      required this.teams,
      required this.goals,
      required this.score});

  factory _$H2HImpl.fromJson(Map<String, dynamic> json) =>
      _$$H2HImplFromJson(json);

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
    return 'H2H(fixture: $fixture, league: $league, teams: $teams, goals: $goals, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$H2HImpl &&
            (identical(other.fixture, fixture) || other.fixture == fixture) &&
            (identical(other.league, league) || other.league == league) &&
            (identical(other.teams, teams) || other.teams == teams) &&
            (identical(other.goals, goals) || other.goals == goals) &&
            (identical(other.score, score) || other.score == score));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, fixture, league, teams, goals, score);

  /// Create a copy of H2H
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$H2HImplCopyWith<_$H2HImpl> get copyWith =>
      __$$H2HImplCopyWithImpl<_$H2HImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$H2HImplToJson(
      this,
    );
  }
}

abstract class _H2H implements H2H {
  const factory _H2H(
      {required final Fixture fixture,
      required final League league,
      required final Teams teams,
      required final Goals goals,
      required final Score score}) = _$H2HImpl;

  factory _H2H.fromJson(Map<String, dynamic> json) = _$H2HImpl.fromJson;

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

  /// Create a copy of H2H
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$H2HImplCopyWith<_$H2HImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
