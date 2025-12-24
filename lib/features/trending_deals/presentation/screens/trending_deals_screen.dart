import 'package:flutter/material.dart';
import 'package:grocery_app/features/trending_deals/presentation/screens/widgets/trending_details_body.dart';

class TrendingDealsScreen extends StatelessWidget {
  const TrendingDealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: TrendingDetailsBody());
  }
}
