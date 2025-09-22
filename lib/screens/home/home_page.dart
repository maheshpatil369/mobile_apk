// lib/screens/home/home_page.dart

import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<void> _pickImage(ImageSource source) async {
    final imageFile = await ImagePickerUtil.pickImage(source);
    if (imageFile == null) return;

    // This logic handles navigation for both mobile and web
    if (kIsWeb) {
      final bytes = await imageFile.readAsBytes();
      if (mounted) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ResultPage(imageBytes: bytes),
        ));
      }
    } else {
      if (mounted) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ResultPage(imageFile: imageFile),
        ));
      }
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

  // The main capture screen UI
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
                  child: _buildImagePreviewWidget(),
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

  // Helper for the image preview area
  Widget _buildImagePreviewWidget() {
    if (kIsWeb && _selectedImageBytes != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.memory(_selectedImageBytes!,
            fit: BoxFit.cover, width: double.infinity, height: double.infinity),
      );
    } else if (!kIsWeb && _selectedImageFile != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.file(_selectedImageFile!,
            fit: BoxFit.cover, width: double.infinity, height: double.infinity),
      );
    } else {
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
  }

  // Helper for button styling
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
