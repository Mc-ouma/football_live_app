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
import 'package:football_live_app/presentation/utils/responsive_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late List<Widget> _tabs;
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late PageController _pageController;

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

    // Initialize animation controllers
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    // Initialize page controller
    _pageController = PageController(initialPage: _currentIndex);

    _updateTabs();

    // Start animations
    _fadeController.forward();
    _scaleController.forward();
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
    _fadeController.dispose();
    _scaleController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });

    // Animate to the selected page
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    // Add a subtle bounce animation when tab is selected
    _scaleController.reset();
    _scaleController.forward();
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

  Widget _buildEnhancedAppBar(BuildContext context) {
    return Container(
      height: 80.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.9),
            Theme.of(context).colorScheme.secondary.withOpacity(0.7),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: ResponsiveHelper.getPadding(context),
        child: Row(
          children: [
            // App logo or icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.sports_soccer,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Title with animation
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Football Live',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ResponsiveHelper.getFontSize(context, 20),
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 3.0,
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    _tabTitles[_currentIndex],
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: ResponsiveHelper.getFontSize(context, 14),
                      shadows: [
                        Shadow(
                          blurRadius: 2.0,
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0.5, 0.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Action buttons
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 3.0,
                    color: Colors.black26,
                    offset: Offset(1.0, 1.0),
                  ),
                ],
              ),
              onPressed: () {
                // TODO: Implement search functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Search functionality coming soon!'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),

            PopupMenuButton<String>(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 3.0,
                    color: Colors.black26,
                    offset: Offset(1.0, 1.0),
                  ),
                ],
              ),
              onSelected: (value) {
                if (value == 'signOut') {
                  _showSignOutDialog();
                } else if (value == 'settings') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Settings coming soon!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
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
      ),
    );
  }

  Widget _buildEnhancedBottomNavBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.grey.shade50,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey.shade600,
        selectedFontSize: ResponsiveHelper.getFontSize(context, 12),
        unselectedFontSize: ResponsiveHelper.getFontSize(context, 10),
        items: [
          BottomNavigationBarItem(
            icon: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.all(_currentIndex == 0 ? 8.0 : 4.0),
              decoration: BoxDecoration(
                color: _currentIndex == 0
                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.sports_soccer,
                size: _currentIndex == 0 ? 28 : 24,
              ),
            ),
            label: 'Matches',
          ),
          BottomNavigationBarItem(
            icon: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.all(_currentIndex == 1 ? 8.0 : 4.0),
              decoration: BoxDecoration(
                color: _currentIndex == 1
                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.insights,
                size: _currentIndex == 1 ? 28 : 24,
              ),
            ),
            label: 'Predictions',
          ),
          BottomNavigationBarItem(
            icon: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.all(_currentIndex == 2 ? 8.0 : 4.0),
              decoration: BoxDecoration(
                color: _currentIndex == 2
                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.emoji_events,
                size: _currentIndex == 2 ? 28 : 24,
              ),
            ),
            label: 'Leagues',
          ),
          BottomNavigationBarItem(
            icon: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.all(_currentIndex == 3 ? 8.0 : 4.0),
              decoration: BoxDecoration(
                color: _currentIndex == 3
                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.newspaper,
                size: _currentIndex == 3 ? 28 : 24,
              ),
            ),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.all(_currentIndex == 4 ? 8.0 : 4.0),
              decoration: BoxDecoration(
                color: _currentIndex == 4
                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.person,
                size: _currentIndex == 4 ? 28 : 24,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.sports_soccer,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Football Live',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Your Football Companion',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ..._tabTitles.asMap().entries.map((entry) {
              final index = entry.key;
              final title = entry.value;
              final icons = [
                Icons.sports_soccer,
                Icons.insights,
                Icons.emoji_events,
                Icons.newspaper,
                Icons.person,
              ];

              return ListTile(
                leading: Icon(
                  icons[index],
                  color: _currentIndex == index
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade600,
                ),
                title: Text(
                  title,
                  style: TextStyle(
                    color: _currentIndex == index
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade800,
                    fontWeight: _currentIndex == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                selected: _currentIndex == index,
                onTap: () {
                  _onItemTapped(index);
                  Navigator.pop(context);
                },
              );
            }),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Settings coming soon!'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sign Out'),
              onTap: () {
                Navigator.pop(context);
                _showSignOutDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTabletOrDesktop = !ResponsiveHelper.isMobile(context);

    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.05),
                    Theme.of(context).scaffoldBackgroundColor,
                  ],
                  stops: const [0.0, 0.3],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Enhanced App Bar with gradient
                    _buildEnhancedAppBar(context),

                    // Offline banner
                    const OfflineBanner(),

                    // API Rate Limit indicator
                    const ApiRateLimitIndicator(),

                    // Main content with enhanced transitions
                    Expanded(
                      child: AnimatedBuilder(
                        animation: _scaleAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _scaleAnimation.value,
                            child: PageView(
                              controller: _pageController,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                              physics: const BouncingScrollPhysics(),
                              children: _tabs.map((tab) {
                                return AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 400),
                                  transitionBuilder: (Widget child,
                                      Animation<double> animation) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(0.0, 0.05),
                                          end: Offset.zero,
                                        ).animate(CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.easeOut,
                                        )),
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    key: ValueKey(tab.runtimeType),
                                    child: tab,
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar:
                isTabletOrDesktop ? null : _buildEnhancedBottomNavBar(context),
            drawer: isTabletOrDesktop ? _buildSideDrawer(context) : null,
          ),
        );
      },
    );
  }
}
