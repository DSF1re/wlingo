import 'package:freezed_annotation/freezed_annotation.dart';

part 'audition_record.freezed.dart';

@freezed
abstract class AuditionRecord with _$AuditionRecord {
  const factory AuditionRecord({
    int? id,
    required int correctWordId,
    int? selectedWordId,
    String? userId,
    required bool isCorrect,
    DateTime? createdAt,
  }) = _AuditionRecord;
}
