import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:football_live_app/core/config/env_config.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  static Database? _database;

  factory AppDatabase() => _instance;

  AppDatabase._internal();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, EnvConfig.databaseName);

    return await openDatabase(
      path,
      version: EnvConfig.databaseVersion,
      onCreate: _createDatabase,
      onUpgrade: _upgradeDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    // Teams Table
    await db.execute('''
      CREATE TABLE teams(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        country TEXT,
        founded INTEGER,
        logo TEXT,
        venue_id INTEGER,
        last_updated INTEGER
      )
    ''');

    // Leagues Table
    await db.execute('''
      CREATE TABLE leagues(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        country TEXT,
        logo TEXT,
        flag TEXT,
        season INTEGER,
        last_updated INTEGER
      )
    ''');

    // Players Table
    await db.execute('''
      CREATE TABLE players(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        firstname TEXT,
        lastname TEXT,
        age INTEGER,
        nationality TEXT,
        height TEXT,
        weight TEXT,
        injured INTEGER,
        photo TEXT,
        team_id INTEGER,
        last_updated INTEGER,
        FOREIGN KEY (team_id) REFERENCES teams (id)
      )
    ''');

    // Matches/Fixtures Table
    await db.execute('''
      CREATE TABLE fixtures(
        id INTEGER PRIMARY KEY,
        referee TEXT,
        timezone TEXT,
        date INTEGER,
        timestamp INTEGER,
        venue_id INTEGER,
        status_long TEXT,
        status_short TEXT,
        status_elapsed INTEGER,
        league_id INTEGER,
        home_team_id INTEGER,
        away_team_id INTEGER,
        goals_home INTEGER,
        goals_away INTEGER,
        score_halftime_home INTEGER,
        score_halftime_away INTEGER,
        score_fulltime_home INTEGER,
        score_fulltime_away INTEGER,
        score_extratime_home INTEGER,
        score_extratime_away INTEGER,
        score_penalty_home INTEGER,
        score_penalty_away INTEGER,
        last_updated INTEGER,
        FOREIGN KEY (league_id) REFERENCES leagues (id),
        FOREIGN KEY (home_team_id) REFERENCES teams (id),
        FOREIGN KEY (away_team_id) REFERENCES teams (id)
      )
    ''');

    // Standings Table
    await db.execute('''
      CREATE TABLE standings(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        league_id INTEGER,
        team_id INTEGER,
        rank INTEGER,
        points INTEGER,
        form TEXT,
        description TEXT,
        played INTEGER,
        win INTEGER,
        draw INTEGER,
        lose INTEGER,
        goals_for INTEGER,
        goals_against INTEGER,
        goal_diff INTEGER,
        last_updated INTEGER,
        UNIQUE(league_id, team_id),
        FOREIGN KEY (league_id) REFERENCES leagues (id),
        FOREIGN KEY (team_id) REFERENCES teams (id)
      )
    ''');

    // Player Stats Table
    await db.execute('''
      CREATE TABLE player_stats(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        player_id INTEGER,
        team_id INTEGER,
        league_id INTEGER,
        season INTEGER,
        appearances INTEGER,
        lineups INTEGER,
        minutes INTEGER,
        goals INTEGER,
        assists INTEGER,
        yellowcards INTEGER,
        yellowred INTEGER,
        redcards INTEGER,
        last_updated INTEGER,
        UNIQUE(player_id, team_id, league_id, season),
        FOREIGN KEY (player_id) REFERENCES players (id),
        FOREIGN KEY (team_id) REFERENCES teams (id),
        FOREIGN KEY (league_id) REFERENCES leagues (id)
      )
    ''');
  }

  Future<void> _upgradeDatabase(
      Database db, int oldVersion, int newVersion) async {
    // Handle database migrations
    if (oldVersion < 2) {
      // Example migration for future version updates
    }
  }

  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete('player_stats');
    await db.delete('standings');
    await db.delete('fixtures');
    await db.delete('players');
    await db.delete('leagues');
    await db.delete('teams');
  }
}
