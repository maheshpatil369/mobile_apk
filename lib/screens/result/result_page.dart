// lib/screens/result/result_page.dart

import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/animal_record.dart';
import '../../utils/app_colors.dart';

class ResultPage extends StatelessWidget {
  final File? imageFile;
  final Uint8List? imageBytes;
  final AnimalRecord record;

  const ResultPage({
    super.key,
    this.imageFile,
    this.imageBytes,
    required this.record,
  });

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
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: const BorderSide(color: AppColors.textSecondary),
                    ),
                    child: const Text('Discard'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Record submitted! (Simulation)'),
                            backgroundColor: AppColors.primary),
                      );
                      Navigator.of(context).pop();
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
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWidget() {
    if (kIsWeb && imageBytes != null) {
      return Image.memory(imageBytes!,
          fit: BoxFit.cover, height: 250, width: double.infinity);
    } else if (!kIsWeb && imageFile != null) {
      return Image.file(imageFile!,
          fit: BoxFit.cover, height: 250, width: double.infinity);
    } else {
      return Image.network(record.imageUrl,
          fit: BoxFit.cover, height: 250, width: double.infinity);
    }
  }

  Widget _buildResultDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
              icon: Icons.tag, text: 'ID: ${record.id}'),
          const SizedBox(height: 12),
          _buildInfoRow(
              icon: Icons.label_important_outline, text: 'Title: ${record.title}'),
          const SizedBox(height: 12),
          _buildInfoRow(icon: Icons.calendar_today, text: 'Date: ${record.date}'),
          const SizedBox(height: 12),
          _buildInfoRow(
              icon: Icons.health_and_safety_outlined,
              text: 'Status: ${record.status}',
              color: _getStatusColor(record.status)),
          const SizedBox(height: 12),
          _buildInfoRow(
              icon: Icons.numbers, text: 'Batch No: ${record.batchNo}'),
          const SizedBox(height: 12),
          _buildInfoRow(
              icon: record.isUploaded
                  ? Icons.cloud_done_outlined
                  : Icons.cloud_off_outlined,
              text: 'Uploaded: ${record.isUploaded ? "Yes" : "No"}',
              color: record.isUploaded ? AppColors.primary : AppColors.error),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
      {required IconData icon, required String text, Color? color}) {
    return Row(
      children: [
        Icon(icon, color: color ?? AppColors.textPrimary, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18,
                color: color ?? AppColors.textPrimary,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

    Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'healthy':
        return AppColors.primary;
      case 'under observation':
        return AppColors.accent;
      case 'requires attention':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }
}
