import 'package:json_annotation/json_annotation.dart';

part 'recommended_response.g.dart';

@JsonSerializable()
class RecommendedResponseWrapper {
  @JsonKey(name: 'recommended')
  final List<RecommendedItem> recommended;

  RecommendedResponseWrapper({required this.recommended});

  factory RecommendedResponseWrapper.fromJson(Map<String, dynamic> json) =>
      _$RecommendedResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendedResponseWrapperToJson(this);
}

@JsonSerializable()
class RecommendedItem {
  final String id;
  final String title;
  final String description;
  final String category;
  @JsonKey(name: 'imageUrl')
  final String imageUrl;
  final bool featured;

  RecommendedItem({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.featured,
  });

  factory RecommendedItem.fromJson(Map<String, dynamic> json) =>
      _$RecommendedItemFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendedItemToJson(this);
}
