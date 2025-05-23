import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/domain/entities/user.dart';
import 'package:football_live_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:football_live_app/presentation/pages/auth/login_page.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'English';

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
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
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
        title: const Text('Rate the App'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('How would you rate your experience?'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => IconButton(
                  icon: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 32,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Thanks for rating ${index + 1} stars!'),
                      ),
                    );
                  },
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
    // This would be implemented to navigate to a favorite teams page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Favorite Teams feature coming soon')),
    );
  }

  void _navigateToAboutPage() {
    // This would be implemented to navigate to an about page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('About page coming soon')),
    );
  }

  void _navigateToHelpPage() {
    // This would be implemented to navigate to a help page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Help & Support page coming soon')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        User? user;
        if (state is AuthAuthenticated) {
          user = state.user;
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User profile card
                _buildProfileCard(user),
                const SizedBox(height: 24),

                // Settings section
                const Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Settings list
                ..._settingsItems.map((setting) => _buildSettingItem(setting)),

                const SizedBox(height: 24),

                // App info
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Football Live App',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Version 1.0.0',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileCard(User? user) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Profile image
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.grey.shade200,
              backgroundImage:
                  user?.photoUrl != null ? NetworkImage(user!.photoUrl!) : null,
              child: user?.photoUrl == null
                  ? const Icon(Icons.person, size: 35, color: Colors.grey)
                  : null,
            ),
            const SizedBox(width: 16),

            // User info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.displayName ?? 'Guest User',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (user?.email != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      user!.email!,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () {
                      // This would navigate to an edit profile page
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Edit Profile feature coming soon'),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(100, 36),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    child: const Text('Edit Profile'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(Map<String, dynamic> setting) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: setting['type'] == 'switch'
            ? null
            : () => _handleSettingTap(setting),
        leading: Icon(
          setting['icon'] as IconData,
          color: setting['color'] as Color,
        ),
        title: Text(setting['title'] as String),
        trailing: _buildSettingAction(setting),
      ),
    );
  }

  Widget _buildSettingAction(Map<String, dynamic> setting) {
    switch (setting['type']) {
      case 'switch':
        if (setting['title'] == 'Notifications') {
          return Switch(
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() => _notificationsEnabled = value);
            },
          );
        } else if (setting['title'] == 'Dark Mode') {
          return Switch(
            value: _darkModeEnabled,
            onChanged: (value) {
              setState(() => _darkModeEnabled = value);
            },
          );
        }
        return const SizedBox.shrink();

      case 'dropdown':
        if (setting['title'] == 'Language') {
          return DropdownButton<String>(
            value: _selectedLanguage,
            icon: const Icon(Icons.arrow_drop_down),
            underline: const SizedBox(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() => _selectedLanguage = newValue);
              }
            },
            items: (setting['options'] as List<String>)
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          );
        }
        return const SizedBox.shrink();

      case 'navigate':
      case 'action':
        return const Icon(Icons.chevron_right);

      default:
        return const SizedBox.shrink();
    }
  }
}
