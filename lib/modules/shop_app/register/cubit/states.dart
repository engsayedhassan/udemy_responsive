import 'package:untitled1/models/shop_app/shop_login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterChangeVisibilityState extends ShopRegisterStates {}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String error;

  ShopRegisterErrorState(this.error);
}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final ShopLoginModel loginModel;

  ShopRegisterSuccessState(this.loginModel);
}
