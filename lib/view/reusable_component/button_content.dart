import 'package:flutter/material.dart';

Widget buttonContent(
    {required BuildContext context,
    required void Function()? onTap,
    required Widget text,
    Gradient? gradient,
    required double width,
    void Function()? onLongPress,
    Color? color}) {
  return InkWell(
    onLongPress: onLongPress,
    onTap: onTap,
    child: Container(
        alignment: Alignment.center,
        width: width,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: color,
            gradient: gradient),
        child: text),
  );
}
