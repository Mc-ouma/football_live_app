class MatchStatistics {
  final Team team;
  final List<MatchStatistic> statistics;

  const MatchStatistics({
    required this.team,
    required this.statistics,
  });
}

class MatchStatistic {
  final String type;
  final dynamic value;

  const MatchStatistic({
    required this.type,
    required this.value,
  });
}

class Team {
  final int id;
  final String name;
  final String? logo;

  const Team({
    required this.id,
    required this.name,
    this.logo,
  });
}
