// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  id: json['id'] as String,
  name: json['name'] as String,
  price: (json['price'] as num).toDouble(),
  oldPrice: (json['oldPrice'] as num).toDouble(),
  rating: (json['rating'] as num).toDouble(),
  imageUrl: json['imageUrl'] as String,
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'oldPrice': instance.oldPrice,
      'rating': instance.rating,
      'imageUrl': instance.imageUrl,
    };

CategoriesModel _$CategoriesModelFromJson(Map<String, dynamic> json) =>
    CategoriesModel(
      categories: (json['categories'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
          k,
          (e as List<dynamic>)
              .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      ),
    );

Map<String, dynamic> _$CategoriesModelToJson(CategoriesModel instance) =>
    <String, dynamic>{'categories': instance.categories};
