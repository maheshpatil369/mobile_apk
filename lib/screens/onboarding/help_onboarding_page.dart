// lib/screens/onboarding/help_onboarding_page.dart

import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class HelpOnboardingPage extends StatelessWidget {
  const HelpOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text(
          'Help Center',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Replaced the video placeholder with the requested image
            _buildHelpImage(),
            const SizedBox(height: 32),
            const Text(
              'Quick Tips for Best Results',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            _buildTipItem(
              icon: Icons.lightbulb_outline,
              text: 'Ensure good lighting when capturing.',
            ),
            _buildTipItem(
              icon: Icons.camera_outlined,
              text: 'Keep the camera steady for a clear picture.',
            ),
            _buildTipItem(
              icon: Icons.zoom_in_map_rounded,
              text: 'Capture the animal from a clear angle.',
            ),
            _buildTipItem(
              icon: Icons.rule_folder_outlined,
              text: 'Follow the on-screen guides for best results.',
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Placeholder for contacting support
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Contact Support'),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to display the help image
  Widget _buildHelpImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Image.network(
        'https://ik.imagekit.io/6honyi0g1d/image.png?updatedAt=1758566315207',
        fit: BoxFit.cover,
        // Optional: Add loading and error builders for better UX
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const AspectRatio(
            aspectRatio: 16 / 9,
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const AspectRatio(
            aspectRatio: 16 / 9,
            child: Center(
              child: Icon(
                Icons.error_outline,
                color: AppColors.error,
                size: 50,
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget for displaying a single tip
  Widget _buildTipItem({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
