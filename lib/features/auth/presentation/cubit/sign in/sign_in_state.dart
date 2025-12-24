part of 'sign_in_cubit.dart';

@immutable
sealed class SignInState extends Equatable{
  @override
  List<Object?> get props => [];
}

final class SignInInitial extends SignInState {}
final class SignInLoading extends SignInState {}
final class SignInFailure extends SignInState {
  final String errMessage;

  SignInFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
final class SignInSuccess extends SignInState {
  final UserEntity userEntity;

  SignInSuccess({required this.userEntity});

  @override
  List<Object?> get props => [userEntity];
}
