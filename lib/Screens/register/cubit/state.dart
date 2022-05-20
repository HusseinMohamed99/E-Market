import 'package:mego_market/model/login/login_model.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final LoginModel  loginModel;

  RegisterSuccessState(this.loginModel);
}

class RegisterErrorState extends RegisterState {
  final String error;

  RegisterErrorState( this.error);
}

class ChangePasswordRegisterState extends RegisterState {}
