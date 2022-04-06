import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/shop_app/shop_login_model.dart';
import 'package:untitled1/modules/shop_app/register/cubit/states.dart';
import 'package:untitled1/shared/components/constants.dart';
import 'package:untitled1/shared/network/end_points.dart';
import 'package:untitled1/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  late ShopLoginModel loginModel;

  void uesrRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      // print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      print('male');
      print(token);
      emit(ShopRegisterSuccessState(loginModel));
      print('female');
    }).catchError((error) {
      print(error.toString());
      print('hello');
      emit(ShopRegisterErrorState(error.toString()));
      print('Hi');
    });
  }

  bool ispassword = true;
  IconData sufix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    ispassword = !ispassword;
    sufix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangeVisibilityState());
  }
}
