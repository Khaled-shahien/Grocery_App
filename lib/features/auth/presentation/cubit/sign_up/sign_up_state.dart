part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState extends Equatable{
  @override
  List<Object?> get props => [];
}

final class SignUpInitial extends SignUpState {}
final class SignUpLoading extends SignUpState {}
final class SignUpFailure extends SignUpState {
  final String errMessage;

  SignUpFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
final class SignUpSuccess extends SignUpState {
  final UserEntity userEntity;

  SignUpSuccess({required this.userEntity});
  @override
  List<Object?> get props => [userEntity];
}
