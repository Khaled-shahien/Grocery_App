import 'package:json_annotation/json_annotation.dart';

part 'trending_deals_response.g.dart';

@JsonSerializable()
class TrendingDealsResponseWrapper {
  @JsonKey(name: 'trendingDeals')
  final List<TrendingDeal> trendingDeals;

  TrendingDealsResponseWrapper({required this.trendingDeals});

  factory TrendingDealsResponseWrapper.fromJson(Map<String, dynamic> json) =>
      _$TrendingDealsResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$TrendingDealsResponseWrapperToJson(this);
}

@JsonSerializable()
class TrendingDeal {
  final String id;
  final String name;
  @JsonKey(name: 'nameEn')
  final String nameEn;
  final double price;
  @JsonKey(name: 'oldPrice')
  final double oldPrice;
  final String unit;
  final int discount;
  final double rating;
  @JsonKey(name: 'imageUrl')
  final String imageUrl;
  final String category;
  final bool trending;
  final String stock;

  TrendingDeal({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.price,
    required this.oldPrice,
    required this.unit,
    required this.discount,
    required this.rating,
    required this.imageUrl,
    required this.category,
    required this.trending,
    required this.stock,
  });

  factory TrendingDeal.fromJson(Map<String, dynamic> json) =>
      _$TrendingDealFromJson(json);

  Map<String, dynamic> toJson() => _$TrendingDealToJson(this);
}
