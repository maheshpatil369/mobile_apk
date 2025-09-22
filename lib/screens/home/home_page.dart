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
import '../profile/profile_page.dart'; // 1. IMPORT THE PROFILE PAGE

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

    // Reset state before navigating
    setState(() {
      _selectedImageFile = null;
      _selectedImageBytes = null;
    });

    if (kIsWeb) {
      final bytes = await imageFile.readAsBytes();
      setState(() => _selectedImageBytes = bytes); // Update preview for web
      if (mounted) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ResultPage(imageBytes: bytes),
        ));
      }
    } else {
      setState(() => _selectedImageFile = imageFile); // Update preview for mobile
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
          const ProfilePage(), // 2. ADD THE PROFILE PAGE TO THE LIST
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  Widget _buildCaptureScreen() {
    Widget imagePreviewWidget;
    if (kIsWeb && _selectedImageBytes != null) {
      imagePreviewWidget = ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.memory(_selectedImageBytes!, fit: BoxFit.cover));
    } else if (!kIsWeb && _selectedImageFile != null) {
      imagePreviewWidget = ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.file(_selectedImageFile!, fit: BoxFit.cover));
    } else {
      imagePreviewWidget = const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_search, size: 80, color: AppColors.textSecondary),
          SizedBox(height: 16),
          Text('Image preview will appear here',
              style: TextStyle(color: AppColors.textSecondary)),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.divider, width: 2),
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey[200],
                  ),
                  child: imagePreviewWidget,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.camera_alt),
                label: const Text('Capture from Camera'),
                style: _buttonStyle(),
                onPressed: () => _pickImage(ImageSource.camera),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.photo_library),
                label: const Text('Upload from Gallery'),
                style: _buttonStyle(),
                onPressed: () => _pickImage(ImageSource.gallery),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.accent,
      foregroundColor: AppColors.textOnAccent,
      padding: const EdgeInsets.symmetric(vertical: 16),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

