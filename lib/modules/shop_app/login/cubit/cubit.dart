import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/shop_app/shop_login_model.dart';
import 'package:untitled1/modules/shop_app/login/cubit/states.dart';
import 'package:untitled1/shared/network/end_points.dart';
import 'package:untitled1/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  late ShopLoginModel loginModel;

  void uesrLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      // print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      print('male');
      emit(ShopLoginSuccessState(loginModel));
      print('female');
    }).catchError((error) {
      print(error.toString());
      print('hello');
      emit(ShopLoginErrorState(error.toString()));
      print('Hi');
    });
  }

  bool ispassword = true;
  IconData sufix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    ispassword = !ispassword;
    sufix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangeVisibilityState());
  }
}
