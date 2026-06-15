import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../core/theme/theme_manager.dart';
import '../../../core/config/app_config.dart';

class UploadMovieScreen extends ConsumerStatefulWidget {
  static const String routeName = '/admin/upload_movie';
  const UploadMovieScreen({super.key});

  @override
  ConsumerState<UploadMovieScreen> createState() => _UploadMovieScreenState();
}

class _UploadMovieScreenState extends ConsumerState<UploadMovieScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _somaliTitleController = TextEditingController();
  final _arabicTitleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _directorController = TextEditingController();
  final _castController = TextEditingController();
  final _durationController = TextEditingController();
  final _yearController = TextEditingController();
  
  File? _thumbnailFile;
  File? _bannerFile;
  File? _trailerFile;
  File? _videoFile;
  String? _thumbnailUrl;
  String? _bannerUrl;
  String? _videoUrl;
  
  double _rating = 5.0;
  bool _isPremium = false;
  bool _isFeatured = false;
  bool _isSomaliContent = false;
  bool _isKidFriendly = false;
  bool _isUploading = false;
  double _uploadProgress = 0;
  String _uploadStatus = '';

  final List<String> _selectedCategories = [];
  final List<String> _selectedGenres = [];

  @override
  void dispose() {
    _titleController.dispose();
    _somaliTitleController.dispose();
    _arabicTitleController.dispose();
    _descriptionController.dispose();
    _directorController.dispose();
    _castController.dispose();
    _durationController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  Future<void> _pickFile(String type) async {
    if (type == 'thumbnail' || type == 'banner') {
      final picker = ImagePicker();
      final file = await picker.pickImage(source: ImageSource.gallery, imageQuality: 90);
      if (file != null) {
        setState(() {
          if (type == 'thumbnail') _thumbnailFile = File(file.path);
          if (type == 'banner') _bannerFile = File(file.path);
        });
      }
    } else {
      final result = await FilePicker.platform.pickFiles(
        type: type == 'video' ? FileType.video : FileType.any,
        allowMultiple: false,
      );
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          if (type == 'video') _videoFile = File(result.files.single.path!);
          if (type == 'trailer') _trailerFile = File(result.files.single.path!);
        });
      }
    }
  }

  Future<String> _uploadFile(File file, String path) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(path);
      final uploadTask = ref.putFile(file);
      
      uploadTask.snapshotEvents.listen((snapshot) {
        setState(() {
          _uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
        });
      });

      final snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception('Upload failed: $e');
    }
  }

  Future<void> _uploadMovie() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isUploading = true;
      _uploadStatus = 'Uploading thumbnail...';
    });

    try {
      // Upload thumbnail
      if (_thumbnailFile != null) {
        _uploadStatus = 'Uploading thumbnail...';
        _thumbnailUrl = await _uploadFile(
          _thumbnailFile!,
          '${AppConfig.thumbnailsPath}/${DateTime.now().millisecondsSinceEpoch}.jpg',
        );
      }

      // Upload banner
      if (_bannerFile != null) {
        _uploadStatus = 'Uploading banner...';
        _bannerUrl = await _uploadFile(
          _bannerFile!,
          '${AppConfig.bannersPath}/${DateTime.now().millisecondsSinceEpoch}.jpg',
        );
      }

      // Upload video
      if (_videoFile != null) {
        _uploadStatus = 'Uploading video... This may take a while.';
        _videoUrl = await _uploadFile(
          _videoFile!,
          '${AppConfig.movieVideosPath}/${DateTime.now().millisecondsSinceEpoch}.mp4',
        );
      }

      _uploadStatus = 'Saving to database...';

      // Save to Firestore
      await FirebaseFirestore.instance.collection(AppConfig.moviesCollection).add({
        'title': _titleController.text.trim(),
        'somaliTitle': _somaliTitleController.text.trim().isEmpty ? null : _somaliTitleController.text.trim(),
        'arabicTitle': _arabicTitleController.text.trim().isEmpty ? null : _arabicTitleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'thumbnailUrl': _thumbnailUrl,
        'bannerUrl': _bannerUrl,
        'videoUrl': _videoUrl,
        'director': _directorController.text.trim().isEmpty ? null : _directorController.text.trim(),
        'cast': _castController.text.trim().isEmpty ? null : _castController.text.trim(),
        'duration': _durationController.text.trim().isEmpty ? '0 min' : _durationController.text.trim(),
        'year': int.tryParse(_yearController.text.trim()) ?? DateTime.now().year,
        'rating': _rating,
        'ratingCount': 0,
        'viewCount': 0,
        'downloadCount': 0,
        'categoryIds': _selectedCategories,
        'genres': _selectedGenres,
        'isPremium': _isPremium,
        'isFeatured': _isFeatured,
        'isSomaliContent': _isSomaliContent,
        'isKidFriendly': _isKidFriendly,
        'isPublished': true,
        'isTrending': false,
        'ageRating': 'PG-13',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Movie uploaded successfully!'), backgroundColor: Colors.green),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: SumadColors.error),
        );
      }
    } finally {
      setState(() {
        _isUploading = false;
        _uploadStatus = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SumadColors.backgroundDark,
      appBar: AppBar(
        title: const Text('Upload Movie'),
        backgroundColor: SumadColors.surfaceDark,
      ),
      body: _isUploading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: _uploadProgress,
                        minHeight: 8,
                        backgroundColor: SumadColors.cardDark,
                        valueColor: AlwaysStoppedAnimation<Color>(SumadColors.primary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(_uploadStatus, style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 8),
                  Text('${(_uploadProgress * 100).toStringAsFixed(0)}%', style: const TextStyle(color: SumadColors.primary, fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // File Upload Section
                    Row(
                      children: [
                        _buildFileUploader('Thumbnail', _thumbnailFile, 'thumbnail'),
                        const SizedBox(width: 16),
                        _buildFileUploader('Banner', _bannerFile, 'banner'),
                        const SizedBox(width: 16),
                        _buildFileUploader('Trailer', _trailerFile, 'trailer'),
                        const SizedBox(width: 16),
                        _buildFileUploader('Video', _videoFile, 'video'),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Basic Info
                    _buildSection('Basic Information', [
                      _buildTextField(_titleController, 'Title', 'Enter movie title'),
                      _buildTextField(_somaliTitleController, 'Somali Title (Optional)', 'Enter Somali title'),
                      _buildTextField(_arabicTitleController, 'Arabic Title (Optional)', 'Enter Arabic title'),
                      _buildMultilineField(_descriptionController, 'Description', 'Enter movie description'),
                    ]),

                    const SizedBox(height: 20),

                    // Details
                    _buildSection('Details', [
                      _buildTextField(_directorController, 'Director', 'Enter director name'),
                      _buildTextField(_castController, 'Cast', 'Enter cast (comma separated)'),
                      Row(
                        children: [
                          Expanded(child: _buildTextField(_durationController, 'Duration', 'e.g. 2h 15min')),
                          const SizedBox(width: 16),
                          Expanded(child: _buildTextField(_yearController, 'Year', 'e.g. 2024')),
                        ],
                      ),
                    ]),

                    const SizedBox(height: 20),

                    // Rating
                    _buildSection('Rating', [
                      Row(
                        children: [
                          const Text('Rating: ', style: TextStyle(color: Colors.white70)),
                          const SizedBox(width: 12),
                          ...List.generate(10, (i) => GestureDetector(
                            onTap: () => setState(() => _rating = (i + 1).toDouble()),
                            child: Icon(
                              i < _rating ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                              size: 32,
                            ),
                          )),
                          const SizedBox(width: 12),
                          Text('${_rating.toStringAsFixed(1)}/10', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ]),

                    const SizedBox(height: 20),

                    // Categories & Genres
                    _buildSection('Categories', [
                      Wrap(
                        spacing: 8, runSpacing: 8,
                        children: AppConfig.defaultCategories.map((cat) => FilterChip(
                          label: Text(cat),
                          selected: _selectedCategories.contains(cat),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) _selectedCategories.add(cat);
                              else _selectedCategories.remove(cat);
                            });
                          },
                          selectedColor: SumadColors.primary,
                          checkmarkColor: Colors.white,
                          labelStyle: TextStyle(
                            color: _selectedCategories.contains(cat) ? Colors.white : Colors.white70,
                          ),
                          backgroundColor: SumadColors.cardDark,
                        )).toList(),
                      ),
                    ]),

                    const SizedBox(height: 20),

                    // Flags
                    _buildSection('Flags', [
                      Wrap(
                        spacing: 16, runSpacing: 8,
                        children: [
                          _buildSwitch('Premium Content', _isPremium, (v) => setState(() => _isPremium = v)),
                          _buildSwitch('Featured', _isFeatured, (v) => setState(() => _isFeatured = v)),
                          _buildSwitch('Somali Content', _isSomaliContent, (v) => setState(() => _isSomaliContent = v)),
                          _buildSwitch('Kid Friendly', _isKidFriendly, (v) => setState(() => _isKidFriendly = v)),
                        ],
                      ),
                    ]),

                    const SizedBox(height: 32),

                    // Submit
                    SizedBox(
                      width: double.infinity, height: 52,
                      child: ElevatedButton.icon(
                        onPressed: _uploadMovie,
                        icon: const Icon(Icons.cloud_upload),
                        label: const Text('Upload Movie', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildFileUploader(String label, File? file, String type) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _pickFile(type),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: SumadColors.cardDark,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: file != null ? SumadColors.primary : Colors.white12,
              width: file != null ? 2 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                file != null ? Icons.check_circle : Icons.upload_file,
                color: file != null ? Colors.green : SumadColors.primary,
                size: 28,
              ),
              const SizedBox(height: 6),
              Text(
                file != null ? '${label} ✓' : label,
                style: TextStyle(
                  color: file != null ? Colors.green : Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        ),
        validator: (v) => v!.isEmpty && label == 'Title' ? 'Title is required' : null,
      ),
    );
  }

  Widget _buildMultilineField(TextEditingController controller, String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        maxLines: 4,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  Widget _buildSwitch(String label, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(width: 8),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: SumadColors.primary,
        ),
      ],
    );
  }
}