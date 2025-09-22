// lib/screens/result/result_page.dart

import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/app_colors.dart';

// This page displays the uploaded image and a simulated analysis result.
class ResultPage extends StatefulWidget {
  final File? imageFile; // Used for mobile
  final Uint8List? imageBytes; // Used for web

  const ResultPage({super.key, this.imageFile, this.imageBytes});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool _isLoading = true;
  String _analysisResult = '';

  @override
  void initState() {
    super.initState();
    // Simulate a network call or heavy computation for analysis
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _analysisResult =
              "Health Status: Healthy\nConfidence: 97.5%\n\nRecommendations:\n- Maintain current diet and exercise routine.\n- Schedule routine check-up in 6 months.";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analysis Result'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display the image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _buildImageWidget(),
            ),
            const SizedBox(height: 24),

            // Display loading indicator or result
            _isLoading ? _buildLoadingIndicator() : _buildResultCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWidget() {
    // This widget correctly handles displaying the image on both web and mobile
    if (kIsWeb && widget.imageBytes != null) {
      return Image.memory(widget.imageBytes!, fit: BoxFit.cover);
    } else if (!kIsWeb && widget.imageFile != null) {
      return Image.file(widget.imageFile!, fit: BoxFit.cover);
    } else {
      // Fallback in case something goes wrong
      return Container(
        height: 250,
        color: AppColors.divider,
        child: const Icon(Icons.broken_image,
            size: 60, color: AppColors.textSecondary),
      );
    }
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: Column(
        children: [
          CircularProgressIndicator(color: AppColors.primary),
          SizedBox(height: 16),
          Text(
            'Analyzing image, please wait...',
            style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Analysis Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              _analysisResult,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
                height: 1.5, // Improves readability
              ),
            ),
          ],
        ),
      ),
    );
  }
}
