// lib/widgets/settings_tile.dart

import 'package:flutter/material.dart';
import '../utils/app_colors.dart';  

class SettingsTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool initialValue;

  const SettingsTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.initialValue = false,
  });

  @override
  State<SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  late bool _switchValue;

  @override
  void initState() {
    super.initState();
    _switchValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.title,
        style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
      ),
      subtitle: Text(
        widget.subtitle,
        style: const TextStyle(color: AppColors.textSecondary),
      ),
      trailing: Switch(
        value: _switchValue,
        onChanged: (value) {
          setState(() {
            _switchValue = value;
          });
        },
        activeColor: AppColors.primary,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
    );
  }
}
