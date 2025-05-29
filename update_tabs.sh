#!/bin/bash

echo "Making backup of original files..."
mkdir -p backup_tabs
cp lib/presentation/pages/match_details/widgets/lineup_tab.dart backup_tabs/
cp lib/presentation/pages/match_details/widgets/stats_tab.dart backup_tabs/
cp lib/presentation/pages/match_details/widgets/h2h_tab.dart backup_tabs/
cp lib/presentation/pages/match_details/widgets/summary_tab.dart backup_tabs/

echo "Replacing files with new versions..."
cp lib/presentation/pages/match_details/widgets/lineup_tab_new.dart lib/presentation/pages/match_details/widgets/lineup_tab.dart
cp lib/presentation/pages/match_details/widgets/stats_tab_new.dart lib/presentation/pages/match_details/widgets/stats_tab.dart
cp lib/presentation/pages/match_details/widgets/h2h_tab_new.dart lib/presentation/pages/match_details/widgets/h2h_tab.dart
cp lib/presentation/pages/match_details/widgets/summary_tab_new.dart lib/presentation/pages/match_details/widgets/summary_tab.dart

echo "Done replacing files!"
