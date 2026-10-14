import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bulusalim_app_01/core/firebase/firestore_dates.dart';
import 'package:bulusalim_app_01/features/community/data/models/community.dart';

void main() {
  test(
    'server timestamps can be read by generated models after secure community creation',
    () {
      final time = DateTime.utc(2026, 10, 14);
      final model = Community.fromJson(
        decodeFirestoreDates({
          'id': 'c1',
          'name': 'Test',
          'description': '',
          'category': 'General',
          'ownerId': 'owner',
          'createdAt': Timestamp.fromDate(time),
        }),
      );
      expect(model.createdAt, time);
    },
  );
  test(
    'event dates are stored as timestamps and legacy ISO values remain readable',
    () {
      final time = DateTime.utc(2026, 10, 14);
      final encoded = encodeFirestoreDates({
        'startDate': time.toIso8601String(),
        'name': 'Test',
      });
      expect(encoded['startDate'], Timestamp.fromDate(time));
      expect(
        decodeFirestoreDates({
          'startDate': time.toIso8601String(),
        })['startDate'],
        time.toIso8601String(),
      );
    },
  );
}
