import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:bulusalim_app_01/core/firebase/storage_repository.dart';
import 'package:bulusalim_app_01/core/firebase/storage_repository_impl.dart';

part 'storage_providers.g.dart';

@riverpod
StorageRepository storageRepository(Ref ref) {
  return StorageRepositoryImpl();
}
