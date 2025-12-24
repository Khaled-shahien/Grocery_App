import 'package:flutter/material.dart';
import 'package:grocery_app/features/home/presentation/screens/widgets/home_screen_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreenBody(),
    );
  }
}