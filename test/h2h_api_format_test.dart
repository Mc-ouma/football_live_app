import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:football_live_app/data/models/fixture_model.dart';

void main() {
  group('H2H API Response Format Tests', () {
    test('should parse H2H API response correctly', () {
      // Sample H2H response from the API
      const h2hResponse = '''
      {
        "get": "fixtures/headtohead",
        "parameters": {
          "h2h": "33-34"
        },
        "errors": [],
        "results": 2,
        "paging": {
          "current": 1,
          "total": 1
        },
        "response": [
          {
            "fixture": {
              "id": 141,
              "referee": "Anthony Taylor, England",
              "timezone": "UTC",
              "date": "2018-10-06T16:30:00+00:00",
              "timestamp": 1538843400,
              "periods": {
                "first": 1538843400,
                "second": 1538847000
              },
              "venue": {
                "id": 556,
                "name": "Old Trafford",
                "city": "Manchester"
              },
              "status": {
                "long": "Match Finished",
                "short": "FT",
                "elapsed": 90
              }
            },
            "league": {
              "id": 39,
              "name": "Premier League",
              "country": "England",
              "logo": "https://media.api-sports.io/football/leagues/39.png",
              "flag": "https://media.api-sports.io/flags/gb.svg",
              "season": 2018,
              "round": "Regular Season - 8"
            },
            "teams": {
              "home": {
                "id": 33,
                "name": "Manchester United",
                "logo": "https://media.api-sports.io/football/teams/33.png",
                "winner": true
              },
              "away": {
                "id": 34,
                "name": "Newcastle",
                "logo": "https://media.api-sports.io/football/teams/34.png",
                "winner": false
              }
            },
            "goals": {
              "home": 3,
              "away": 2
            },
            "score": {
              "halftime": {
                "home": 0,
                "away": 2
              },
              "fulltime": {
                "home": 3,
                "away": 2
              },
              "extratime": {
                "home": null,
                "away": null
              },
              "penalty": {
                "home": null,
                "away": null
              }
            }
          },
          {
            "fixture": {
              "id": 11794,
              "referee": "Craig Pawson, England",
              "timezone": "UTC",
              "date": "2017-11-18T17:30:00+00:00",
              "timestamp": 1511026200,
              "periods": {
                "first": 1511026200,
                "second": 1511029800
              },
              "venue": {
                "id": 556,
                "name": "Old Trafford",
                "city": "Manchester"
              },
              "status": {
                "long": "Match Finished",
                "short": "FT",
                "elapsed": 90
              }
            },
            "league": {
              "id": 39,
              "name": "Premier League",
              "country": "England",
              "logo": "https://media.api-sports.io/football/leagues/39.png",
              "flag": "https://media.api-sports.io/flags/gb.svg",
              "season": 2017,
              "round": "Regular Season - 12"
            },
            "teams": {
              "home": {
                "id": 33,
                "name": "Manchester United",
                "logo": "https://media.api-sports.io/football/teams/33.png",
                "winner": true
              },
              "away": {
                "id": 34,
                "name": "Newcastle",
                "logo": "https://media.api-sports.io/football/teams/34.png",
                "winner": false
              }
            },
            "goals": {
              "home": 4,
              "away": 1
            },
            "score": {
              "halftime": {
                "home": 2,
                "away": 1
              },
              "fulltime": {
                "home": 4,
                "away": 1
              },
              "extratime": {
                "home": null,
                "away": null
              },
              "penalty": {
                "home": null,
                "away": null
              }
            }
          }
        ]
      }
      ''';

      // Parse the JSON response
      final Map<String, dynamic> jsonResponse = json.decode(h2hResponse);
      final List<dynamic> fixturesJson = jsonResponse['response'];

      // Convert to FixtureData objects
      final List<FixtureData> fixtures =
          fixturesJson.map((json) => FixtureData.fromJson(json)).toList();

      // Verify the parsing worked correctly
      expect(fixtures.length, 2);

      // Test first fixture
      final firstFixture = fixtures[0];
      expect(firstFixture.fixture.id, 141);
      expect(firstFixture.fixture.referee, "Anthony Taylor, England");
      expect(firstFixture.fixture.date, "2018-10-06T16:30:00+00:00");
      expect(firstFixture.fixture.status.short, "FT");
      expect(firstFixture.fixture.venue?.name, "Old Trafford");
      expect(firstFixture.fixture.venue?.city, "Manchester");

      expect(firstFixture.league.id, 39);
      expect(firstFixture.league.name, "Premier League");
      expect(firstFixture.league.country, "England");
      expect(firstFixture.league.season, 2018);

      expect(firstFixture.teams.home.id, 33);
      expect(firstFixture.teams.home.name, "Manchester United");
      expect(firstFixture.teams.home.winner, true);

      expect(firstFixture.teams.away.id, 34);
      expect(firstFixture.teams.away.name, "Newcastle");
      expect(firstFixture.teams.away.winner, false);

      expect(firstFixture.goals.home, 3);
      expect(firstFixture.goals.away, 2);

      expect(firstFixture.score.halftime?.home, 0);
      expect(firstFixture.score.halftime?.away, 2);
      expect(firstFixture.score.fulltime?.home, 3);
      expect(firstFixture.score.fulltime?.away, 2);

      // Test second fixture
      final secondFixture = fixtures[1];
      expect(secondFixture.fixture.id, 11794);
      expect(secondFixture.fixture.referee, "Craig Pawson, England");
      expect(secondFixture.goals.home, 4);
      expect(secondFixture.goals.away, 1);
      expect(secondFixture.league.season, 2017);
      expect(secondFixture.league.round, "Regular Season - 12");

      // Verify H2H shows matches between the same teams
      expect(firstFixture.teams.home.id, 33); // Manchester United
      expect(firstFixture.teams.away.id, 34); // Newcastle
      expect(secondFixture.teams.home.id, 33); // Manchester United
      expect(secondFixture.teams.away.id, 34); // Newcastle
    });

    test('should handle H2H response metadata correctly', () {
      const h2hResponse = '''
      {
        "get": "fixtures/headtohead",
        "parameters": {
          "h2h": "33-34"
        },
        "errors": [],
        "results": 21,
        "paging": {
          "current": 1,
          "total": 1
        },
        "response": []
      }
      ''';

      final Map<String, dynamic> jsonResponse = json.decode(h2hResponse);

      // Verify API metadata
      expect(jsonResponse['get'], "fixtures/headtohead");
      expect(jsonResponse['parameters']['h2h'], "33-34");
      expect(jsonResponse['errors'], isEmpty);
      expect(jsonResponse['results'], 21);
      expect(jsonResponse['paging']['current'], 1);
      expect(jsonResponse['paging']['total'], 1);

      // Verify response array exists (even if empty)
      expect(jsonResponse['response'], isA<List>());
    });

    test('should handle varying H2H response scenarios', () {
      // Test empty H2H response
      const emptyResponse = '''
      {
        "get": "fixtures/headtohead",
        "parameters": {
          "h2h": "999-1000"
        },
        "errors": [],
        "results": 0,
        "paging": {
          "current": 1,
          "total": 1
        },
        "response": []
      }
      ''';

      final Map<String, dynamic> emptyJson = json.decode(emptyResponse);
      final List<dynamic> emptyFixturesJson = emptyJson['response'];
      final List<FixtureData> emptyFixtures =
          emptyFixturesJson.map((json) => FixtureData.fromJson(json)).toList();

      expect(emptyFixtures.length, 0);
      expect(emptyJson['results'], 0);

      // Test single match H2H response
      const singleResponse = '''
      {
        "get": "fixtures/headtohead",
        "parameters": {
          "h2h": "10-20"
        },
        "errors": [],
        "results": 1,
        "paging": {
          "current": 1,
          "total": 1
        },
        "response": [
          {
            "fixture": {
              "id": 999,
              "referee": null,
              "timezone": "UTC",
              "date": "2023-01-01T15:00:00+00:00",
              "timestamp": 1672578000,
              "periods": {
                "first": 1672578000,
                "second": 1672581600
              },
              "venue": {
                "id": 100,
                "name": "Test Stadium",
                "city": "Test City"
              },
              "status": {
                "long": "Match Finished",
                "short": "FT",
                "elapsed": 90
              }
            },
            "league": {
              "id": 1,
              "name": "Test League",
              "country": "Test Country",
              "logo": "test_logo.png",
              "flag": "test_flag.png",
              "season": 2023,
              "round": "Regular Season - 1"
            },
            "teams": {
              "home": {
                "id": 10,
                "name": "Team A",
                "logo": "team_a_logo.png",
                "winner": true
              },
              "away": {
                "id": 20,
                "name": "Team B",
                "logo": "team_b_logo.png",
                "winner": false
              }
            },
            "goals": {
              "home": 2,
              "away": 1
            },
            "score": {
              "halftime": {
                "home": 1,
                "away": 0
              },
              "fulltime": {
                "home": 2,
                "away": 1
              },
              "extratime": {
                "home": null,
                "away": null
              },
              "penalty": {
                "home": null,
                "away": null
              }
            }
          }
        ]
      }
      ''';

      final Map<String, dynamic> singleJson = json.decode(singleResponse);
      final List<dynamic> singleFixturesJson = singleJson['response'];
      final List<FixtureData> singleFixtures =
          singleFixturesJson.map((json) => FixtureData.fromJson(json)).toList();

      expect(singleFixtures.length, 1);
      expect(singleJson['results'], 1);
      expect(singleFixtures[0].fixture.id, 999);
      expect(singleFixtures[0].teams.home.name, "Team A");
      expect(singleFixtures[0].teams.away.name, "Team B");
    });
  });
}
