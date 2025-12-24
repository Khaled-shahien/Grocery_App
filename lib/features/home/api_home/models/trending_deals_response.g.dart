// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending_deals_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendingDealsResponseWrapper _$TrendingDealsResponseWrapperFromJson(
  Map<String, dynamic> json,
) => TrendingDealsResponseWrapper(
  trendingDeals: (json['trendingDeals'] as List<dynamic>)
      .map((e) => TrendingDeal.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TrendingDealsResponseWrapperToJson(
  TrendingDealsResponseWrapper instance,
) => <String, dynamic>{'trendingDeals': instance.trendingDeals};

TrendingDeal _$TrendingDealFromJson(Map<String, dynamic> json) => TrendingDeal(
  id: json['id'] as String,
  name: json['name'] as String,
  nameEn: json['nameEn'] as String,
  price: (json['price'] as num).toDouble(),
  oldPrice: (json['oldPrice'] as num).toDouble(),
  unit: json['unit'] as String,
  discount: (json['discount'] as num).toInt(),
  rating: (json['rating'] as num).toDouble(),
  imageUrl: json['imageUrl'] as String,
  category: json['category'] as String,
  trending: json['trending'] as bool,
  stock: json['stock'] as String,
);

Map<String, dynamic> _$TrendingDealToJson(TrendingDeal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nameEn': instance.nameEn,
      'price': instance.price,
      'oldPrice': instance.oldPrice,
      'unit': instance.unit,
      'discount': instance.discount,
      'rating': instance.rating,
      'imageUrl': instance.imageUrl,
      'category': instance.category,
      'trending': instance.trending,
      'stock': instance.stock,
    };
