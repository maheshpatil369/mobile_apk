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
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            record.imageUrl,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            // Error handling for the image
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.pets, size: 56),
          ),
        ),
        title: Text(
          record.title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        subtitle: Text('Date: ${record.date}',
            style: const TextStyle(color: AppColors.textSecondary)),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getStatusColor(record.status).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
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
          // For example: Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPage(record: record)));
        },
      ),
    );
  }
}

