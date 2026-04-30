import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import 'package:bulusalim_app_01/core/firebase/storage_providers.dart';
import 'package:bulusalim_app_01/features/auth/presentation/providers/auth_providers.dart';
import 'package:bulusalim_app_01/features/event/presentation/providers/event_providers.dart';

class CreateEventPage extends ConsumerStatefulWidget {
  final String? communityId;

  const CreateEventPage({super.key, this.communityId});

  @override
  ConsumerState<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends ConsumerState<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  String _address = '';
  int? _capacity;
  bool _isOnline = false;
  
  DateTime? _startDate;
  TimeOfDay? _startTime;

  DateTime? _endDate;
  TimeOfDay? _endTime;

  bool _isLoading = false;
  File? _selectedImage;
  
  // Date Formatter
  final _dateFormat = DateFormat('dd/MM/yyyy');

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (pickedFile != null) {
      if (mounted) {
        setState(() => _selectedImage = File(pickedFile.path));
      }
    }
  }

  Future<void> _pickDate(bool isStart) async {
    final initialDate = isStart
        ? (_startDate ?? DateTime.now())
        : (_endDate ?? _startDate ?? DateTime.now());
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      if (mounted) {
        setState(() {
          if (isStart) {
            _startDate = picked;
            if (_endDate != null && _endDate!.isBefore(_startDate!)) {
              _endDate = _startDate; // Auto adjust End Date
            }
          } else {
            _endDate = picked;
          }
        });
      }
    }
  }

  Future<void> _pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      if (mounted) {
        setState(() {
          if (isStart) {
            _startTime = picked;
          } else {
            _endTime = picked;
          }
        });
      }
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_startDate == null || _startTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen etkinlik başlangıç tarihi ve saatini seçin.')),
      );
      return;
    }

    _formKey.currentState!.save();

    final user = ref.read(currentUserProvider);
    if (user == null) return;

    setState(() => _isLoading = true);

    try {
      final repo = ref.read(eventRepositoryProvider);
      final storage = ref.read(storageRepositoryProvider);
      
      // Construct exact DateTimes
      final startDateTime = DateTime(
        _startDate!.year,
        _startDate!.month,
        _startDate!.day,
        _startTime!.hour,
        _startTime!.minute,
      );

      DateTime? endDateTime;
      if (_endDate != null && _endTime != null) {
        endDateTime = DateTime(
          _endDate!.year,
          _endDate!.month,
          _endDate!.day,
          _endTime!.hour,
          _endTime!.minute,
        );
      }

      final event = await repo.createEvent(
        title: _title,
        description: _description,
        organizerId: user.uid,
        communityId: widget.communityId,
        address: _isOnline ? 'Online' : _address,
        startDate: startDateTime,
        endDate: endDateTime,
        capacity: _capacity,
        isOnline: _isOnline,
        tags: [], // Could add tag input later
      );

      // Upload image if selected
      if (_selectedImage != null) {
        final url = await storage.uploadEventCover(
          file: _selectedImage!, 
          eventId: event.id,
        );
        await repo.updateCoverImage(event.id, url);
      }

      // Invalidate feeds
      ref.invalidate(homeEventsFeedProvider);
      if (widget.communityId != null) {
        ref.invalidate(communityEventsFeedProvider(widget.communityId!));
      }

      if (mounted) {
        context.pop();
        context.push('/event/${event.id}');
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
        title: const Text('Yeni Etkinlik Oluştur'),
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

              if (widget.communityId != null) ...[
                const Card(
                  color: Colors.deepPurple,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Icon(Icons.group, color: Colors.white),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Bu etkinlik otomatik olarak bulunduğunuz topluluğa eklenecektir.',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Etkinlik Adı',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.event),
                ),
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Etkinlik adı gerekli' : null,
                onSaved: (val) => _title = val!.trim(),
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

              // Date & Time Selectors
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.calendar_today),
                      label: Text(_startDate == null
                          ? 'Başlangıç Tarihi'
                          : _dateFormat.format(_startDate!)),
                      onPressed: () => _pickDate(true),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.access_time),
                      label: Text(_startTime == null
                          ? 'Saat'
                          : _startTime!.format(context)),
                      onPressed: () => _pickTime(true),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.event_busy),
                      label: Text(_endDate == null
                          ? 'Bitiş Tarihi (Opsiyonel)'
                          : _dateFormat.format(_endDate!)),
                      onPressed: () => _pickDate(false),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.access_time),
                      label: Text(_endTime == null
                          ? 'Saat'
                          : _endTime!.format(context)),
                      onPressed: () => _pickTime(false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              SwitchListTile(
                title: const Text('Online Etkinlik'),
                subtitle: const Text('Fiziksel bir buluşma değil mi?'),
                value: _isOnline,
                onChanged: (val) => setState(() => _isOnline = val),
              ),
              const SizedBox(height: 16),
              
              if (!_isOnline)
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Tam Adres / Konum Detayı',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  validator: (val) =>
                      (_isOnline == false && (val == null || val.trim().isEmpty))
                          ? 'Fiziksel etkinlikler için adres gerekli'
                          : null,
                  onSaved: (val) => _address = val?.trim() ?? '',
                )
              else 
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Toplantı Linki (Zoom, Meet vs.)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.link),
                  ),
                  onSaved: (val) => _address = val?.trim() ?? '',
                ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Kapasite (Kişi Sınırı)',
                  hintText: 'Sınırsız ise boş bırakın',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.group_add),
                ),
                keyboardType: TextInputType.number,
                onSaved: (val) {
                  if (val != null && val.trim().isNotEmpty) {
                    _capacity = int.tryParse(val.trim());
                  }
                },
              ),
              const SizedBox(height: 32),
              
              ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Etkinlik Oluştur'),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
