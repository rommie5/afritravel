import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadDestinationPage extends StatefulWidget {
  const UploadDestinationPage({Key? key}) : super(key: key);

  @override
  _UploadDestinationPageState createState() => _UploadDestinationPageState();
}

class _UploadDestinationPageState extends State<UploadDestinationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();

  double _rating = 3.0;
  File? _imageFile;
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  Future<void> _uploadDestination() async {
    // 1. Validate the form
    if (!_formKey.currentState!.validate()) {
      return;
    }
    // 2. Check if an image is selected
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image first.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // 3. Upload image to Firebase Storage
      final fileName = 'destinations/${DateTime.now().millisecondsSinceEpoch}.png';
      final Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
      final UploadTask uploadTask = storageRef.putFile(_imageFile!);
      final TaskSnapshot snapshot = await uploadTask;
      final String imageUrl = await snapshot.ref.getDownloadURL();

      // 4. Save destination data to Cloud Firestore
      await FirebaseFirestore.instance.collection('popularDestinations').add({
        'name': _nameController.text.trim(),
        'location': _locationController.text.trim(),
        'imageUrl': imageUrl, // The URL from Firebase Storage
        'rating': _rating,
        'timestamp': FieldValue.serverTimestamp(), // Optional: for sorting
      });

      // Show success and clear form
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Destination uploaded successfully! 🎉')),
      );
      _formKey.currentState!.reset();
      _nameController.clear();
      _locationController.clear();
      setState(() {
        _imageFile = null;
        _rating = 3.0;
      });

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload New Destination'),
        backgroundColor: Colors.teal.shade800,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // --- Image Picker UI ---
                InkWell(
                  onTap: _pickImage,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: _imageFile != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              _imageFile!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt, size: 50, color: Colors.grey),
                              SizedBox(height: 8),
                              Text('Tap to select an image'),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 24),

                // --- Name Field ---
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Destination Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.place),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a name.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // --- Location Field ---
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.map_outlined),
                  ),
                   validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a location.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // --- Rating Slider ---
                Text('Rating: ${_rating.toStringAsFixed(1)} ★', style: Theme.of(context).textTheme.titleMedium),
                Slider(
                  value: _rating,
                  min: 1.0,
                  max: 5.0,
                  divisions: 40, // for 0.1 increments
                  label: _rating.toStringAsFixed(1),
                  onChanged: (newRating) {
                    setState(() {
                      _rating = newRating;
                    });
                  },
                ),
                const SizedBox(height: 24),

                // --- Upload Button ---
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _uploadDestination,
                  icon: _isLoading
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3,))
                      : const Icon(Icons.cloud_upload),
                  label: Text(_isLoading ? 'Uploading...' : 'Upload Destination'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.teal.shade700,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}