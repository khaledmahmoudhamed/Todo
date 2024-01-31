import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';

import '../../controller/class_functions.dart';
import '../reusable_component/button_content.dart';
import '../reusable_component/otp_component.dart';
import '../reusable_component/textFormFailed.dart';
import 'home_page.dart';
import 'login.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  var phoneController = TextEditingController();
  var otpController = OtpFieldController();
  var formKay = GlobalKey<FormState>();
  MyFunctions myFunctions = MyFunctions();
  int start = 30;
  String buttonName = "Send";
  bool changed = false;
  String verificationId = "";
  String sms = "";
  void startTime() {
    const oneSec = Duration(seconds: 1);
    Timer timer = Timer.periodic(
      oneSec,
      (timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  void setData(String verificationID) {
    setState(() {
      verificationId = verificationID;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up "),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const SignInScreen()),
                  (route) => false);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Form(
        key: formKay,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
            child: Column(
              children: [
                textFormField(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                    child: Text("+20 "),
                  ),
                  controller: phoneController,
                  textInputType: TextInputType.phone,
                  validator: (val) {
                    if (phoneController.text.isEmpty) {
                      return "field must not be empty";
                    } else if (phoneController.text.length < 10 ||
                        phoneController.text.length > 10) {
                      return "phone number consists of 11 digits";
                    } else {
                      return null;
                    }
                  },
                  isClosed: false,
                  hint: "enter phone number ",
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 18),
                    child: InkWell(
                      onTap: () {
                        if (formKay.currentState!.validate()) {
                          startTime();
                          setState(() {
                            changed = true;
                          });
                          print("#####################$otpController");
                          myFunctions.phoneAuthData(
                              phoneNumber: "+20${phoneController.text}",
                              context: context,
                              verificationCompleted:
                                  (PhoneAuthCredential credential) async {
                                myFunctions.showSnackBar(
                                    "verification completed", context);
                                await myFunctions.auth
                                    .signInWithCredential(credential);
                              },
                              verificationFailed: (FirebaseAuthException e) {
                                if (e.code == 'invalid-phone-number') {
                                  myFunctions.showSnackBar(
                                      'The provided phone number is not valid.',
                                      context);
                                }
                              },
                              // codeSent: (String v, int? y) {
                              //   myFunctions.showSnackBar(
                              //       "code sent to your phone number", context);
                              //   setState(() {
                              //     verificationId = v;
                              //   });
                              // },
                              codeSent: (String verificationId,
                                  int? resendToken) async {
                                // Update the UI - wait for the user to enter the SMS code
                                String smsCode = 'xxxx';

                                // Create a PhoneAuthCredential with the code
                                PhoneAuthCredential credential =
                                    PhoneAuthProvider.credential(
                                        verificationId: verificationId,
                                        smsCode: smsCode);

                                // Sign the user in (or link) with the credential
                                await myFunctions.auth
                                    .signInWithCredential(credential);
                              },
                              codeAutoRetrievalTimeout: (String out) {
                                myFunctions.showSnackBar("Time out", context);
                              });
                          if (start == 0 && buttonName == "ReSend") {
                            start = 30;
                            startTime();
                          }
                        }
                      },
                      child: changed == false
                          ? Text(
                              buttonName = "Send",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )
                          : start != 0
                              ? Text(
                                  buttonName = "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )
                              : Text(
                                  buttonName = "ReSend",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                    const Text(
                      " Enter 6 digits Otp",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                otpComponent(context, otpController),
                const SizedBox(
                  height: 50,
                ),
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "Send Otp Again in",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: " 00:$start ",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const TextSpan(
                      text: "sec",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ])),
                const SizedBox(
                  height: 30,
                ),
                buttonContent(
                    context: context,
                    width: MediaQuery.of(context).size.width - 60,
                    gradient: const LinearGradient(colors: [
                      Color(0xfffd746c),
                      Color(0xffff9068),
                      Color(0xfffd746c)
                    ]),
                    onTap: () {
                      myFunctions.verifyOtp(verificationId, sms, context);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const HomePage()),
                          (route) => false);
                    },
                    text: const Text("Let's Go"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
