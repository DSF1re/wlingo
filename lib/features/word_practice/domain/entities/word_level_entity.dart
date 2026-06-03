import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_level_entity.freezed.dart';
part 'word_level_entity.g.dart';

@freezed
sealed class WordLevelEntity with _$WordLevelEntity {
  const factory WordLevelEntity({
    required int id,
    required String name,
    String? description,
    @JsonKey(name: 'level_order') required int levelOrder,
  }) = _WordLevelEntity;

  factory WordLevelEntity.fromJson(Map<String, dynamic> json) => _$WordLevelEntityFromJson(json);
}
