import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grocery_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:grocery_app/features/auth/domain/entities/user_entity.dart';
import 'package:grocery_app/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  final AuthRepo authRepo = AuthRepoImpl();

  Future<void> signInWithEmailPassword({required String email, required String password}) async {
    emit(SignInLoading());
    var result = await authRepo.signInWithEmailPassword(email: email, password: password);
    result.fold(
      (failure) => emit(SignInFailure(errMessage: failure.errMessage)),
      (userEntity) => emit(SignInSuccess(userEntity: userEntity)),
    );
  }
}
