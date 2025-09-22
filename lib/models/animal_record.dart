// lib/models/animal_record.dart

// A simple data model class to represent a single animal record.
// This helps in structuring the data and avoiding errors.
class AnimalRecord {
  final String id;
  final String title;
  final String date;
  final String status;
  final String imageUrl;
  final String batchNo;
  final bool isUploaded;

  const AnimalRecord({
    required this.id,
    required this.title,
    required this.date,
    required this.status,
    required this.imageUrl,
    required this.batchNo,
    required this.isUploaded,
  });
}

