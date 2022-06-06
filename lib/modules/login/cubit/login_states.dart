abstract class SocialLoginStates {}

class InitialState extends SocialLoginStates{}


class LoginLoadingState extends SocialLoginStates{}

class LoginSuccessState extends SocialLoginStates{
   final String? uid;
   LoginSuccessState(this.uid);
}

class LoginErrorState extends SocialLoginStates{
   final String error;
   LoginErrorState(this.error);
}

class LoginPasswordState extends SocialLoginStates{}