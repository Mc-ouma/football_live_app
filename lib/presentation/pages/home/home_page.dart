import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/core/di/injection.dart' as di;
import 'package:football_live_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/live_matches_bloc.dart';
import 'package:football_live_app/presentation/blocs/football/prediction_bloc.dart';
import 'package:football_live_app/presentation/pages/auth/login_page.dart';
import 'package:football_live_app/presentation/pages/home/tabs/enhanced_profile_tab.dart';
import 'package:football_live_app/presentation/pages/home/tabs/leagues_tab.dart';
import 'package:football_live_app/presentation/pages/home/tabs/live_matches_tab.dart';
import 'package:football_live_app/presentation/pages/home/tabs/news_feed_tab.dart';
import 'package:football_live_app/presentation/pages/home/tabs/predictions_tab.dart';
import 'package:football_live_app/presentation/widgets/offline_banner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool _showLiveMatchesOnly = false;
  late List<Widget> _tabs;

  final List<String> _tabTitles = [
    'All Matches',
    'Predictions',
    'Leagues',
    'News',
    'Profile',
  ];

  @override
  void initState() {
    super.initState();
    _updateTabs();
    // Start live updates when app loads
    context.read<LiveMatchesBloc>().add(StartLiveUpdatesEvent());
  }

  void _updateTabs() {
    _tabs = [
      LiveMatchesTab(showLiveOnly: _showLiveMatchesOnly),
      BlocProvider(
        create: (context) => di.sl<PredictionBloc>(),
        child: const PredictionsTab(),
      ),
      const LeaguesTab(),
      const NewsFeedTab(),
      const EnhancedProfileTab(),
    ];
  }

  @override
  void dispose() {
    // Stop live updates when navigating away
    context.read<LiveMatchesBloc>().add(StopLiveUpdatesEvent());
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthBloc>().add(SignOutEvent());
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _currentIndex == 0
            ? Text(_showLiveMatchesOnly ? 'Live Matches' : 'All Matches')
            : Text(_tabTitles[_currentIndex]),
        actions: [
          // Only show toggle button on the first tab (All Matches/Live Matches)
          if (_currentIndex == 0)
            IconButton(
              icon: Icon(_showLiveMatchesOnly
                  ? Icons.filter_list_off
                  : Icons.filter_list),
              tooltip:
                  _showLiveMatchesOnly ? 'Show all matches' : 'Show live only',
              onPressed: () {
                setState(() {
                  _showLiveMatchesOnly = !_showLiveMatchesOnly;
                  _updateTabs();
                });
              },
            ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search functionality
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'signOut') {
                _showSignOutDialog();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'settings',
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'signOut',
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Sign Out'),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Offline banner at the top of the screen
          const OfflineBanner(),

          // Main content area
          Expanded(child: _tabs[_currentIndex]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: 'Matches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights),
            label: 'Predictions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Leagues',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
