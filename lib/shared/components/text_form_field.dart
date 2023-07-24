import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_marko/shared/styles/colors.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.validate,
    required this.label,
    this.hint,
    this.onTap,
    this.onChanged,
    this.isPassword = false,
    this.isClickable = true,
    this.suffix,
    this.prefix,
    this.suffixPressed,
    this.decoration,
    this.onFieldSubmitted,
    this.focusNode,
    this.color,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?) validate;
  final String label;
  final String? hint;
  final dynamic onTap;
  final dynamic onChanged;
  final bool isPassword;
  final bool isClickable;
  final IconData? suffix;
  final IconData? prefix;
  final Function? suffixPressed;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final Function(String)? onFieldSubmitted;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.labelLarge,
      focusNode: FocusNode(),
      maxLines: 1,
      minLines: 1,
      controller: controller,
      validator: validate,
      enabled: isClickable,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefix,
          color: Colors.grey,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                  color: Colors.grey,
                ),
              )
            : null,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppMainColors.blueColor,
          ),
        ),
        labelText: label,
        labelStyle: GoogleFonts.roboto(
          color: color ?? AppMainColors.whiteColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.w400,
        ),
        hintText: hint,
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppMainColors.greyColor,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppMainColors.greyColor,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
