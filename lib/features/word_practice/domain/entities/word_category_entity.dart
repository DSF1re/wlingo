import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_category_entity.freezed.dart';
part 'word_category_entity.g.dart';

@freezed
sealed class WordCategoryEntity with _$WordCategoryEntity {
  const factory WordCategoryEntity({
    required int id,
    required String name,
    @JsonKey(name: 'level_id') int? levelId,
  }) = _WordCategoryEntity;

  factory WordCategoryEntity.fromJson(Map<String, dynamic> json) => _$WordCategoryEntityFromJson(json);
}
