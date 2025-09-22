// lib/screens/profile/profile_page.dart

import 'package:flutter/material.dart';
import '../../data/mock_user.dart';
import '../../utils/app_colors.dart';
import '../../widgets/profile_menu_item.dart';
import '../../widgets/stats_card.dart';
import '../onboarding/help_onboarding_page.dart';
import '../settings/settings_page.dart';
import 'edit_profile_page.dart';
import '../../data/mock_progress.dart';
import '../../widgets/progress_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildAnalyticsSection(),
            const SizedBox(height: 24),
            _buildProfileMenu(context),
            const SizedBox(height: 24),
            _buildLogoutButton(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(mockUser.profileImageUrl),
            backgroundColor: AppColors.background,
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mockUser.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textOnPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                mockUser.email,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textOnPrimary.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Analytics',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
            children: [
              StatsCard(
                label: 'Total Scans',
                value: mockUser.totalScans.toString(),
                icon: Icons.qr_code_scanner,
              ),
              StatsCard(
                label: 'Healthy Animals',
                value: mockUser.healthyAnimals.toString(),
                icon: Icons.check_circle_outline,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Monthly Progress',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 130,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: mockProgress.length,
              itemBuilder: (context, index) {
                return ProgressCard(progress: mockProgress[index]);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProfileMenu(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        children: [
          ProfileMenuItem(
            icon: Icons.person_outline,
            title: 'Edit Profile',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const EditProfilePage(),
              ));
            },
          ),
          const Divider(height: 1, indent: 20, endIndent: 20),
          ProfileMenuItem(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            onTap: () {},
          ),
          const Divider(height: 1, indent: 20, endIndent: 20),
          ProfileMenuItem(
            icon: Icons.help_outline,
            title: 'Help Center',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HelpOnboardingPage(),
              ));
            },
          ),
          const Divider(height: 1, indent: 20, endIndent: 20),
          ProfileMenuItem(
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              ));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ElevatedButton.icon(
        onPressed: () {
          // In a real app, you would handle logout logic here.
          // For now, it navigates to a named route '/login' which should be defined in main.dart
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/login', (route) => false);
        },
        icon: const Icon(Icons.logout, color: AppColors.error),
        label: const Text('Logout'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.error.withOpacity(0.1),
          foregroundColor: AppColors.error,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

