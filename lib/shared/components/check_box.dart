import 'package:flutter/material.dart';
import 'package:super_marko/Screens/login/cubit/cubit.dart';
import 'package:super_marko/shared/styles/colors.dart';

Widget checkBox(BuildContext context, {Color? color}) {
  var cubit = LoginCubit.get(context);
  return Checkbox.adaptive(
    side: BorderSide(
      color: color ?? AppMainColors.whiteColor,
    ),
    activeColor: AppMainColors.mainColor,
    value: cubit.isCheck,
    onChanged: (e) {
      cubit.boxCheck(e!);
    },
  );
}
