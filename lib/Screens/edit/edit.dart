import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_marko/cubit/cubit.dart';
import 'package:super_marko/cubit/state.dart';
import 'package:super_marko/model/login/login_model.dart';
import 'package:super_marko/shared/components/components.dart';
import 'package:super_marko/shared/components/text_form_field.dart';

class EditScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();

  EditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {
        if (state is UserLoginSuccessStates) {}
      },
      builder: (context, state) {
        LoginModel? model = MainCubit.get(context).userData;
        emailController.text = model!.data!.email!;
        phoneController.text = model.data!.phone!;
        nameController.text = model.data!.name!;

        return ConditionalBuilder(
          condition: MainCubit.get(context).userData != null,
          builder: (context) => Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(children: [
                    if (state is UserUpdateLoadingStates)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultTextFormField(
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
                    const SizedBox(
                      height: 10,
                    ),
                    DefaultTextFormField(
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
                    const SizedBox(
                      height: 10,
                    ),
                    DefaultTextFormField(
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
                    const SizedBox(
                      height: 10,
                    ),
                    defaultMaterialButton(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          MainCubit.get(context).updateUserData(
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
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
