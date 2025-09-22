// lib/models/monthly_progress.dart

class MonthlyProgress {
  final String month;
  final double progress; // Progress from 0.0 to 1.0

  const MonthlyProgress({
    required this.month,
    required this.progress,
  });
}
