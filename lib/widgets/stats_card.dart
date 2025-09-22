// lib/widgets/stats_card.dart
import 'package:flutter/material.dart';
import 'package:pashudhan_ai_frontend/utils/app_colors.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildStatRow(Icons.pets, 'Total Animals Analyzed', '15'),
            const Divider(),
            _buildStatRow(Icons.data_usage, 'Pending Uploads', '3'),
            const Divider(),
            _buildStatRow(Icons.star, 'Most Common Breed', 'Jersey'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryColor),
          const SizedBox(width: 16),
          Text(title, style: const TextStyle(fontSize: 16)),
          const Spacer(),
          Text(value,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
