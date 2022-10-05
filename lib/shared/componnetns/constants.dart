
import 'package:flutter/material.dart';

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); //800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
}

Widget space(double wide, double high) {
  return SizedBox(
    width: wide,
    height: high,
  );
}

String? token = '';

String uId = '';

int cartLength = 0;
