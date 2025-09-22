// lib/models/user.dart

// A simple data model for the user profile.
class User {
  final String name;
  final String email;
  final String memberSince;
  final String profileImageUrl;
  final int totalScans;
  final int healthyAnimals;

  const User({
    required this.name,
    required this.email,
    required this.memberSince,
    required this.profileImageUrl,
    required this.totalScans,
    required this.healthyAnimals,
  });
}
