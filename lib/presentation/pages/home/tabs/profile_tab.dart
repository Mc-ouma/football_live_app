import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:football_live_app/presentation/pages/auth/login_page.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final List<Map<String, dynamic>> _settingsItems = [
    {
      'title': 'Notifications',
      'icon': Icons.notifications_outlined,
      'color': Colors.blue,
    },
    {
      'title': 'Appearance',
      'icon': Icons.palette_outlined,
      'color': Colors.purple,
    },
    {
      'title': 'Language',
      'icon': Icons.language_outlined,
      'color': Colors.green,
    },
    {
      'title': 'Clear Cache',
      'icon': Icons.cleaning_services_outlined,
      'color': Colors.orange,
    },
    {
      'title': 'About',
      'icon': Icons.info_outline,
      'color': Colors.blueGrey,
    },
    {
      'title': 'Help & Support',
      'icon': Icons.help_outline,
      'color': Colors.teal,
    },
    {
      'title': 'Rate App',
      'icon': Icons.star_outline,
      'color': Colors.amber,
    },
    {
      'title': 'Sign Out',
      'icon': Icons.logout_outlined,
      'color': Colors.red,
      'isSignOut': true,
    },
  ];

  void _handleSettingTap(Map<String, dynamic> setting) {
    if (setting['isSignOut'] == true) {
      _showSignOutDialog();
    } else {
      // Handle other settings
      AppLogger.i('Tapped setting: ${setting['title']}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${setting['title']} functionality to be implemented')),
      );
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // Profile header with user info
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthAuthenticated) {
                  return _buildProfileHeader(
                    context, 
                    name: state.user.displayName ?? 'Football Fan',
                    email: state.user.email ?? '',
                    photoUrl: state.user.photoUrl,
                  );
                }
                return _buildProfileHeader(
                  context, 
                  name: 'Football Fan',
                  email: 'user@example.com',
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Settings list
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _settingsItems.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final setting = _settingsItems[index];
                    return ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: setting['color'].withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          setting['icon'],
                          color: setting['color'],
                        ),
                      ),
                      title: Text(setting['title']),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _handleSettingTap(setting),
                    );
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Version info
            Text(
              'Version 1.0.0',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
  
  Widget _buildProfileHeader(
    BuildContext context, {
    required String name,
    required String email,
    String? photoUrl,
  }) {
    return Column(
      children: [
        // Avatar
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Theme.of(context).colorScheme.primary,
            backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
            child: photoUrl == null
                ? Text(
                    name.isNotEmpty ? name[0].toUpperCase() : 'U',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),
        ),
        const SizedBox(height: 16),
        
        // User info
        Text(
          name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          email,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 16),
        
        // Edit profile button
        OutlinedButton(
          onPressed: () {
            // Navigate to edit profile page
          },
          child: const Text('Edit Profile'),
        ),
      ],
    );
  }
}
