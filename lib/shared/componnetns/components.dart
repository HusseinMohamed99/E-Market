// ignore_for_file: constant_identifier_names, prefer_const_constructors, non_constant_identifier_names, avoid_types_as_parameter_names, body_might_complete_normally_nullable, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mego_market/Screens/login/login_screen.dart';
import 'package:mego_market/network/cache_helper.dart';

Widget defaultTextFormField({
  FocusNode? focusNode,
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String? Function(String?) validate,
  required String label,
  String? hint,
  onTap,
  onChanged,
  Function(String)? onFieldSubmitted,
  bool isPassword = false,
  bool isClickable = true,
  InputDecoration? decoration,
  IconData? suffix,
  IconData? prefix,
  Function? suffixPressed,
}) =>
    TextFormField(
      focusNode: FocusNode(),
      style: TextStyle(),
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
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        labelText: label,
        labelStyle: TextStyle(
          fontStyle: FontStyle.italic,
          color: Colors.deepOrangeAccent,
        ),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white),
        focusColor: Colors.white,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );

Widget defaultMaterialButton({
  required Function function,
  required String text,
  double width = 200,
  double height = 40.0,
  double radius = 3.0,
  bool isUpperCase = true,
  Function? onTap,
}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: Colors.deepOrangeAccent,
        //  color: background,
      ),
    );

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(text),
    );

Widget myDivider() => Container(
  width: double.infinity,
  height: 1.0,
  color: Colors.grey[300],
);

void ShowToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 10,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum  كذا اختيار من حاجة

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;

    case ToastStates.ERROR:
      color = Colors.red;
      break;

    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void navigateTo(context, Widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => Widget,
  ),
);

void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ), (route) {
  return false;
});

void logOut(context) {
  CacheHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      navigateAndFinish(context, LoginScreen());
    }
  });
}