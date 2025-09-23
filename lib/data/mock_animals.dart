// lib/data/mock_animals.dart

import '../models/animal_record.dart';

// This file contains a list of dummy animal records.
// It simulates fetching data from a database or API.
final List<AnimalRecord> mockAnimals = [
  const AnimalRecord(
    id: '1',
    title: 'Brown Cow in Field',
    date: '2024-07-21',
    status: 'Healthy',
    imageUrl:
        'https://images.unsplash.com/photo-1598715685267-0f45367d8071?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2F0dGxlfGVufDB8fDB8fHww',
    batchNo: 'B-001',
    isUploaded: true,
  ),
  const AnimalRecord(
    id: '2',
    title: 'Cow at Night',
    date: '2024-07-20',
    status: 'Under Observation',
    imageUrl:
        'https://thumbs.dreamstime.com/b/stray-cow-night-surprise-indian-who-have-come-to-party-pastures-46906063.jpg',
    batchNo: 'B-001',
    isUploaded: true,
  ),
  const AnimalRecord(
    id: '3',
    title: 'White Cow Closeup',
    date: '2024-07-19',
    status: 'Requires Attention',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRt3XUiJ9-oeDMYRKhjV85fqTl_AuMDxwrZpdjSpBsT97VXpLPDnXPa7iOxbh7fKMBc75M&usqp=CAU',
    batchNo: 'B-002',
    isUploaded: false,
  ),
  const AnimalRecord(
    id: '4',
    title: 'Fiji Cow',
    date: '2024-07-18',
    status: 'Healthy',
    imageUrl:
        'https://media.istockphoto.com/id/183522978/photo/fiji-cow.jpg?s=612x612&w=0&k=20&c=O6QvQjnsQW20uOYMNSWKmuiZ4IyjGtnQNj1-lCfc88k=',
    batchNo: 'B-002',
    isUploaded: true,
  ),
  const AnimalRecord(
    id: '5',
    title: 'Adorable Cow Portrait',
    date: '2024-07-17',
    status: 'Healthy',
    imageUrl:
        'https://media.istockphoto.com/id/1169479540/photo/adorable-cow-portrait-on-white-background-farm-animal-grown-for-organic-meat-in-india.jpg?s=612x612&w=0&k=20&c=GtJ0wT1kcjmoTgm0d3r24e7icdiHt6vfMvXcD_Gaev4=',
    batchNo: 'B-003',
    isUploaded: true,
  ),
  const AnimalRecord(
    id: '6',
    title: 'Zebu Cow',
    date: '2024-07-16',
    status: 'Healthy',
    imageUrl: 'https://thumbs.dreamstime.com/b/zebu-cow-25432023.jpg',
    batchNo: 'B-003',
    isUploaded: false,
  ),
  const AnimalRecord(
    id: '7',
    title: 'Brown Cow Grazing',
    date: '2024-07-15',
    status: 'Under Observation',
    imageUrl: 'https://t3.ftcdn.net/jpg/04/48/68/02/360_F_448680223_KrAJFTL1WXZJMgOFCuMoFwgBUKYfSPkQ.jpg',
    batchNo: 'B-004',
    isUploaded: true,
  ),
];

