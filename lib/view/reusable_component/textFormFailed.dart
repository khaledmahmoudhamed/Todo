import 'package:flutter/material.dart';

Widget textFormField({
  required TextEditingController controller,
  required TextInputType textInputType,
  required String? Function(String?)? validator,
  required bool isClosed,
  required String hint,
  Widget? prefixIcon,
  Widget? suffixIcon,
  Color? fillColor,
  bool? enabled,
  EdgeInsets? contentPadding,
}) {
  return TextFormField(
      textAlign: TextAlign.start,
      controller: controller,
      enabled: enabled,
      keyboardType: textInputType,
      validator: validator,
      obscureText: isClosed,
      decoration: InputDecoration(
          contentPadding: contentPadding,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2,
            ),
          ),
          fillColor: fillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2,
            ),
          )));
}

Widget newTextFormField({
  required TextEditingController controller,
  required TextInputType textInputType,
  required String? Function(String?)? validator,
  required bool isClosed,
  int? maxLines,
  required String hint,
  Widget? prefixIcon,
  Widget? suffixIcon,
  Color? fillColor,
  bool? enabled,
  EdgeInsets? contentPadding,
}) {
  return TextFormField(
      textAlign: TextAlign.start,
      controller: controller,
      enabled: enabled,
      maxLines: maxLines,
      keyboardType: textInputType,
      validator: validator,
      obscureText: isClosed,
      decoration: InputDecoration(
          contentPadding: contentPadding,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2,
            ),
          ),
          fillColor: fillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2,
            ),
          )));
}
