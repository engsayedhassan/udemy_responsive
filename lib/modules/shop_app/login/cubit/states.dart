import 'package:untitled1/models/shop_app/shop_login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopChangeVisibilityState extends ShopLoginStates {}

class ShopLoginErrorState extends ShopLoginStates {
  final String error;

  ShopLoginErrorState(this.error);
}

class ShopLoginSuccessState extends ShopLoginStates {
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}
