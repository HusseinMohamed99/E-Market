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
              padding: const EdgeInsets.all(15).r,
              child: Form(
                key: formState,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: AppMainColors.dividerColor,
                            thickness: 1.2,
                            indent: 10.0,
                            endIndent: 10.0,
                          ),
                        ),
                        Text(
                          'Enter Your Address',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Expanded(
                          child: Divider(
                            color: AppMainColors.dividerColor,
                            thickness: 1.2,
                            indent: 10.0,
                            endIndent: 10.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
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
                    SizedBox(height: 30.h),
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
                    SizedBox(height: 30.h),
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
                    SizedBox(height: 30.h),
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
                    SizedBox(height: 30.h),
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
            color: cubit.isDark
                ? AppMainColors.greyDarkColor
                : AppColorsDark.primaryDarkColor,
            child: SizedBox(
              height: 110.h,
              child: Padding(
                padding: const EdgeInsets.all(15).r,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Price:',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          '${cubit.cartModel!.data!.total} EGP',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
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
