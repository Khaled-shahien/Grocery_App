import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/constants/assets.dart';
import 'package:grocery_app/core/navigation/app_router.dart';
import 'package:grocery_app/core/theme/app_colors.dart';
import 'package:grocery_app/core/theme/app_text_styles.dart';
import 'package:grocery_app/core/widgets/custome_build_text_feld.dart';
import 'package:grocery_app/features/auth/presentation/cubit/sign_up/sign_up_cubit.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  late TextEditingController fNameController;
  late TextEditingController lNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    fNameController = TextEditingController();
    lNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    fNameController.dispose();
    lNameController.dispose();
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
                          'Create your account',
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
                                'First Name',
                                controller: fNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'first name can not be empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.03),
                            Expanded(
                              child: buildTextField(
                                'Last Name',
                                controller: lNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'last name can not be empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: fieldSpacing),
                        buildTextField(
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
                        SizedBox(height: verticalSpacing),
                        SizedBox(
                          width: double.infinity,
                          height: buttonHeight,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                context
                                    .read<SignUpCubit>()
                                    .signUpWithEmailPassword(
                                  fName: fNameController.text.trim(),
                                  lName: lNameController.text.trim(),
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
                                borderRadius: BorderRadius.circular(screenWidth * 0.03),
                              ),
                            ),
                            child: Text(
                              'SIGN UP',
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
                              "Already have an account? ",
                              style: AppTextStyles.poppinsRegular.copyWith(
                                color: Colors.grey[600],
                                fontSize: textFontSize,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.push(AppRoutes.login);
                              },
                              child: Text(
                                'Sign In',
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