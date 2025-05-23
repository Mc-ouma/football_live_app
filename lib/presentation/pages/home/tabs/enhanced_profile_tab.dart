import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/domain/entities/user.dart';
import 'package:football_live_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:football_live_app/presentation/pages/auth/login_page.dart';

class EnhancedProfileTab extends StatefulWidget {
  const EnhancedProfileTab({super.key});

  @override
  State<EnhancedProfileTab> createState() => _EnhancedProfileTabState();
}

class _EnhancedProfileTabState extends State<EnhancedProfileTab> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'English';
  final List<Map<String, dynamic>> _favoriteTeams = [
    {
      'id': 33,
      'name': 'Manchester City',
      'logo': 'https://media.api-sports.io/football/teams/33.png',
      'country': 'England',
    },
    {
      'id': 529,
      'name': 'Barcelona',
      'logo': 'https://media.api-sports.io/football/teams/529.png',
      'country': 'Spain',
    },
  ];

  final List<Map<String, dynamic>> _settingsItems = [
    {
      'title': 'Notifications',
      'icon': Icons.notifications_outlined,
      'color': Colors.blue,
      'type': 'switch',
    },
    {
      'title': 'Dark Mode',
      'icon': Icons.dark_mode_outlined,
      'color': Colors.purple,
      'type': 'switch',
    },
    {
      'title': 'Language',
      'icon': Icons.language_outlined,
      'color': Colors.green,
      'type': 'dropdown',
      'options': ['English', 'Spanish', 'French', 'German', 'Portuguese'],
    },
    {
      'title': 'Favorite Teams',
      'icon': Icons.favorite_outline,
      'color': Colors.red,
      'type': 'navigate',
    },
    {
      'title': 'Clear Cache',
      'icon': Icons.cleaning_services_outlined,
      'color': Colors.orange,
      'type': 'action',
    },
    {
      'title': 'About',
      'icon': Icons.info_outline,
      'color': Colors.blueGrey,
      'type': 'navigate',
    },
    {
      'title': 'Help & Support',
      'icon': Icons.help_outline,
      'color': Colors.teal,
      'type': 'navigate',
    },
    {
      'title': 'Rate App',
      'icon': Icons.star_outline,
      'color': Colors.amber,
      'type': 'action',
    },
    {
      'title': 'Sign Out',
      'icon': Icons.logout_outlined,
      'color': Colors.grey,
      'type': 'action',
    },
  ];

  void _handleSettingTap(Map<String, dynamic> setting) {
    if (setting['type'] == 'action') {
      if (setting['title'] == 'Sign Out') {
        _showSignOutDialog();
      } else if (setting['title'] == 'Clear Cache') {
        _showClearCacheDialog();
      } else if (setting['title'] == 'Rate App') {
        _showRateAppDialog();
      }
    } else if (setting['type'] == 'navigate') {
      if (setting['title'] == 'Favorite Teams') {
        _navigateToFavoriteTeams();
      } else if (setting['title'] == 'About') {
        _navigateToAboutPage();
      } else if (setting['title'] == 'Help & Support') {
        _navigateToHelpPage();
      }
    }
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

  void _showClearCacheDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text('This will clear all cached data. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // In a real app, you would call a cache clearing function
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared successfully')),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showRateAppDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rate Our App'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('How would you rate our app?'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Thanks for rating us ${index + 1} stars!'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.star, color: Colors.amber),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Later'),
          ),
        ],
      ),
    );
  }

  void _navigateToFavoriteTeams() {
    // In a real app, you would navigate to a Favorite Teams page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Favorite Teams page to be implemented')),
    );
  }

  void _navigateToAboutPage() {
    // In a real app, you would navigate to an About page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('About page to be implemented')),
    );
  }

  void _navigateToHelpPage() {
    // In a real app, you would navigate to a Help & Support page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Help & Support page to be implemented')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // User profile section
            _buildProfileCard(),

            const SizedBox(height: 24),
            Text(
              'Favorite Teams',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),

            // Favorite teams section
            _buildFavoriteTeamsSection(),

            const SizedBox(height: 24),
            Text(
              'Settings',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),

            // Settings section
            ...List.generate(_settingsItems.length, (index) {
              final setting = _settingsItems[index];
              return _buildSettingTile(setting);
            }),

            const SizedBox(height: 40),
            Center(
              child: Text(
                'Football Live App v1.0.0',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    // Get current user from AuthBloc
    final state = context.watch<AuthBloc>().state;
    User? user;

    if (state is AuthAuthenticated) {
      user = state.user;
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // User avatar
            InkWell(
              onTap: () {
                // Handle profile picture change
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                          Text('Profile picture update to be implemented')),
                );
              },
              borderRadius: BorderRadius.circular(50),
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: user?.photoUrl != null
                        ? NetworkImage(user!.photoUrl!)
                        : null,
                    child: user?.photoUrl == null
                        ? const Icon(Icons.person, size: 50, color: Colors.grey)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.edit,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // User name
            Text(
              user?.displayName ?? 'Football Fan',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),

            // User email
            Text(
              user?.email ?? 'No email provided',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),

            // Edit profile button
            OutlinedButton.icon(
              onPressed: () {
                // Handle edit profile
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Edit profile to be implemented')),
                );
              },
              icon: const Icon(Icons.edit),
              label: const Text('Edit Profile'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteTeamsSection() {
    if (_favoriteTeams.isEmpty) {
      return Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Icon(
                Icons.favorite_border,
                size: 48,
                color: Colors.grey,
              ),
              const SizedBox(height: 8),
              const Text(
                'No favorite teams added yet',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navigate to add favorite team
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Add favorite team to be implemented')),
                  );
                },
                child: const Text('Add Favorite Team'),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _favoriteTeams.length + 1, // +1 for the "Add" button
        itemBuilder: (context, index) {
          if (index == _favoriteTeams.length) {
            // Last item is the "Add" button
            return Container(
              width: 100,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: InkWell(
                onTap: () {
                  // Navigate to add favorite team
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Add favorite team to be implemented')),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue.shade50,
                      child: const Icon(Icons.add, color: Colors.blue),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Add Team',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            );
          }

          final team = _favoriteTeams[index];
          return Container(
            width: 100,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                // Navigate to team details
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('View ${team['name']} details')),
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  team['logo'] != null
                      ? Image.network(
                          team['logo'],
                          height: 60,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.sports_soccer,
                            size: 60,
                            color: Colors.grey,
                          ),
                        )
                      : const Icon(
                          Icons.sports_soccer,
                          size: 60,
                          color: Colors.grey,
                        ),
                  const SizedBox(height: 8),
                  Text(
                    team['name'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    team['country'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSettingTile(Map<String, dynamic> setting) {
    final title = setting['title'] as String;
    final icon = setting['icon'] as IconData;
    final color = setting['color'] as Color;
    final type = setting['type'] as String;

    Widget? trailing;

    if (type == 'switch') {
      bool value = false;
      if (title == 'Notifications') {
        value = _notificationsEnabled;
      } else if (title == 'Dark Mode') {
        value = _darkModeEnabled;
      }

      trailing = Switch(
        value: value,
        onChanged: (newValue) {
          setState(() {
            if (title == 'Notifications') {
              _notificationsEnabled = newValue;
            } else if (title == 'Dark Mode') {
              _darkModeEnabled = newValue;
            }
          });
        },
      );
    } else if (type == 'dropdown' && title == 'Language') {
      trailing = DropdownButton<String>(
        value: _selectedLanguage,
        underline: const SizedBox(),
        icon: const Icon(Icons.arrow_drop_down),
        items: (setting['options'] as List<String>).map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) {
          if (newValue != null) {
            setState(() {
              _selectedLanguage = newValue;
            });
          }
        },
      );
    } else {
      trailing = const Icon(Icons.arrow_forward_ios, size: 16);
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title),
      trailing: trailing,
      onTap: type != 'switch' ? () => _handleSettingTap(setting) : null,
    );
  }
}
