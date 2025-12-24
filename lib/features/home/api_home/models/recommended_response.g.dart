// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommended_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendedResponseWrapper _$RecommendedResponseWrapperFromJson(
  Map<String, dynamic> json,
) => RecommendedResponseWrapper(
  recommended: (json['recommended'] as List<dynamic>)
      .map((e) => RecommendedItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$RecommendedResponseWrapperToJson(
  RecommendedResponseWrapper instance,
) => <String, dynamic>{'recommended': instance.recommended};

RecommendedItem _$RecommendedItemFromJson(Map<String, dynamic> json) =>
    RecommendedItem(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String,
      featured: json['featured'] as bool,
    );

Map<String, dynamic> _$RecommendedItemToJson(RecommendedItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'imageUrl': instance.imageUrl,
      'featured': instance.featured,
    };
