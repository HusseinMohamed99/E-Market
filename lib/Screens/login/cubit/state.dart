import 'package:mego_market/model/login/login_model.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}

class ChangePasswordState extends LoginState {}
