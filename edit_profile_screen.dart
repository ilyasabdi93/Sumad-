import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../core/theme/theme_manager.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController(text: 'User Name');
  final _bioController = TextEditingController(text: 'Movie enthusiast');
  File? _profileImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (file != null) {
      setState(() => _profileImage = File(file.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SumadColors.backgroundDark,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Save', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Avatar
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: SumadColors.cardDark,
                    backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                    child: _profileImage == null ? const Icon(Icons.person, color: Colors.white38, size: 50) : null,
                  ),
                  Positioned(
                    bottom: 0, right: 0,
                    child: Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(
                        color: SumadColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: SumadColors.backgroundDark, width: 3),
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              decoration: InputDecoration(
                labelText: 'Display Name',
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _bioController,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Bio',
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              style: const TextStyle(color: Colors.white, fontSize: 16),
              decoration: InputDecoration(
                labelText: 'Phone Number (Optional)',
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
    );
  }
}