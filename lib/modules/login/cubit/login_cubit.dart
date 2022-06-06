import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit() : super(InitialState());
  static SocialLoginCubit get(context)=>BlocProvider.of(context);
  
  bool isPassword=false;
  
  void changePasswordVisibility()
  {
    isPassword= !isPassword;
    emit(LoginPasswordState());
  }

  void userLogin({required email, required password})
  {
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then(
            (value)
        {
         emit(LoginSuccessState(value.user!.uid));
        }).catchError(
            (error){
              print(error.toString());
              emit(LoginErrorState(error.toString()));
            }
    );
  }
  
}