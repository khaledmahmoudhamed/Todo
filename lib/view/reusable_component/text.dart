import 'package:flutter/material.dart';

Widget reusableText(
    {required String text,
    FontWeight? fontWeight,
    required double fontSize,
    required Color color}) {
  return Text(
    text,
    style: TextStyle(fontWeight: fontWeight, fontSize: fontSize, color: color),
  );
}
