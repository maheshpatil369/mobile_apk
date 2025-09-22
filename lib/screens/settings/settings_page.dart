// lib/screens/settings/settings_page.dart

import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/settings_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 16, 24, 8),
              child: Text(
                'General',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            SettingsTile(
              title: 'Notifications',
              subtitle: 'Enable or disable push notifications',
              initialValue: true,
            ),
            SettingsTile(
              title: 'Dark Mode',
              subtitle: 'Switch between light and dark theme',
            ),
            _buildLanguageTile(context),
            const Divider(height: 32),
             const Padding(
              padding: EdgeInsets.fromLTRB(24, 0, 24, 8),
              child: Text(
                'Account',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            _buildAccountTile(context, title: 'Edit Profile'),
            _buildAccountTile(context, title: 'Change Password'),
            _buildAccountTile(context, title: 'Privacy Policy'),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageTile(BuildContext context) {
    return ListTile(
       contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      title: const Text(
        'Language',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: const Text('Select your preferred language'),
      trailing: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'English',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          SizedBox(width: 8),
          Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
        ],
      ),
      onTap: () {
        // Placeholder for language selection
      },
    );
  }

   Widget _buildAccountTile(BuildContext context, {required String title}) {
    return ListTile(
       contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
      onTap: () {
        // Placeholder for navigation
      },
    );
  }
}
