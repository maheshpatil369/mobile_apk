// lib/data/mock_animals.dart

import '../models/animal_record.dart';

// This file contains a list of dummy animal records.
// It simulates fetching data from a database or API.
final List<AnimalRecord> mockAnimals = [
  const AnimalRecord(
    id: '1',
    title: 'Holstein Cow #12A',
    date: '2024-07-21',
    status: 'Healthy',
    imageUrl: 'https://placehold.co/100x100/AECBFA/333333?text=Cow+1',
  ),
  const AnimalRecord(
    id: '2',
    title: 'Jersey Bull #05C',
    date: '2024-07-20',
    status: 'Under Observation',
    imageUrl: 'https://placehold.co/100x100/FAD2A2/333333?text=Bull+1',
  ),
  const AnimalRecord(
    id: '3',
    title: 'Holstein Cow #15B',
    date: '2024-07-19',
    status: 'Requires Attention',
    imageUrl: 'https://placehold.co/100x100/FFB3BA/333333?text=Cow+2',
  ),
  const AnimalRecord(
    id: '4',
    title: 'Sahiwal Calf #21A',
    date: '2024-07-18',
    status: 'Healthy',
    imageUrl: 'https://placehold.co/100x100/C8E6C9/333333?text=Calf+1',
  ),
  const AnimalRecord(
    id: '5',
    title: 'Gir Cow #08A',
    date: '2024-07-17',
    status: 'Healthy',
    imageUrl: 'https://placehold.co/100x100/AECBFA/333333?text=Cow+3',
  ),
];

