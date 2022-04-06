import 'package:untitled1/models/shop_app/shop_login_model.dart';

abstract class SocialLoginStates {}

class SocialLoginInitialState extends SocialLoginStates {}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialChangeVisibilityState extends SocialLoginStates {}

class SocialLoginErrorState extends SocialLoginStates {
  final String error;

  SocialLoginErrorState(this.error);
}

class SocialLoginSuccessState extends SocialLoginStates {}
