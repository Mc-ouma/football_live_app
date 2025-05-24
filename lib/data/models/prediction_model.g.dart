// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prediction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PredictionResponseImpl _$$PredictionResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PredictionResponseImpl(
      get: json['get'] as String,
      parameters: json['parameters'] as Map<String, dynamic>,
      errors: json['errors'] as Map<String, dynamic>,
      results: (json['results'] as num).toInt(),
      response: (json['response'] as List<dynamic>)
          .map((e) => PredictionData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PredictionResponseImplToJson(
        _$PredictionResponseImpl instance) =>
    <String, dynamic>{
      'get': instance.get,
      'parameters': instance.parameters,
      'errors': instance.errors,
      'results': instance.results,
      'response': instance.response.map((e) => e.toJson()).toList(),
    };

_$PredictionDataImpl _$$PredictionDataImplFromJson(Map<String, dynamic> json) =>
    _$PredictionDataImpl(
      predictions:
          Predictions.fromJson(json['predictions'] as Map<String, dynamic>),
      league: League.fromJson(json['league'] as Map<String, dynamic>),
      fixture: Fixture.fromJson(json['fixture'] as Map<String, dynamic>),
      teams: Teams.fromJson(json['teams'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PredictionDataImplToJson(
        _$PredictionDataImpl instance) =>
    <String, dynamic>{
      'predictions': instance.predictions.toJson(),
      'league': instance.league.toJson(),
      'fixture': instance.fixture.toJson(),
      'teams': instance.teams.toJson(),
    };

_$PredictionsImpl _$$PredictionsImplFromJson(Map<String, dynamic> json) =>
    _$PredictionsImpl(
      winner: json['winner'] as String,
      winnerSide:
          WinnerPercentage.fromJson(json['winnerSide'] as Map<String, dynamic>),
      underOver: json['underOver'] as bool,
      goals: json['goals'] as bool,
      advice: json['advice'] as bool,
      percent: (json['percent'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$PredictionsImplToJson(_$PredictionsImpl instance) =>
    <String, dynamic>{
      'winner': instance.winner,
      'winnerSide': instance.winnerSide.toJson(),
      'underOver': instance.underOver,
      'goals': instance.goals,
      'advice': instance.advice,
      'percent': instance.percent,
    };

_$WinnerPercentageImpl _$$WinnerPercentageImplFromJson(
        Map<String, dynamic> json) =>
    _$WinnerPercentageImpl(
      home: json['home'] as String,
      draw: json['draw'] as String,
      away: json['away'] as String,
    );

Map<String, dynamic> _$$WinnerPercentageImplToJson(
        _$WinnerPercentageImpl instance) =>
    <String, dynamic>{
      'home': instance.home,
      'draw': instance.draw,
      'away': instance.away,
    };

_$ComparisonImpl _$$ComparisonImplFromJson(Map<String, dynamic> json) =>
    _$ComparisonImpl(
      form: FormComparison.fromJson(json['form'] as Map<String, dynamic>),
      att: AttackComparison.fromJson(json['att'] as Map<String, dynamic>),
      def: DefenseComparison.fromJson(json['def'] as Map<String, dynamic>),
      poisson_distribution: PoissionDistribution.fromJson(
          json['poisson_distribution'] as Map<String, dynamic>),
      goals: GoalsComparison.fromJson(json['goals'] as Map<String, dynamic>),
      total: TotalComparison.fromJson(json['total'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ComparisonImplToJson(_$ComparisonImpl instance) =>
    <String, dynamic>{
      'form': instance.form.toJson(),
      'att': instance.att.toJson(),
      'def': instance.def.toJson(),
      'poisson_distribution': instance.poisson_distribution.toJson(),
      'goals': instance.goals.toJson(),
      'total': instance.total.toJson(),
    };

_$FormComparisonImpl _$$FormComparisonImplFromJson(Map<String, dynamic> json) =>
    _$FormComparisonImpl(
      home: json['home'] as String,
      away: json['away'] as String,
    );

Map<String, dynamic> _$$FormComparisonImplToJson(
        _$FormComparisonImpl instance) =>
    <String, dynamic>{
      'home': instance.home,
      'away': instance.away,
    };

_$AttackComparisonImpl _$$AttackComparisonImplFromJson(
        Map<String, dynamic> json) =>
    _$AttackComparisonImpl(
      home: json['home'] as String,
      away: json['away'] as String,
    );

Map<String, dynamic> _$$AttackComparisonImplToJson(
        _$AttackComparisonImpl instance) =>
    <String, dynamic>{
      'home': instance.home,
      'away': instance.away,
    };

_$DefenseComparisonImpl _$$DefenseComparisonImplFromJson(
        Map<String, dynamic> json) =>
    _$DefenseComparisonImpl(
      home: json['home'] as String,
      away: json['away'] as String,
    );

Map<String, dynamic> _$$DefenseComparisonImplToJson(
        _$DefenseComparisonImpl instance) =>
    <String, dynamic>{
      'home': instance.home,
      'away': instance.away,
    };

_$PoissionDistributionImpl _$$PoissionDistributionImplFromJson(
        Map<String, dynamic> json) =>
    _$PoissionDistributionImpl(
      home: json['home'] as String,
      away: json['away'] as String,
    );

Map<String, dynamic> _$$PoissionDistributionImplToJson(
        _$PoissionDistributionImpl instance) =>
    <String, dynamic>{
      'home': instance.home,
      'away': instance.away,
    };

_$GoalsComparisonImpl _$$GoalsComparisonImplFromJson(
        Map<String, dynamic> json) =>
    _$GoalsComparisonImpl(
      home: json['home'] as String,
      away: json['away'] as String,
    );

Map<String, dynamic> _$$GoalsComparisonImplToJson(
        _$GoalsComparisonImpl instance) =>
    <String, dynamic>{
      'home': instance.home,
      'away': instance.away,
    };

_$TotalComparisonImpl _$$TotalComparisonImplFromJson(
        Map<String, dynamic> json) =>
    _$TotalComparisonImpl(
      home: json['home'] as String,
      away: json['away'] as String,
    );

Map<String, dynamic> _$$TotalComparisonImplToJson(
        _$TotalComparisonImpl instance) =>
    <String, dynamic>{
      'home': instance.home,
      'away': instance.away,
    };

_$H2HImpl _$$H2HImplFromJson(Map<String, dynamic> json) => _$H2HImpl(
      fixture: Fixture.fromJson(json['fixture'] as Map<String, dynamic>),
      league: League.fromJson(json['league'] as Map<String, dynamic>),
      teams: Teams.fromJson(json['teams'] as Map<String, dynamic>),
      goals: Goals.fromJson(json['goals'] as Map<String, dynamic>),
      score: Score.fromJson(json['score'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$H2HImplToJson(_$H2HImpl instance) => <String, dynamic>{
      'fixture': instance.fixture.toJson(),
      'league': instance.league.toJson(),
      'teams': instance.teams.toJson(),
      'goals': instance.goals.toJson(),
      'score': instance.score.toJson(),
    };
