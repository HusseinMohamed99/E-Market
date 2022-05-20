// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mego_market/cubit/cubit.dart';
import 'package:mego_market/cubit/state.dart';
import 'package:mego_market/model/login/login_model.dart';
import 'package:mego_market/shared/componnetns/components.dart';

class EditScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {
        if (state is UserLoginSuccessStates) {}
      },
      builder: (context, state) {
        LoginModel? model = MainCubit.get(context).UserData;
        emailController.text = model!.data!.email!;
        phoneController.text = model.data!.phone!;
        nameController.text = model.data!.name!;

        return ConditionalBuilder(
          condition: MainCubit.get(context).UserData != null,
          builder: (context) => Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(children: [
                    if (state is UserUpdateLoadingStates)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    defaultTextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      },
                      label: 'Name',
                      hint: 'Enter your name',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultTextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "Email is required";
                        }
                        return null;
                      },
                      label: 'Email',
                      hint: 'Enter your Email',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultTextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "Phone is required";
                        }
                        return null;
                      },
                      label: 'Phone',
                      hint: 'Enter your Phone',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultMaterialButton(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          MainCubit.get(context).UpdateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                        return null;
                      },
                      text: 'Update',
                    )
                  ]),
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
