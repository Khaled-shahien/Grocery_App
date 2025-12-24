import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/core/theme/app_colors.dart';
import 'package:grocery_app/core/widgets/custom_loading_dialog.dart';
import 'package:grocery_app/core/widgets/custom_snackbar.dart';
import 'package:grocery_app/core/widgets/snackbar_type.dart';
import 'package:grocery_app/core/navigation/app_router.dart';
import 'package:grocery_app/features/auth/presentation/cubit/sign_up/sign_up_cubit.dart';
import 'package:grocery_app/features/auth/presentation/screens/widgets/signup_view_body.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is SignUpLoading) {
              // Show custom loading dialog
              CustomLoadingDialog.showRegister(context);
            } else {
              // Hide custom loading dialog
              CustomLoadingDialog.hide(context);
            }

            if (state is SignUpFailure) {
              CustomSnackBar.show(
                context: context,
                title: 'Failed',
                message: state.errMessage,
                type: SnackBarType.error,
              );
            }
            if (state is SignUpSuccess) {
              CustomSnackBar.show(
                context: context,
                title: 'Success',
                message: 'Account created successfully!',
                type: SnackBarType.success,
              );
              context.go(
                AppRoutes.congratulations,
                extra: state.userEntity.fName,
              );
            }
          },
          builder: (context, state) {
            return const SignupViewBody();
          },
        ),
      ),
    );
  }
}
