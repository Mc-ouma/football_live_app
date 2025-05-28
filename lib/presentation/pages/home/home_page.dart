import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:football_live_app/presentation/pages/auth/login_page.dart';
import 'package:football_live_app/presentation/pages/home/tabs/enhanced_profile_tab.dart';
import 'package:football_live_app/presentation/pages/home/tabs/leagues_tab.dart';
import 'package:football_live_app/presentation/pages/home/tabs/fixtures_tab.dart';
import 'package:football_live_app/presentation/pages/home/tabs/news_feed_tab.dart';
import 'package:football_live_app/presentation/pages/home/tabs/predictions_tab.dart';
import 'package:football_live_app/presentation/widgets/offline_banner.dart';
import 'package:football_live_app/presentation/widgets/api_rate_limit_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late List<Widget> _tabs;

  final List<String> _tabTitles = [
    'Fixtures',
    'Predictions',
    'Leagues',
    'News',
    'Profile',
  ];

  @override
  void initState() {
    super.initState();
    _updateTabs();
  }

  void _updateTabs() {
    _tabs = [
      const FixturesTab(),
      const PredictionsTab(), // Use the existing PredictionBloc from the parent provider
      const LeaguesTab(),
      const NewsFeedTab(),
      const EnhancedProfileTab(),
    ];
  }

  @override
  void dispose() {
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
        title: Text(_tabTitles[_currentIndex]),
        actions: [
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

          // API Rate Limit indicator (only shown when approaching or exceeding limits)
          const ApiRateLimitIndicator(),

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
