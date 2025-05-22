import 'package:flutter_test/flutter_test.dart';
import 'package:football_live_app/domain/usecases/get_live_matches.dart';
import 'package:football_live_app/domain/repositories/football_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:football_live_app/domain/entities/match.dart';

class MockFootballRepository extends Mock implements FootballRepository {}

void main() {
  GetLiveMatches usecase;
  MockFootballRepository mockFootballRepository;

  setUp(() {
    mockFootballRepository = MockFootballRepository();
    usecase = GetLiveMatches(mockFootballRepository);
  });

  final tMatches = <Match>[
    Match(id: 1, homeTeam: 'Team A', awayTeam: 'Team B', score: '1-0'),
    Match(id: 2, homeTeam: 'Team C', awayTeam: 'Team D', score: '2-2'),
  ];

  test('should get live matches from the repository', () async {
    // arrange
    when(mockFootballRepository.getLiveMatches())
        .thenAnswer((_) async => tMatches);
    // act
    final result = await usecase();
    // assert
    expect(result, tMatches);
    verify(mockFootballRepository.getLiveMatches());
    verifyNoMoreInteractions(mockFootballRepository);
  });
}