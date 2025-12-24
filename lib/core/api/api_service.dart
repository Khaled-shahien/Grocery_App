import 'package:dio/dio.dart';
import 'package:grocery_app/features/categories/data/models/product_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://67eeeff6c11d5ff4bf7b5aeb.mockapi.io/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("products")
  Future<List<CategoriesModel>> getProducts();
}
