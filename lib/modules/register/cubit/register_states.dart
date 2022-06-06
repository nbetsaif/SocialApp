abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  late final dynamic error;

  RegisterErrorState(this.error);
}

class ChangeVisibilityState extends RegisterStates {}

class RegisterCreateUserSuccessState extends RegisterStates {
  final String? uid;
  RegisterCreateUserSuccessState(this.uid);
}

class RegisterCreateUserErrorState extends RegisterStates {
  late final dynamic error;

  RegisterCreateUserErrorState(this.error);
}
