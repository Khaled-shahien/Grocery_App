import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:grocery_app/features/home/api_home/models/recommended_response.dart';
import 'package:grocery_app/features/home/api_home/models/trending_deals_response.dart';

part 'api_home.g.dart';

@RestApi(baseUrl: "https://6903cbebd0f10a340b25af97.mockapi.io/")
abstract class HomeApiService {
  factory HomeApiService(Dio dio, {String baseUrl}) = _HomeApiService;

  @GET("recommended")
  Future<HttpResponse<List<RecommendedResponseWrapper>>> getRecommendedItems();

  @GET("trendingDeals")
  Future<HttpResponse<List<TrendingDealsResponseWrapper>>> getTrendingDeals();
}
