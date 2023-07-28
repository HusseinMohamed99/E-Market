// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:super_marko/shared/components/navigator.dart';
// import 'package:super_marko/shared/cubit/cubit.dart';
// import 'package:super_marko/shared/styles/colors.dart';
// import 'package:super_marko/shared/styles/icon_broken.dart';
//
// class OrderScreen extends StatelessWidget {
//   const OrderScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'My Order',
//           style: Theme.of(context).textTheme.headlineSmall,
//         ),
//         leading: IconButton(
//           onPressed: () {
//             pop(context);
//           },
//           icon: Icon(
//             IconBroken.Arrow___Left_Circle,
//             size: 24.sp,
//             color: MainCubit.get(context).isDark
//                 ? AppMainColors.orangeColor
//                 : AppMainColors.whiteColor,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_marko/shared/components/buttons.dart';
import 'package:super_marko/shared/components/navigator.dart';
import 'package:super_marko/shared/components/show_toast.dart';
import 'package:super_marko/shared/components/text_form_field.dart';
import 'package:super_marko/shared/cubit/cubit.dart';
import 'package:super_marko/shared/cubit/state.dart';
import 'package:super_marko/shared/styles/colors.dart';
import 'package:super_marko/shared/styles/icon_broken.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formState = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController regionController = TextEditingController();
    TextEditingController detailsController = TextEditingController();
    TextEditingController notesController = TextEditingController();
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {
        if (state is AddOrderSuccessState) {
          showToast(
            text: 'Add Order Success',
            state: ToastStates.success,
          );
        } else {
          showToast(
            text: 'Add Order Error',
            state: ToastStates.error,
          );
        }
      },
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Order',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            leading: IconButton(
              onPressed: () {
                pop(context);
              },
              icon: Icon(
                IconBroken.Arrow___Left_Circle,
                size: 24.sp,
                color: MainCubit.get(context).isDark
                    ? AppMainColors.orangeColor
                    : AppMainColors.whiteColor,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formState,
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.red,
                            thickness: 1.2,
                            indent: 10.0,
                            endIndent: 10.0,
                          ),
                        ),
                        Text(
                          'Enter Your Address',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.red,
                            thickness: 1.2,
                            indent: 10.0,
                            endIndent: 10.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    DefaultTextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: IconBroken.User,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    DefaultTextFormField(
                      controller: cityController,
                      keyboardType: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your city';
                        }
                        return null;
                      },
                      label: 'City',
                      prefix: IconBroken.Location,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    DefaultTextFormField(
                      controller: regionController,
                      keyboardType: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your region';
                        }
                        return null;
                      },
                      label: 'Region',
                      prefix: IconBroken.Location,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    DefaultTextFormField(
                      controller: detailsController,
                      keyboardType: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your details';
                        }
                        return null;
                      },
                      label: 'Details',
                      prefix: IconBroken.Document,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    DefaultTextFormField(
                      controller: notesController,
                      keyboardType: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your notes';
                        }
                        return null;
                      },
                      label: 'Notes',
                      prefix: IconBroken.Paper,
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            elevation: 10,
            color: Colors.white,
            child: SizedBox(
              height: 135,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Price:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '${cubit.cartModel!.data!.total} EGP',
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultMaterialButton(
                      context: context,
                      function: () {
                        if (formState.currentState!.validate()) {
                          cubit.addAddress(
                            name: nameController.text,
                            city: cityController.text,
                            region: regionController.text,
                            details: detailsController.text,
                            notes: notesController.text,
                          );
                        }
                      },
                      text: 'Confirm',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
