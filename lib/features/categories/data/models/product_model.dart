import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final String id;
  final String name;
  final double price;
  final double oldPrice;
  final double rating;
  final String imageUrl;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.rating,
    required this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable()
class CategoriesModel {
  //data =map 
  final Map<String, List<ProductModel>> categories;

  CategoriesModel({required this.categories});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesModelToJson(this);
}
