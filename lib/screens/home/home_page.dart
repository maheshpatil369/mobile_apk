import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart'; // <--- ADD THIS IMPORT
import '../../utils/app_colors.dart';
import '../../utils/image_picker_util.dart';
import '../../widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _selectedImage;
  int _currentIndex = 0; // For bottom navigation

  Future<void> _pickImage(ImageSource source) async {
    final imageFile = await ImagePickerUtil.pickImage(source);
    if (imageFile != null) {
      setState(() {
        _selectedImage = imageFile;
      });
      // In a real app, you might navigate to a result page
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResultPage(image: imageFile)));
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Handle navigation to other screens from here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 1,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildCaptureScreen(),
          // Add other main screens here for the bottom nav bar
          const Center(child: Text('History Page')), // Placeholder
          const Center(child: Text('Profile Page')), // Placeholder
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  Widget _buildCaptureScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Preview Area
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.divider, width: 2),
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey[200],
                ),
                child: _selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.file(_selectedImage!, fit: BoxFit.cover),
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image_search,
                              size: 80, color: AppColors.textSecondary),
                          SizedBox(height: 16),
                          Text(
                            'Image preview will appear here',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
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

