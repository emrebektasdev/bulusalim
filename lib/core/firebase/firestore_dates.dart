import 'package:cloud_firestore/cloud_firestore.dart';

const _dateFields = {
  'createdAt',
  'joinedAt',
  'requestedAt',
  'startDate',
  'endDate',
};

Map<String, dynamic> decodeFirestoreDates(Map<String, dynamic> json) =>
    json.map(
      (key, value) => MapEntry(
        key,
        value is Timestamp ? value.toDate().toUtc().toIso8601String() : value,
      ),
    );

Map<String, dynamic> encodeFirestoreDates(Map<String, dynamic> json) =>
    json.map(
      (key, value) => MapEntry(
        key,
        _dateFields.contains(key) && value is String
            ? Timestamp.fromDate(DateTime.parse(value))
            : value,
      ),
    );
