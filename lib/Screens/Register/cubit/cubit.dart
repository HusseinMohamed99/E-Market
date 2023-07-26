import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_marko/Screens/register/cubit/state.dart';
import 'package:super_marko/model/login/login_model.dart';
import 'package:super_marko/network/cache_helper.dart';
import 'package:super_marko/network/dio_helper.dart';
import 'package:super_marko/network/end_points.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
    String? image,
  }) {
    emit(RegisterLoadingState());

    DioHelper.postData(
      url: register,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
        'image': image,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel!));
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePassword() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordRegisterState());
  }

  bool isCheck = false;

  void boxCheck(bool newCheck) async {
    emit(ChangeValueLoadingState());
    if (isCheck == newCheck) return;
    isCheck = newCheck;
    CacheHelper.saveData(key: 'check', value: isCheck).then((value) {
      emit(ChangeValueSuccessState());
      if (kDebugMode) {
        print('isCheck === $isCheck');
      }
    }).catchError((error) {
      emit(ChangeValueErrorState());
    });
  }
}
