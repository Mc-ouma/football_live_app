# Football Live App - API Data Usage Guide

## Overview

This guide explains how to fetch and use fixture data across different tabs in the match details pages.

## Key Components

### 1. Fixture Data Flow

The app follows this data flow to get fixture information:

```
API Request → Repository → Use Case → Bloc → UI Components
```

### 2. Fixture ID Parameter

All fixture details are fetched using the fixture ID as the key parameter:

```dart
// Example API call for fixture details
final Map<String, dynamic> params = {
  'id': fixtureId.toString(),  // Using EnvConfig.paramId
};

// Make API request to the fixtures endpoint
final response = await apiClient.get(
  EnvConfig.fixtures,  // This is the '/fixtures' endpoint
  queryParameters: params,
);
```

### 3. Utility Classes

#### FixtureDataProvider

The `FixtureDataProvider` utility helps access and manage fixture data across all tabs:

```dart
// Get the best fixture data available
FixtureData fixtureToUse = FixtureDataProvider.getBestFixtureData(context, fixture);

// Get sorted events
List<Event> events = FixtureDataProvider.getSortedEvents(fixtureToUse);

// Get team-specific events
List<Event> homeEvents = FixtureDataProvider.getTeamEvents(fixture, fixture.teams.home.id);

// Request fresh data
FixtureDataProvider.requestFixtureRefresh(context, fixture.fixture.id);
```

#### FixtureExtension

The `FixtureExtension` adds methods to extract data from any fixture type:

```dart
// Get events
List<Event> events = fixture.getEvents();

// Get lineups
List<LineupData> lineups = fixture.getLineups();

// Get statistics
Statistics? stats = fixture.getStatistics();

// Check if we have detailed data
if (fixture.hasDetailedData) {
  // Use the detailed data
}
```

## Tab Data Requirements

Each tab requires specific data from the API:

| Tab     | Data Required               | API Parameter       | Source                                         |
| ------- | --------------------------- | ------------------- | ---------------------------------------------- |
| Summary | Basic fixture info + Events | `id`                | `/fixtures?id={id}`                            |
| Lineup  | Lineups                     | `id`                | `/fixtures?id={id}`                            |
| Stats   | Statistics                  | `id`                | `/fixtures?id={id}`                            |
| Events  | Events                      | `id`                | `/fixtures?id={id}`                            |
| H2H     | Head-to-head fixtures       | `h2h`               | `/fixtures/headtohead?h2h={team1Id}-{team2Id}` |
| Table   | League standings            | `league` & `season` | `/standings?league={id}&season={year}`         |

## Implementation Pattern

For each tab, follow this pattern to ensure you always have access to the best fixture data:

```dart
@override
Widget build(BuildContext context) {
  return BlocBuilder<FixtureDetailsBloc, FixtureDetailsState>(
    builder: (context, state) {
      // Get the most complete fixture data available
      final fixtureToUse = FixtureDataProvider.getBestFixtureData(context, fixture);

      // Extract specific data needed for this tab
      final specificData = fixtureToUse.getSpecificData();

      // If data is not available, request it
      if (specificData == null && state is! FixtureDetailsLoading) {
        FixtureDataProvider.requestFixtureRefresh(context, fixture.fixture.id);
      }

      // Build UI using the data
      return YourSpecificTabUI(data: specificData);
    }
  );
}
```

## Best Practices

1. Always check if data is already available before making new API requests
2. Use the `FixtureDataProvider` for consistent data access across tabs
3. Handle loading and error states appropriately in each tab
4. Use the fixture's ID parameter to fetch detailed data
5. For tab-specific data like standings or predictions, use the appropriate parameters
