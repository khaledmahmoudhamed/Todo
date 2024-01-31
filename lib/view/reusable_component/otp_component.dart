import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';

Widget otpComponent(
  BuildContext context,
  OtpFieldController? controller,
) {
  return OTPTextField(
    length: 6,
    width: MediaQuery.of(context).size.width - 30,
    keyboardType: TextInputType.number,
    controller: controller,
    fieldWidth: 50,
    otpFieldStyle:
        OtpFieldStyle(backgroundColor: Colors.grey, borderColor: Colors.white),
    textFieldAlignment: MainAxisAlignment.spaceAround,
    onCompleted: (pin) {
      print("completed " + pin);
    },
  );
}
