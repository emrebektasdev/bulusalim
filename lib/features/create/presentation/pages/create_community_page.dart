import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:bulusalim_app_01/core/firebase/storage_providers.dart';
import 'package:bulusalim_app_01/features/auth/presentation/providers/auth_providers.dart';
import 'package:bulusalim_app_01/features/community/presentation/providers/community_providers.dart';

class CreateCommunityPage extends ConsumerStatefulWidget {
  const CreateCommunityPage({super.key});

  @override
  ConsumerState<CreateCommunityPage> createState() => _CreateCommunityPageState();
}

class _CreateCommunityPageState extends ConsumerState<CreateCommunityPage> {
  final _formKey = GlobalKey<FormState>();
  
  String _name = '';
  String _description = '';
  String _category = 'Genel'; // Default
  bool _isPrivate = false;
  bool _isLoading = false;
  
  File? _selectedImage;

  final List<String> _categories = [
    'Genel',
    'Teknoloji',
    'Spor',
    'Sanat',
    'Müzik',
    'Seyahat',
    'Oyun',
    'Kitap',
    'Kariyer'
  ];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final user = ref.read(currentUserProvider);
    if (user == null) return;

    setState(() => _isLoading = true);

    try {
      final repo = ref.read(communityRepositoryProvider);
      final storage = ref.read(storageRepositoryProvider);
      
      // Create community document first to get the ID
      final community = await repo.createCommunity(
        name: _name,
        description: _description,
        category: _category,
        isPrivate: _isPrivate,
        currentUserId: user.uid,
      );

      // Upload image if selected
      if (_selectedImage != null) {
        final url = await storage.uploadCommunityCover(
          file: _selectedImage!, 
          communityId: community.id,
        );
        await repo.updateCoverImage(community.id, url);
      }

      // Invalidate feed so it refreshes with the new community
      ref.invalidate(communitiesFeedProvider);

      if (mounted) {
        context.pop();
        context.push('/community/${community.id}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Topluluk Oluştur'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image Picker UI
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(16),
                    image: _selectedImage != null
                        ? DecorationImage(
                            image: FileImage(_selectedImage!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _selectedImage == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_photo_alternate, size: 48, color: Colors.grey),
                            SizedBox(height: 8),
                            Text('Kapak Fotoğrafı Ekle', style: TextStyle(color: Colors.grey)),
                          ],
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 24),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Topluluk Adı',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.people),
                ),
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Topluluk adı gerekli' : null,
                onSaved: (val) => _name = val!.trim(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Açıklama',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 4,
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Açıklama gerekli' : null,
                onSaved: (val) => _description = val!.trim(),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                items: _categories.map((c) {
                  return DropdownMenuItem(value: c, child: Text(c));
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _category = val);
                },
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Gizli Topluluk'),
                subtitle: const Text(
                  'Sadece onaylanan üyeler içerikleri görebilir ve etkinliklere katılabilir.',
                ),
                value: _isPrivate,
                onChanged: (val) => setState(() => _isPrivate = val),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Topluluk Oluştur'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
