import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../providers/profile_setup_notifier.dart';

/// Fixed hobby list — can be moved to Firebase later.
const _availableHobbies = [
  'Spor',
  'Teknoloji',
  'Müzik',
  'Sanat',
  'Seyahat',
  'Yemek',
  'Doğa',
  'Oyun',
  'Kitap',
  'Film',
  'Fotoğrafçılık',
  'Dans',
];

class ProfileSetupPage extends ConsumerStatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  ConsumerState<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends ConsumerState<ProfileSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _selectedHobbies = <String>{};

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final notifier = ref.read(profileSetupProvider.notifier);
    final success = await notifier.saveProfile(
      displayName: _nameController.text,
      bio: _bioController.text,
      hobbies: _selectedHobbies.toList(),
    );

    if (!mounted) return;

    if (success) {
      context.go('/home');
    } else {
      final errorMsg = ref.read(profileSetupProvider.notifier).errorMessage;
      if (errorMsg != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMsg),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final setupState = ref.watch(profileSetupProvider);
    final isLoading = setupState.isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Profilini Kur')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Greeting ──
                Text(
                  'Biraz kendinizden bahsedin 👋',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),

                // ── Display Name ──
                TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Adınız *',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'İsim gerekli';
                    if (v.trim().length < 2) return 'En az 2 karakter olmalı';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // ── Bio ──
                TextFormField(
                  controller: _bioController,
                  maxLines: 3,
                  maxLength: 200,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: 'Hakkınızda (opsiyonel)',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(bottom: 48),
                      child: Icon(Icons.info_outline),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // ── Hobbies ──
                Text(
                  'İlgi Alanlarınız',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'En az 1 tane seçin',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _availableHobbies.map((hobby) {
                    final isSelected = _selectedHobbies.contains(hobby);
                    return FilterChip(
                      label: Text(hobby),
                      selected: isSelected,
                      selectedColor: AppColors.primary.withValues(alpha: 0.15),
                      checkmarkColor: AppColors.primary,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedHobbies.add(hobby);
                          } else {
                            _selectedHobbies.remove(hobby);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 32),

                // ── Submit ──
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: isLoading || _selectedHobbies.isEmpty
                        ? null
                        : _submit,
                    child: isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Tamamla'),
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
