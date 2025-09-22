// lib/screens/result/result_page.dart

import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/app_colors.dart';

// This page displays the uploaded image and the analysis result, matching the new UI design.
class ResultPage extends StatelessWidget {
  final File? imageFile;
  final Uint8List? imageBytes;

  const ResultPage({super.key, this.imageFile, this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Using a placeholder icon for the logo as seen in the UI
            const Icon(Icons.pets, color: Colors.white, size: 28),
            const SizedBox(width: 8),
            const Text(
              'Pashudhan-AI',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Analysis Result',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              shadowColor: Colors.black.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _buildImageWidget(),
              ),
            ),
            const SizedBox(height: 24),
            _buildResultDetails(),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Record saved! (Simulation)'),
                      backgroundColor: AppColors.primary),
                );
                Navigator.of(context).pop(); // Go back after saving
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: const Text('Save to Records'),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                // TODO: Implement report functionality
              },
              child: const Text(
                'Report Incorrect Result',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to display the image from either file (mobile) or bytes (web)
  Widget _buildImageWidget() {
    // A placeholder image that looks like the one in the UI
    const String placeholderImageUrl =
        'https://images.unsplash.com/photo-1570042225732-ab5c32126e5d?q=80&w=2070&auto=format&fit=crop';

    if (kIsWeb && imageBytes != null) {
      return Image.memory(imageBytes!,
          fit: BoxFit.cover, height: 250, width: double.infinity);
    } else if (!kIsWeb && imageFile != null) {
      return Image.file(imageFile!,
          fit: BoxFit.cover, height: 250, width: double.infinity);
    } else {
      // Fallback to a network image if no local image is provided
      return Image.network(placeholderImageUrl,
          fit: BoxFit.cover, height: 250, width: double.infinity);
    }
  }

  // Helper widget for the analysis details section
  Widget _buildResultDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: const TextSpan(
              style: TextStyle(
                  fontSize: 24,
                  color: AppColors.textPrimary,
                  fontFamily: 'Roboto', // Ensure font consistency
                  fontWeight: FontWeight.w500),
              children: [
                TextSpan(text: 'Breed: '),
                TextSpan(
                  text: 'Jersey',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Confidence: 97%',
            style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 20),
          _buildInfoRow(
            icon: Icons.check_circle,
            text: 'Health Status: Healthy',
            color: AppColors.primary,
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            icon: Icons.check_circle,
            text: 'Estimated Age: 4 years',
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }

  // Helper widget for a single row of information with an icon
  Widget _buildInfoRow(
      {required IconData icon, required String text, required Color color}) {
    return Row(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
              fontSize: 18,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
