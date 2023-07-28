import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_marko/model/login/login_model.dart';
import 'package:super_marko/shared/components/buttons.dart';
import 'package:super_marko/shared/components/text_form_field.dart';
import 'package:super_marko/shared/cubit/cubit.dart';
import 'package:super_marko/shared/styles/colors.dart';
import 'package:super_marko/shared/styles/icon_broken.dart';

void bottomSheetComplaints(
    {required BuildContext context, required MainCubit cubit}) {
  showModalBottomSheet(
    backgroundColor: cubit.isDark
        ? AppMainColors.whiteColor
        : AppColorsDark.primaryDarkColor,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ).r,
    ),
    context: context,
    builder: (context) {
      return const ShowModalBottomSheet();
    },
  );
}

class ShowModalBottomSheet extends StatelessWidget {
  const ShowModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    TextEditingController messageController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    MainCubit cubit = MainCubit.get(context);
    LoginModel? model = MainCubit.get(context).userData;
    emailController.text = model!.data!.email!;
    phoneController.text = model.data!.phone!;
    nameController.text = model.data!.name!;
    return DraggableScrollableSheet(
        initialChildSize: 0.35.sp,
        minChildSize: 0.35.spMin,
        maxChildSize: 0.5.spMax,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Container(
              decoration: BoxDecoration(
                color: cubit.isDark
                    ? AppMainColors.whiteColor
                    : AppColorsDark.primaryDarkColor,
                borderRadius:
                    BorderRadius.vertical(top: const Radius.circular(20).r),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10).r,
              margin: const EdgeInsets.symmetric(horizontal: 10).r,
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -20.h,
                    child: Container(
                      width: 50.w,
                      height: 6.h,
                      margin: const EdgeInsets.only(bottom: 20).r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.5).r,
                        color: AppMainColors.mainColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        Text(
                          'Add Complaints',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25, bottom: 25).r,
                          child: Column(
                            children: [
                              DefaultTextFormField(
                                maxLines: 6,
                                minLines: 3,
                                controller: messageController,
                                keyboardType: TextInputType.text,
                                validate: (String? value) {
                                  if (value!.trim().isEmpty) {
                                    return 'Please enter your complaints';
                                  }
                                  return null;
                                },
                                label: 'Complaints',
                                prefix: IconBroken.Message,
                              ),
                              SizedBox(height: 20.h),
                              defaultMaterialButton(
                                context: context,
                                text: 'Submit',
                                textColor: AppMainColors.whiteColor,
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.addComplaints(
                                      message: messageController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
