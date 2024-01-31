import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled2/view/screens/home_page.dart';
import 'package:untitled2/view/screens/login.dart';

import 'controller/class_functions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyD53weFsgMdleNe6ysPJWpkNFUavBmdhLY",
            appId: "1:866772947249:web:b89b16f02b69a19730a010",
            messagingSenderId: "866772947249",
            projectId: "todo-app-4e49b",
            storageBucket: "todo-app-4e49b.appspot.com",
            authDomain: "todo-app-4e49b.firebaseapp.com",
            measurementId: "G-Y5957P8ZXV"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('@@@########################### User is currently signed out!');
      } else {
        print(
            '############################ User is signed in! ${FirebaseAuth.instance.currentUser!.email}');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => MyFunctions(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData.dark(),
          home: FirebaseAuth.instance.currentUser != null &&
                  FirebaseAuth.instance.currentUser!.emailVerified
              ? const HomePage()
              : const SignInScreen()
          // home: const SharedScreen(),
          ),
    );
  }
}
