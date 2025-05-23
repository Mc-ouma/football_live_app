# Migration from match_model to fixture_model

This migration replaces the older `match_model` structure with the new `fixture_model` structure in the Football Live App. The new model uses the Freezed package for immutable data classes with rich functionality.

## Key Changes

1. **New Models Structure**:
   - `FixtureResponse`: The root response structure for fixture endpoints
   - `FixtureData`: Main fixture data model containing all fixture information
   - `Event`: Match event information (goals, cards, substitutions, etc.)
   - Various other supporting models like `League`, `Team`, `Score`, etc.

2. **Updated Data Sources**:
   - `football_local_data_source_new.dart`: Updated local data source for fixture model
   - `football_remote_data_source_new.dart`: Updated remote data source for fixture model

3. **Updated Repository**:
   - `football_repository_impl_new.dart`: Updated repository implementation for the fixture model
   - `football_repository_new.dart`: Updated repository interface

4. **Updated Use Cases**:
   - `get_live_matches_new.dart`
   - `get_match_details_new.dart`
   - `get_upcoming_fixtures_new.dart`

5. **Updated BLoCs**:
   - `live_matches_bloc_new.dart`
   - `upcoming_fixtures_bloc_new.dart`

6. **Adapter**:
   - `fixture_adapter.dart`: Helps convert between database maps and fixture objects

## Implementation Details

The new fixture model is based on the API-Football service response structure and uses Freezed for code generation. Benefits include:

- Immutable data classes
- Automatic JSON serialization/deserialization
- Copy-with functionality
- Better type safety
- Cleaner code

## Migration Steps

To migrate your project to use the new fixture model:

1. Update imports in your code to reference the new implementations
2. Update any custom UI widgets that display match data to work with FixtureData
3. Update any repositories or services that depend on the old match model
4. Replace the dependency injection configuration to use the new implementations

## File Structure Changes

- New files have "_new" suffix for easy identification
- Original files are preserved for reference

## Database Schema

The database schema has been updated to work with the new model. Key tables include:

- fixtures: Stores core fixture information
- events: Stores match events (goals, cards, etc.)
- teams: Stores team information 
- leagues: Stores league information

## How to Test

1. Run the application with the new implementation
2. Verify that live matches, upcoming fixtures, and match details are displayed correctly
3. Test offline functionality to ensure caching works properly
4. Verify that all features using match data continue to work correctly
