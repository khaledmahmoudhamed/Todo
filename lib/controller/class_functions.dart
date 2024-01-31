import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/screens/home_page.dart';

class MyFunctions extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> phoneAuthData(
      {String? phoneNumber,
      Function? setMyData,
      required BuildContext context,
      required void Function(PhoneAuthCredential) verificationCompleted,
      required void Function(FirebaseAuthException) verificationFailed,
      required void Function(String, int?) codeSent,
      required void Function(String d) codeAutoRetrievalTimeout}) async {
    // phoneVerificationCompleted(
    //     PhoneAuthCredential phoneAuthCredential, BuildContext context) {
    //   return showSnackBar("verification completed", context);
    // }

    // phoneVerificationFailed(
    //     FirebaseAuthException firebaseAuthException, BuildContext context) {
    //   showSnackBar(firebaseAuthException.toString(), context);
    // }
    //
    // phoneCodeSent(String code, BuildContext context, [int? codeNum]) {
    //   showSnackBar("code sent to your phone number", context);
    // }
    //
    // codeAutoRetrievalTimeout(String verificationId, BuildContext context) {
    //   showSnackBar("Time out", context);
    // }

    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void showSnackBar(String e, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(e),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> verifyOtp(
      String verificationId, String smsCode, BuildContext context) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      print('OTP is correct. Verification successful!');
    } catch (e) {
      showSnackBar(e.toString(), context);
      print('OTP is incorrect. Verification failed: $e');
    }
  }

  CollectionReference reference = FirebaseFirestore.instance.collection("Todo");
  Future<void> createCollection(BuildContext context, String taskTitle,
      String taskType, String description, String category) {
    return reference.add({
      "taskType": taskType,
      "taskTitle": taskTitle,
      "category": category,
      "description": description
    }).then((value) => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomePage()), (route) => false));
  }

  // List<QueryDocumentSnapshot> myData = [];
  // getData() async {
  //   QuerySnapshot querySnapshot = await reference.get();
  //   myData.addAll(querySnapshot.docs);
  // }

  updateTodo(
    String title,
    String type,
    String category,
    String description,
    BuildContext context,
    String docId,
  ) async {
    await reference.doc(docId).update({
      "taskTitle": title,
      "taskType": type,
      "category": category,
      "description": description
    }).then((value) => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomePage()), (route) => false));
  }

  List<Select> selected = [];

  setCheckValue(bool checked) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("checkValue", checked);
    print("##################### $checked");
  }

  getCheckValue() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.getBool("checkValue");
  }

  final ImagePicker picker = ImagePicker();

  File? myFile;

  // getImageFromCamera() async {
  //   final pickedImage = await picker.pickImage(source: ImageSource.camera);
  //   myFile = File(pickedImage!.path);
  //   saveData(pickedImage.path.toString());
  // }
  //
  // getImageFromGallery() async {
  //   final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  //   myFile = File(pickedImage!.path);
  //   saveData(pickedImage.path.toString());
  // }
  SharedPreferences? prefs;
  pickImage(ImageSource source) async {
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      myFile = File(pickedImage.path);
      await prefs!.setString("imgPath", pickedImage.path);
      notifyListeners();
    }
  }

  // saveData(String val) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //
  //   sharedPreferences.setString("path", val);
  //   print("@############################  Data Saved Successfully");
  //   getData();
  // }

  getData() async {
    prefs = await SharedPreferences.getInstance();
    final imagePath = prefs!.getString("imgPath");
    if (imagePath != null) {
      myFile = File(imagePath);
      notifyListeners();
    }
  }

  MyFunctions() {
    getData();
  }
}
