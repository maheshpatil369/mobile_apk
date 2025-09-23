// lib/screens/home/home_page.dart

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import 'package:pashudhan_ai_frontend/models/animal_record.dart';
import '../../utils/app_colors.dart';
import '../../utils/image_picker_util.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../history/history_page.dart';
import '../result/result_page.dart';
import '../profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _selectedImageFile;
  Uint8List? _selectedImageBytes;
  int _currentIndex = 0;
  bool _isAnalyzing = false;

  Future<void> _pickImage(ImageSource source) async {
    final imageFile = await ImagePickerUtil.pickImage(source);
    if (imageFile == null) return;

    setState(() {
      _isAnalyzing = true;
    });

    // Simulate analysis delay
    await Future.delayed(const Duration(seconds: 3));

    // ✅ Read bytes BEFORE navigation
    Uint8List? bytes;
    if (kIsWeb) {
      bytes = await imageFile.readAsBytes();
    }

    final dummyRecord = AnimalRecord(
      id: '7',
      title: 'Brown Cow Grazing',
      date: '2024-07-15',
      status: 'Under Observation',
      imageUrl:
          'https://cdn.sanity.io/images/5dqbssss/production-v3/a25daafbd63d028bacd81f322618de5ea1b9bc98-6720x4480.jpg?w=3840&q=75&fit=clip&auto=format',
      batchNo: 'B-004',
      isUploaded: true,
    );

    if (mounted) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ResultPage(
          imageFile: kIsWeb ? null : imageFile,
          imageBytes: bytes, // ✅ no await here
          record: dummyRecord,
        ),
      )).then((_) {
        setState(() {
          _isAnalyzing = false;
        });
      });
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildCaptureScreen(),
          const HistoryPage(),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  Widget _buildCaptureScreen() {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.pets, color: Colors.white, size: 28),
            const SizedBox(width: 8),
            const Text(
              'Pashudhan-AI',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Capture or upload an image for analysis.',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.divider, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Center(
                  child: _isAnalyzing
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/animations/cow-analysis.json',
                              width: 150,
                              height: 150,
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Analyzing Image...',
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      : _buildImagePreviewWidget(),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.photo_library_outlined),
                    label: const Text('Gallery'),
                    style: _buttonStyle(isPrimary: false),
                    onPressed: () => _pickImage(ImageSource.gallery),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.camera_alt_outlined),
                    label: const Text('Camera'),
                    style: _buttonStyle(isPrimary: true),
                    onPressed: () => _pickImage(ImageSource.camera),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreviewWidget() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.image_search, size: 80, color: AppColors.textSecondary),
        SizedBox(height: 16),
        Text(
          'Image preview will appear here',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
        ),
      ],
    );
  }

  ButtonStyle _buttonStyle({required bool isPrimary}) {
    return ElevatedButton.styleFrom(
      backgroundColor: isPrimary ? AppColors.primary : AppColors.surface,
      foregroundColor: isPrimary ? Colors.white : AppColors.primary,
      padding: const EdgeInsets.symmetric(vertical: 16),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      side: isPrimary
          ? BorderSide.none
          : const BorderSide(color: AppColors.primary, width: 1.5),
      elevation: isPrimary ? 3 : 0,
    );
  }
}
