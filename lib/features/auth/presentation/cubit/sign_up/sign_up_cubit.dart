import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grocery_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:grocery_app/features/auth/domain/entities/user_entity.dart';
import 'package:grocery_app/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  final AuthRepo authRepo = AuthRepoImpl();

  Future<void> signUpWithEmailPassword({
    required String fName,
    required String lName,
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());
    var result = await authRepo.createAccountWithEmailPassword(
      fName: fName,
      lName: lName,
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(SignUpFailure(errMessage: failure.errMessage)),
      (userEntity) => emit(SignUpSuccess(userEntity: userEntity)),
    );
  }
}
