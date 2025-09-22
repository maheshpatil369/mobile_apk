// lib/widgets/app_bar_custom.dart
import 'package:flutter/material.dart';
import 'package:pashudhan_ai_frontend/screens/onboarding/help_onboarding_page.dart';
import 'package:pashudhan_ai_frontend/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showHelpIcon;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showHelpIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.pets, color: AppColors.primaryColor),
          const SizedBox(width: 8),
          Text(title),
        ],
      ),
      actions: [
        if (showHelpIcon)
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HelpOnboardingPage()),
              );
            },
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
