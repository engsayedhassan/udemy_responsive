import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/modules/social_app/social_login/cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void uesrLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(SocialLoginSuccessState());
    }).catchError((error) {
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  bool ispassword = true;
  IconData sufix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    ispassword = !ispassword;
    sufix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialChangeVisibilityState());
  }
}
