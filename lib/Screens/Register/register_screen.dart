import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_marko/Layout/layout_screen.dart';
import 'package:super_marko/Screens/login/login_screen.dart';
import 'package:super_marko/Screens/register/cubit/cubit.dart';
import 'package:super_marko/Screens/register/cubit/state.dart';
import 'package:super_marko/network/cache_helper.dart';
import 'package:super_marko/shared/components/buttons.dart';
import 'package:super_marko/shared/components/constants.dart';
import 'package:super_marko/shared/components/navigator.dart';
import 'package:super_marko/shared/components/show_toast.dart';
import 'package:super_marko/shared/components/text_form_field.dart';
import 'package:super_marko/shared/cubit/cubit.dart';
import 'package:super_marko/shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final emailController = TextEditingController();

    final passwordController = TextEditingController();

    final nameController = TextEditingController();

    final phoneController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.loginModel.status!) {
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.success,
              );
              if (kDebugMode) {
                print(state.loginModel.message);
              }
              if (kDebugMode) {
                print(state.loginModel.data!.token);
              }
              CacheHelper.saveData(
                      key: "token", value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token!;
                navigateAndFinish(context, const LayoutScreen());
              });
            } else {
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.error,
              );
              if (kDebugMode) {
                print(state.loginModel.message);
              }
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: MainCubit.get(context).isDark
                ? AppMainColors.mainColor
                : AppColorsDark.primaryDarkColor,
            body: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned(
                          left: 214.w,
                          top: -47.h,
                          child: Container(
                            width: 280.w,
                            height: 220.h,
                            decoration: const ShapeDecoration(
                              color: AppMainColors.orangeColor,
                              shape: OvalBorder(),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20.w,
                          top: 120.h,
                          child: Container(
                            width: 200.w,
                            decoration: const ShapeDecoration(
                              shape: OvalBorder(),
                            ),
                            child: Text(
                              'Create\nAccount',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20.w,
                          top: 40.h,
                          child: IconButton(
                            onPressed: () {
                              pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              size: 24.sp,
                              color: AppMainColors.whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0).r,
                        child: Column(children: [
                          DefaultTextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            prefix: Icons.person,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter name';
                              }
                              return null;
                            },
                            label: 'Name',
                          ),
                          SizedBox(height: 15.h),
                          DefaultTextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            prefix: Icons.email,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                            label: 'Email',
                          ),
                          SizedBox(height: 15.h),
                          DefaultTextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            prefix: Icons.phone,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter phone';
                              }
                              return null;
                            },
                            label: 'Phone',
                          ),
                          SizedBox(height: 15.h),
                          DefaultTextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            prefix: Icons.key,
                            suffix: RegisterCubit.get(context).suffix,
                            isPassword: RegisterCubit.get(context).isPassword,
                            suffixPressed: () {
                              RegisterCubit.get(context).changePassword();
                            },
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                            label: 'Password',
                          ),
                          SizedBox(height: 40.h),
                          RegisterCubit.get(context).isCheck
                              ? defaultMaterialButton(
                                  color: AppMainColors.orangeColor,
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      RegisterCubit.get(context).userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phoneController.text,
                                      );
                                    }
                                  },
                                  text: 'Sign UP',
                                  radius: 20,
                                  context: context,
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  height: 48.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15).r,
                                    color: AppMainColors.orangeColor
                                        .withOpacity(0.5),
                                  ),
                                  child: Text(
                                    'Sign UP'.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  checkBox(context),
                                  Text(
                                    'By creating an account, you agree to our',
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 45.0).r,
                                child: Text(
                                  'Term and Conditions',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        height: 0.2,
                                        color: AppMainColors.greenColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                        ]),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 43.h,
                    decoration:
                        const BoxDecoration(color: AppMainColors.orangeColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Have an account ?',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        defaultTextButton(
                          function: () {
                            navigateTo(context, const LoginScreen());
                          },
                          text: 'Sign In'.toUpperCase(),
                          color: AppMainColors.mainColor,
                          context: context,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget checkBox(BuildContext context) {
    var cubit = RegisterCubit.get(context);
    return Checkbox.adaptive(
      side: const BorderSide(
        color: AppMainColors.whiteColor,
      ),
      activeColor: AppMainColors.orangeColor,
      value: cubit.isCheck,
      onChanged: (e) {
        cubit.boxCheck(e!);
      },
    );
  }
}
