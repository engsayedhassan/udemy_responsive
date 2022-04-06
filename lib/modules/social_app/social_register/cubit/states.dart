import 'package:untitled1/models/shop_app/shop_login_model.dart';

abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterChangeVisibilityState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates {
  final String error;

  SocialRegisterErrorState(this.error);
}

class SocialRegisterSuccessState extends SocialRegisterStates {}
