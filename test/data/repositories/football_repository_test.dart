import 'package:flutter_test/flutter_test.dart';
import 'package:football_live_app/data/repositories/football_repository_impl.dart';
import 'package:football_live_app/domain/entities/match.dart';
import 'package:mockito/mockito.dart';

class MockMatchesLocalDataSource extends Mock
    implements MatchesLocalDataSource {}

class MockMatchesRemoteDataSource extends Mock
    implements MatchesRemoteDataSource {}

void main() {
  late FootballRepositoryImpl footballRepository;
  late MockMatchesLocalDataSource mockLocalDataSource;
  late MockMatchesRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockLocalDataSource = MockMatchesLocalDataSource();
    mockRemoteDataSource = MockMatchesRemoteDataSource();
    footballRepository = FootballRepositoryImpl(
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource,
    );
  });

  group('FootballRepositoryImpl', () {
    test('should return live matches from remote data source', () async {
      // Arrange
      final List<Match> matches = []; // Add mock match data here
      when(mockRemoteDataSource.getLiveMatches())
          .thenAnswer((_) async => matches);

      // Act
      final result = await footballRepository.getLiveMatches();

      // Assert
      expect(result, matches);
      verify(mockRemoteDataSource.getLiveMatches());
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return cached matches from local data source', () async {
      // Arrange
      final List<Match> matches = []; // Add mock match data here
      when(mockLocalDataSource.getCachedMatches())
          .thenAnswer((_) async => matches);

      // Act
      final result = await footballRepository.getCachedMatches();

      // Assert
      expect(result, matches);
      verify(mockLocalDataSource.getCachedMatches());
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    // Additional tests for other methods can be added here
  });
}
