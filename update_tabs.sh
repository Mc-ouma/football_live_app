#!/bin/bash

# This script updates the tabs in the Football Live App to use the enhanced FixtureDataProvider

echo "Making backup of original files..."
mkdir -p backup_tabs
cp lib/presentation/pages/match_details/widgets/lineup_tab.dart backup_tabs/ 2>/dev/null || true
cp lib/presentation/pages/match_details/widgets/stats_tab.dart backup_tabs/ 2>/dev/null || true
cp lib/presentation/pages/match_details/widgets/h2h_tab.dart backup_tabs/ 2>/dev/null || true
cp lib/presentation/pages/match_details/widgets/summary_tab.dart backup_tabs/ 2>/dev/null || true
cp lib/presentation/pages/match_details/widgets/events_tab.dart backup_tabs/ 2>/dev/null || true

echo "Replacing files with enhanced versions..."
# Copy lineup_tab_enhanced.dart to lineup_tab.dart
cp lib/presentation/pages/match_details/widgets/lineup_tab_enhanced.dart lib/presentation/pages/match_details/widgets/lineup_tab.dart

# Copy stats_tab_enhanced.dart to stats_tab.dart 
cp lib/presentation/pages/match_details/widgets/stats_tab_enhanced.dart lib/presentation/pages/match_details/widgets/stats_tab.dart

echo "Done replacing files!"
