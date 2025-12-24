
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/core/navigation/app_router.dart';
import 'package:grocery_app/core/theme/app_colors.dart';
import 'package:grocery_app/core/widgets/custom_loading_dialog.dart';
import 'package:grocery_app/core/widgets/custom_snackbar.dart';
import 'package:grocery_app/core/widgets/snackbar_type.dart';
import 'package:grocery_app/features/auth/presentation/cubit/sign%20in/sign_in_cubit.dart';
import 'package:grocery_app/features/auth/presentation/screens/widgets/sign_in_view_body.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: BlocConsumer<SignInCubit, SignInState>(
          listener: (context, state) {
            if (state is SignInLoading) {
              // Show custom loading dialog
              CustomLoadingDialog.showLogin(context);
            } else {
              // Hide custom loading dialog
              CustomLoadingDialog.hide(context);
            }

            if (state is SignInFailure) {
              CustomSnackBar.show(
                context: context,
                title: 'Failed to sign in',
                message: state.errMessage,
                type: SnackBarType.error,
              );
            } else if (state is SignInSuccess) {
              context.push(AppRoutes.layout);
            }
          },
          builder: (context, state) {
            return const SignInViewBody();
          },
        ),
      ),
    );
  }
}
