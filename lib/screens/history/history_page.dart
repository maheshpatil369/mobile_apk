// lib/screens/history/history_page.dart

import 'package:flutter/material.dart';
import '../../data/mock_animals.dart';
import '../../models/animal_record.dart';
import '../../utils/app_colors.dart';
import '../../widgets/record_list_item.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late List<AnimalRecord> _filteredRecords;
  String _sortOption = 'date'; // Default sort option
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredRecords = mockAnimals;
    _searchController.addListener(_filterRecords);
    _sortRecords();
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterRecords);
    _searchController.dispose();
    super.dispose();
  }

  void _filterRecords() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredRecords = mockAnimals.where((record) {
        return record.title.toLowerCase().contains(query) ||
            record.id.toLowerCase().contains(query);
      }).toList();
      _sortRecords(); // Re-sort after filtering
    });
  }

  void _sortRecords() {
    setState(() {
      if (_sortOption == 'date') {
        _filteredRecords.sort((a, b) => b.date.compareTo(a.date));
      } else if (_sortOption == 'name') {
        _filteredRecords.sort((a, b) => a.title.compareTo(b.title));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Scan History',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: false,
      ),
      body: Column(
        children: [
          _buildFilterAndSearchControls(),
          Expanded(
            child: _filteredRecords.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 8.0),
                    itemCount: _filteredRecords.length,
                    itemBuilder: (context, index) {
                      final record = _filteredRecords[index];
                      return RecordListItem(record: record);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterAndSearchControls() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name or ID...',
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.surface,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _sortOption,
                icon: const Icon(Icons.sort, color: AppColors.textSecondary),
                items: const [
                  DropdownMenuItem(value: 'date', child: Text('By Date')),
                  DropdownMenuItem(value: 'name', child: Text('By Name')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    _sortOption = value;
                    _sortRecords();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off,
            size: 80,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 16),
          const Text(
            'No records found',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.textSecondary,
            ),
          ),
          if (_searchController.text.isNotEmpty)
            const Text(
              'Try a different search term.',
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
        ],
      ),
    );
  }
}

