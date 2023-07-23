import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: FocusNode(),
      style: const TextStyle(),
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
      autofocus: false,
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
        filled: true,
        isCollapsed: false,
        fillColor: Colors.deepOrange.withOpacity(0.2),
        hoverColor: Colors.red.withOpacity(0.2),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        labelText: label,
        labelStyle: const TextStyle(
          fontStyle: FontStyle.italic,
          color: Colors.deepOrangeAccent,
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white),
        focusColor: Colors.white,
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
