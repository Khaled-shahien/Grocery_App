import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grocery_app/features/home/api_home/api_home.dart';
import 'package:grocery_app/features/home/api_home/models/recommended_response.dart';
import 'package:grocery_app/features/home/api_home/models/trending_deals_response.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeApiService apiService;

  HomeCubit(this.apiService) : super(HomeInitial());

  Future<void> fetchHomeData() async {
    emit(HomeLoading());
    try {
      final recommendedResponse = await apiService.getRecommendedItems();
      final trendingDealsResponse = await apiService.getTrendingDeals();

      // Extract the first item from the array response
      final recommendedItems = recommendedResponse.data.isNotEmpty
          ? recommendedResponse.data.first.recommended.cast<RecommendedItem>()
          : <RecommendedItem>[];

      final trendingDeals = trendingDealsResponse.data.isNotEmpty
          ? trendingDealsResponse.data.first.trendingDeals.cast<TrendingDeal>()
          : <TrendingDeal>[];

      emit(
        HomeSuccess(
          recommendedItems: recommendedItems,
          trendingDeals: trendingDeals,
        ),
      );
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
