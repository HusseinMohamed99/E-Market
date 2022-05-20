// ignore_for_file: unnecessary_import, camel_case_types, non_constant_identifier_names, duplicate_ignore

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mego_market/Screens/login/cubit/state.dart';
import 'package:mego_market/model/login/login_model.dart';
import 'package:mego_market/network/End_Points.dart';
import 'package:mego_market/network/dio_helper.dart';

class loginCubit extends Cubit<LoginState> {
  loginCubit() : super(LoginInitialState());
  static loginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void UserLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  // ignore: non_constant_identifier_names
  void ChangePassword() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordState());
  }
}
