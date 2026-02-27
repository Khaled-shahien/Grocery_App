import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/constants/assets.dart';
import 'package:grocery_app/core/navigation/app_router.dart';
import 'package:grocery_app/core/theme/app_colors.dart';
import 'package:grocery_app/core/theme/app_text_styles.dart';
import 'package:grocery_app/core/widgets/custome_build_text_feld.dart';
import 'package:grocery_app/features/auth/presentation/cubit/sign%20in/sign_in_cubit.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});

  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive values
    final imageHeight = screenHeight * 0.4;
    final borderRadius = screenWidth * 0.1;
    final horizontalPadding = screenWidth * 0.06;
    final verticalSpacing = screenHeight * 0.02;
    final fieldSpacing = screenHeight * 0.02;
    final buttonHeight = screenHeight * 0.06;
    final offset = screenHeight * 0.05;

    // Font sizes
    final titleFontSize = (screenWidth * 0.06).clamp(20.0, 28.0);
    final buttonFontSize = (screenWidth * 0.04).clamp(14.0, 18.0);
    final textFontSize = (screenWidth * 0.035).clamp(12.0, 16.0);

    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _key,
          autovalidateMode: autoValidateMode,
          child: Column(
            children: [
              Image.asset(
                Assets.imagesHealthyFoodBowl1,
                width: double.infinity,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
              Transform.translate(
                offset: Offset(0, -offset),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(horizontalPadding),
                    child: Column(
                      children: [
                        SizedBox(height: verticalSpacing * 0.8),
                        Text(
                          'SIGN IN',
                          style: AppTextStyles.poppinsBold.copyWith(
                            fontSize: titleFontSize,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: verticalSpacing),
                        Row(
                          children: [
                            Expanded(
                              child: buildTextField(
                                'Email',
                                controller: emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'email can not be empty';
                                  }
                                  final emailRegExp = RegExp(
                                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                  if (!emailRegExp.hasMatch(value)) {
                                    return 'invalid format';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: fieldSpacing),
                        buildTextField(
                          'Password',
                          isPassword: true,
                          controller: passwordController,
                          validator: (value) {
                            if (value == null ||
                                value.length < 7 ||
                                value.isEmpty) {
                              return 'password at least must be 7 digit';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: fieldSpacing * 0.6),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style: AppTextStyles.poppinsMedium.copyWith(
                              color: AppColors.mediumYellow,
                              fontSize: textFontSize,
                            ),
                          ),
                        ),
                        SizedBox(height: verticalSpacing),
                        SizedBox(
                          width: double.infinity,
                          height: buttonHeight,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                _key.currentState!.save();
                                context
                                    .read<SignInCubit>()
                                    .signInWithEmailPassword(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                              } else {
                                autoValidateMode = AutovalidateMode.always;
                                setState(() {});
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.mediumYellow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  screenWidth * 0.03,
                                ),
                              ),
                            ),
                            child: Text(
                              'SIGN IN',
                              style: AppTextStyles.poppinsBold.copyWith(
                                color: AppColors.black,
                                fontSize: buttonFontSize,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: fieldSpacing),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: AppTextStyles.poppinsRegular.copyWith(
                                color: Colors.grey[600],
                                fontSize: textFontSize,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.push(AppRoutes.signup);
                              },
                              child: Text(
                                'Create Account',
                                style: AppTextStyles.poppinsMedium.copyWith(
                                  color: AppColors.mediumYellow,
                                  fontSize: textFontSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
