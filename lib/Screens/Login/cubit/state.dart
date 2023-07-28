import 'package:super_marko/model/login/login_model.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final UserModel userModel;

  LoginSuccessState(this.userModel);
}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}

class ChangePasswordState extends LoginState {}

class ChangeValueLoadingState extends LoginState {}

class ChangeValueSuccessState extends LoginState {}

class ChangeValueErrorState extends LoginState {}
