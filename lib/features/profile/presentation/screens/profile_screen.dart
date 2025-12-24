import 'package:flutter/material.dart';
import 'package:grocery_app/features/profile/presentation/screens/widgets/profile_screen_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: ProfileScreenBody()));
  }
}
