
// lib/data/mock_animals.dart
import 'package:pashudhan_ai_frontend/models/animal_record.dart';

class MockAnimals {
  static List<AnimalRecord> records = [
    AnimalRecord(
      id: '1',
      breed: 'Jersey',
      confidence: 97.5,
      healthStatus: 'Healthy',
      age: 4,
      imageUrl: 'https://placehold.co/400x400/D2B48C/FFFFFF/png?text=Jersey+Cow',
      date: DateTime.now().subtract(const Duration(days: 1)),
      status: RecordStatus.analyzed,
    ),
    AnimalRecord(
      id: '2',
      breed: 'Holstein Friesian',
      confidence: 92.1,
      healthStatus: 'Needs Checkup',
      age: 6,
      imageUrl: 'https://placehold.co/400x400/3A3A3A/FFFFFF/png?text=Holstein',
      date: DateTime.now().subtract(const Duration(days: 3)),
      status: RecordStatus.analyzed,
    ),
    AnimalRecord(
      id: '3',
      breed: 'Awaiting Analysis...',
      confidence: 0,
      healthStatus: '',
      age: 0,
      imageUrl: 'https://placehold.co/400x400/FFA500/FFFFFF/png?text=Pending',
      date: DateTime.now(),
      status: RecordStatus.pending,
    ),
  ];
}
