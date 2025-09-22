// lib/screens/history/history_page.dart

import 'package:flutter/material.dart';
import '../../data/mock_animals.dart';
import '../../widgets/record_list_item.dart';
import '../../utils/app_colors.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan History'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: mockAnimals.length,
        itemBuilder: (context, index) {
          final record = mockAnimals[index];
          return RecordListItem(record: record);
        },
      ),
    );
  }
}

