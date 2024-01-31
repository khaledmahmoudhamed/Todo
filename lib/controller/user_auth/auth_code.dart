import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../view/screens/home_page.dart';
import '../../view/screens/login.dart';

class Auth {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  signUp(
      {required String email,
      required String password,
      required BuildContext context,
      required String phone}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const SignInScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        if (context.mounted) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            // dialogBackgroundColor: Colors.red,
            animType: AnimType.rightSlide,
            title: 'Dialog Title',
            desc: 'The account already exists for that email.',
            btnOkOnPress: () {},
          ).show();
        }
      } else {
        print('Error creating user: $e');
        if (context.mounted) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            // dialogBackgroundColor: Colors.red,
            animType: AnimType.rightSlide,
            title: 'Dialog Title',
            desc: 'Error creating user: $e',
            btnOkOnPress: () {},
          ).show();
        }
      }
      // Handle other sign-up errors here
    }
  }

  void signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      firebaseAuth.currentUser!.sendEmailVerification();
      if (firebaseAuth.currentUser != null &&
          firebaseAuth.currentUser!.emailVerified) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomePage()));
      } else {
        if (context.mounted) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            // dialogBackgroundColor: Colors.red,
            animType: AnimType.rightSlide,
            // title: 'Verify Your Email',
            desc: 'You Should Verify your email',
            // btnCancelOnPress: () {},
            btnOkOnPress: () async {
              // String? encodeQueryParameters(Map<String, String> params) {
              //   return params.entries
              //       .map((MapEntry<String, String> e) =>
              //           '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
              //       .join('&');
              // }

              // ···
              // final Uri emailLaunchUri = Uri(
              //   scheme: 'mailto',
              //   path: "${firebaseAuth.currentUser!.email}",
              //   query: encodeQueryParameters(<String, String>{
              //     'subject': 'Example Subject & Symbols are allowed!',
              //     'body': "don't forget to subscribe to channel"
              //   }),
              // );
              // if (await canLaunchUrl(emailLaunchUri)) {
              //   launchUrl(emailLaunchUri);
              // } else {
              //   throw Exception("Couldn't be launch $emailLaunchUri");
              // }
            },
            // btnOkText: "Click Here"
          ).show();
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print(
            '################# No user found for that email.#####################');
        if (context.mounted) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            // dialogBackgroundColor: Colors.red,
            animType: AnimType.rightSlide,
            title: 'Dialog Title',
            desc: 'No user found for that email',
            btnOkOnPress: () {},
          ).show();
        }
      } else if (e.code == 'wrong-password') {
        print(
            '#################### Wrong password provided for that user. #####################');
        if (context.mounted) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            // dialogBackgroundColor: Colors.red,
            animType: AnimType.rightSlide,
            title: 'Dialog Title',
            desc: 'Wrong password provided for that user.',
            btnOkOnPress: () {},
          ).show();
        }
      } else {
        print('##################### Error during sign in: $e');
        if (context.mounted) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            // dialogBackgroundColor: Colors.red,
            animType: AnimType.rightSlide,
            title: 'Dialog Title',
            desc: 'there are an error in email or password',
            btnOkOnPress: () {},
          ).show();
        }
      }
      // Handle other sign-in errors here
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
