// lib/widgets/record_list_item.dart

import 'package:flutter/material.dart';
import '../models/animal_record.dart';
import '../utils/app_colors.dart';

// A reusable widget to display a single item in the history list.
// This promotes code reuse and separation of concerns.
class RecordListItem extends StatelessWidget {
  final AnimalRecord record;

  const RecordListItem({super.key, required this.record});

  // Helper to determine the color of the status indicator
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

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            record.imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            // Error handling for the image
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.pets, size: 60),
          ),
        ),
        title: Text(
          record.title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('Date: ${record.date}',
                style:
                    const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            const SizedBox(height: 4),
            Text('Batch No: ${record.batchNo}',
                style:
                    const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            const SizedBox(height: 4),
            Row(
              children: [
                const Text('Uploaded: ',
                    style: TextStyle(
                        color: AppColors.textSecondary, fontSize: 12)),
                Text(
                  record.isUploaded ? 'Yes' : 'No',
                  style: TextStyle(
                      color: record.isUploaded
                          ? AppColors.primary
                          : AppColors.error,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: _getStatusColor(record.status).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            record.status,
            style: TextStyle(
              color: _getStatusColor(record.status),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
        onTap: () {
          // You can navigate to a detailed result page from here
        },
      ),
    );
  }
}
