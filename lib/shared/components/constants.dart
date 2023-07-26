import 'package:flutter/material.dart';

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
}

String? token = '';

String uId = '';

int cartLength = 0;

String? base64Image;
