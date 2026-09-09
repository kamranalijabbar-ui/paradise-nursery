import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Preference States
  bool _isDarkMode = false;
  bool _pushNotifications = true;
  bool _emailAlerts = false;
  bool _biometricAuth = true;
  String _selectedLanguage = 'English';

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['English', 'Spanish', 'French', 'German'].map((lang) {
              return RadioListTile<String>(
                title: Text(lang),
                value: lang,
                groupValue: _selectedLanguage,
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedLanguage = value);
                    Navigator.pop(context);
                  }
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out successfully')),
              );
            },
            child: const Text('Log Out', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        children: [
          // Profile Section Header
          ListTile(
            leading: const CircleAvatar(
              radius: 24,
              child: Icon(Icons.person, size: 28),
            ),
            title: const Text(
              'John Doe',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: const Text('john.doe@example.com'),
            trailing: IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () {},
            ),
          ),
          const Divider(height: 32),

          // Appearance Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Appearance',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode_outlined),
            title: const Text('Dark Mode'),
            subtitle: const Text('Enable dark theme across the app'),
            value: _isDarkMode,
            onChanged: (value) {
              setState(() => _isDarkMode = value);
            },
          ),
          ListTile(
            leading: const Icon(Icons.language_outlined),
            title: const Text('Language'),
            subtitle: Text(_selectedLanguage),
            trailing: const Icon(Icons.chevron_right),
            onTap: _showLanguageDialog,
          ),

          const Divider(height: 32),

          // Notifications Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Notifications',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.notifications_none_outlined),
            title: const Text('Push Notifications'),
            value: _pushNotifications,
            onChanged: (value) {
              setState(() => _pushNotifications = value);
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.email_outlined),
            title: const Text('Email Alerts'),
            value: _emailAlerts,
            onChanged: (value) {
              setState(() => _emailAlerts = value);
            },
          ),

          const Divider(height: 32),

          // Security & Privacy
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Security & Privacy',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.fingerprint),
            title: const Text('Biometric Authentication'),
            subtitle: const Text('Use Face ID / Fingerprint to unlock'),
            value: _biometricAuth,
            onChanged: (value) {
              setState(() => _biometricAuth = value);
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text('Change Password'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          const Divider(height: 32),

          // About & Account
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About App'),
            subtitle: const Text('Version 1.0.0'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Log Out',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            onTap: _handleLogout,
          ),
        ],
      ),
    );
  }
}
