import 'package:football_live_app/domain/entities/fixture.dart';

class TeamModel extends Team {
  const TeamModel({
    required super.id,
    required super.name,
    super.logo,
    super.winner,
    super.country,
    super.founded,
    super.code,
    super.national,
    super.form,
    super.statistics,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'] as int,
      name: json['name'] as String,
      logo: json['logo'] as String?,
      winner: json['winner'] as bool?,
      country: json['country'] as String?,
      founded: json['founded'] as int?,
      code: json['code'] as String?,
      national: json['national'] as bool?,
      form: json['form'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'winner': winner,
      'country': country,
      'founded': founded,
      'code': code,
      'national': national,
      'form': form,
    };
  }
}
