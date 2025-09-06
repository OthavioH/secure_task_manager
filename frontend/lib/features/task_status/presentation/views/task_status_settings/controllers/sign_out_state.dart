
sealed class SignOutState {
  bool get isLoading => this is SignOutLoading;
}

class SignOutInitial extends SignOutState {}

class SignOutLoading extends SignOutState {}

class SignOutSuccess extends SignOutState {}

class SignOutError extends SignOutState {
  final String message;

  SignOutError(this.message);
}