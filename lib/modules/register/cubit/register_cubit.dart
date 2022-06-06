import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/register/register_model.dart';
import 'package:social_app/modules/register/cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;

  void changeVisibility() {
    isPassword = !isPassword;
    emit(ChangeVisibilityState());
  }

  void register(
      {required email, required name, required phone, required password}) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(email: email, name: name, phone: phone, uid: value.user!.uid);
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required email,
    required name,
    required phone,
    required uid,
  }) {
    SocialUserModel model = SocialUserModel(
      email: email,
      name: name,
      phone: phone,
      uid: uid,
      isEmailVerified: false,
      image:
          'https://img.freepik.com/photos-gratuite/joyeuse-femme-age-moyen-aux-cheveux-boucles_1262-20859.jpg?w=740',
      bio: 'Write Your Bio Here',
      cover:
          'https://img.freepik.com/photos-gratuite/portrait-jeune-femme-sautant-megaphone_23-2148883670.jpg?w=826',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(RegisterCreateUserSuccessState(uid));
    }).catchError((error) {
      emit(RegisterCreateUserErrorState(error.toString()));
    });
  }
}
