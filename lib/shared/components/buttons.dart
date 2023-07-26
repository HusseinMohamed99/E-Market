import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_marko/shared/styles/colors.dart';

Widget defaultMaterialButton({
  required Function function,
  required String text,
  double? width,
  double? height,
  double? radius,
  bool isUpperCase = true,
  Function? onTap,
  required BuildContext context,
  Color? color,
  Color? textColor,
}) {
  return Container(
    width: width ?? double.infinity,
    height: height ?? 48.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        radius ?? 3,
      ).r,
      color: color ?? AppMainColors.mainColor,
    ),
    child: MaterialButton(
      onPressed: () {
        function();
      },
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: textColor),
      ),
    ),
  );
}

Widget defaultTextButton({
  required Function function,
  required String text,
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  required BuildContext context,
}) {
  return TextButton(
    onPressed: () {
      function();
    },
    child: Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight),
    ),
  );
}
