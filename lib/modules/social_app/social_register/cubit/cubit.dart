import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/modules/social_app/social_register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void uesrRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(SocialRegisterSuccessState());
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  bool ispassword = true;
  IconData sufix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    ispassword = !ispassword;
    sufix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterChangeVisibilityState());
  }
}
