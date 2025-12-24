import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/core/navigation/app_router.dart';
import 'package:grocery_app/core/services/firebase_store_service.dart';
import 'package:grocery_app/core/theme/app_colors.dart';
import 'package:grocery_app/core/theme/app_text_styles.dart';
import 'package:grocery_app/features/auth/data/models/user_model.dart';
import 'package:grocery_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:grocery_app/features/auth/domain/repos/auth_repo.dart';

import '../../../../../core/helper_function/get_user_data.dart';

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({super.key});

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  late Future<UserModel> _userFuture;
  final FirebaseStoreService _firestoreService = FirebaseStoreService();
  final AuthRepo authRepo = AuthRepoImpl();

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  void _initializeUserData() {
    _userFuture = _firestoreService.getUserData(docId: getUser().uId);
    // final User? currentUser = FirebaseAuth.instance.currentUser;
    // if (currentUser != null) {
    //   _userFuture = _firestoreService.getUserData(docId: currentUser.uid);
    // } else {
    //   _userFuture = Future.error('User not authenticated');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: _userFuture,
      builder: (context, snapshot) {
        return switch (snapshot.connectionState) {
          ConnectionState.waiting => _buildLoadingIndicator(),
          _ => _buildContent(snapshot),
        };
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primaryOrange),
    );
  }

  Widget _buildContent(AsyncSnapshot<UserModel> snapshot) {
    if (snapshot.hasError) {
      return _buildErrorState();
    }

    if (!snapshot.hasData) {
      return _buildEmptyState();
    }

    final UserModel user = snapshot.data!;
    return _buildProfileContent(user);
  }

  Widget _buildErrorState() {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenWidth * 0.12;
    final fontSize = screenWidth * 0.04;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: iconSize),
            SizedBox(height: screenWidth * 0.04),
            Text(
              'Failed to load profile data',
              style: AppTextStyles.poppinsMedium.copyWith(fontSize: fontSize),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenWidth * 0.04),
            ElevatedButton(
              onPressed: _initializeUserData,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryOrange,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08,
                  vertical: screenWidth * 0.04,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Retry',
                style: AppTextStyles.poppinsMedium.copyWith(
                  color: AppColors.white,
                  fontSize: fontSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(child: Text('No user data available'));
  }

  Widget _buildProfileContent(UserModel user) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.04;
    final verticalSpacing = screenHeight * 0.03;

    return SingleChildScrollView(
      padding: EdgeInsets.all(horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileHeader(user),
          SizedBox(height: verticalSpacing),
          _buildPersonalInfoSection(user),
          SizedBox(height: verticalSpacing),
          _buildAccountSettingsSection(),
          SizedBox(height: verticalSpacing),
          _buildLogoutButton(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(UserModel user) {
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarSize = (screenWidth * 0.2).clamp(60.0, 100.0);
    final spacing = screenWidth * 0.04;

    return Row(
      children: [
        _buildProfileAvatar(avatarSize),
        SizedBox(width: spacing),
        Expanded(child: _buildUserInfo(user)),
      ],
    );
  }

  Widget _buildProfileAvatar(double size) {
    final iconSize = size * 0.5;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primaryOrange, width: 2),
      ),
      child: Icon(Icons.person, size: iconSize, color: AppColors.primaryOrange),
    );
  }

  Widget _buildUserInfo(UserModel user) {
    final screenWidth = MediaQuery.of(context).size.width;
    final titleFontSize = (screenWidth * 0.05).clamp(16.0, 22.0);
    final subtitleFontSize = (screenWidth * 0.035).clamp(12.0, 16.0);
    final badgeFontSize = (screenWidth * 0.03).clamp(10.0, 14.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${user.fName} ${user.lName}',
          style: AppTextStyles.poppinsBold.copyWith(
            fontSize: titleFontSize,
            color: AppColors.black,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: screenWidth * 0.01),
        Text(
          user.email,
          style: AppTextStyles.poppinsRegular.copyWith(
            fontSize: subtitleFontSize,
            color: Colors.grey[600],
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: screenWidth * 0.02),
        _buildVerifiedBadge(badgeFontSize),
      ],
    );
  }

  Widget _buildVerifiedBadge(double fontSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = fontSize + 4;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenWidth * 0.01,
      ),
      decoration: BoxDecoration(
        color: AppColors.successGreenBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified, size: iconSize, color: AppColors.successGreen),
          SizedBox(width: screenWidth * 0.01),
          Text(
            'Verified',
            style: AppTextStyles.poppinsMedium.copyWith(
              fontSize: fontSize,
              color: AppColors.successGreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoSection(UserModel user) {
    final screenWidth = MediaQuery.of(context).size.width;
    final spacing = screenWidth * 0.04;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Personal Information'),
        SizedBox(height: spacing),
        _buildInfoCard([
          _buildInfoRow('Full Name', '${user.fName} ${user.lName}'),
          _buildInfoRow('Email', user.email),
          _buildInfoRow('User ID', user.uId),
        ]),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = (screenWidth * 0.045).clamp(16.0, 20.0);

    return Text(
      title,
      style: AppTextStyles.poppinsSemiBold.copyWith(
        fontSize: fontSize,
        color: AppColors.black,
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    final screenWidth = MediaQuery.of(context).size.width;
    final borderRadius = screenWidth * 0.03;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = (screenWidth * 0.035).clamp(12.0, 16.0);
    final padding = screenWidth * 0.04;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding * 0.75),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: AppTextStyles.poppinsMedium.copyWith(
                fontSize: fontSize,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: AppTextStyles.poppinsRegular.copyWith(
                fontSize: fontSize,
                color: AppColors.black,
              ),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSettingsSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final spacing = screenWidth * 0.04;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Account Settings'),
        SizedBox(height: spacing),
        _buildSettingsCard(),
      ],
    );
  }

  Widget _buildSettingsCard() {
    final screenWidth = MediaQuery.of(context).size.width;
    final borderRadius = screenWidth * 0.03;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSettingsRow(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            subtitle: 'Manage notifications settings',
            onTap: () {},
          ),
          Divider(
            height: 1,
            thickness: 1,
            indent: screenWidth * 0.04,
            endIndent: screenWidth * 0.04,
          ),
          _buildSettingsRow(
            icon: Icons.lock_outlined,
            title: 'Privacy Policy',
            subtitle: 'Read our privacy policy',
            onTap: () {},
          ),
          Divider(
            height: 1,
            thickness: 1,
            indent: screenWidth * 0.04,
            endIndent: screenWidth * 0.04,
          ),
          _buildSettingsRow(
            icon: Icons.info_outlined,
            title: 'About',
            subtitle: 'App version and information',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = (screenWidth * 0.06).clamp(20.0, 28.0);
    final titleFontSize = (screenWidth * 0.04).clamp(14.0, 18.0);
    final subtitleFontSize = (screenWidth * 0.03).clamp(11.0, 14.0);
    final arrowSize = (screenWidth * 0.04).clamp(14.0, 18.0);

    return ListTile(
      leading: Icon(icon, color: AppColors.primaryOrange, size: iconSize),
      title: Text(
        title,
        style: AppTextStyles.poppinsMedium.copyWith(fontSize: titleFontSize),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.poppinsRegular.copyWith(
          fontSize: subtitleFontSize,
          color: Colors.grey[600],
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: arrowSize,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final fontSize = (screenWidth * 0.04).clamp(14.0, 18.0);
    final verticalPadding = screenHeight * 0.02;
    final borderRadius = screenWidth * 0.03;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _showLogoutConfirmationDialog,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.errorRed,
          foregroundColor: AppColors.white,
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          'Log Out',
          style: AppTextStyles.poppinsSemiBold.copyWith(fontSize: fontSize),
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog() {
    final screenWidth = MediaQuery.of(context).size.width;
    final titleFontSize = (screenWidth * 0.045).clamp(16.0, 20.0);
    final contentFontSize = (screenWidth * 0.035).clamp(13.0, 16.0);
    final buttonFontSize = (screenWidth * 0.035).clamp(13.0, 16.0);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Log Out',
            style: AppTextStyles.poppinsBold.copyWith(fontSize: titleFontSize),
          ),
          content: Text(
            'Are you sure you want to log out?',
            style: AppTextStyles.poppinsRegular.copyWith(fontSize: contentFontSize),
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: Text(
                'Cancel',
                style: AppTextStyles.poppinsMedium.copyWith(
                  color: Colors.grey,
                  fontSize: buttonFontSize,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _performLogout();
              },
              child: Text(
                'Log Out',
                style: AppTextStyles.poppinsMedium.copyWith(
                  color: AppColors.errorRed,
                  fontSize: buttonFontSize,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _performLogout() {
    FirebaseAuth.instance.signOut();
    authRepo.deleteUserData();
    if (mounted) {
      GoRouter.of(context).go(AppRoutes.login);
    }
  }
}