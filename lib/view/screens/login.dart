import 'package:flutter/material.dart';
import 'package:untitled2/view/screens/phone_auth_page.dart';

import '../../controller/user_auth/auth_code.dart';
import '../reusable_component/button_content.dart';
import '../reusable_component/sign_up_with.dart';
import '../reusable_component/textFormFailed.dart';
import 'home_page.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Auth auth = Auth();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isHidden = true;

  bool isValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch("tony@starkindustries.com");
  bool hidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Center(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width - 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Sign In",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              signUp(
                  onTap: () async {
                    await auth.signInWithGoogle().then((value) =>
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => const HomePage()),
                            (route) => false));
                  },
                  context: context,
                  imageHeight: 25,
                  text: "Continue With Google",
                  imagePath: "assets/google.svg",
                  imageWidth: 25),
              const SizedBox(
                height: 15,
              ),
              signUp(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (_) => const PhoneAuthPage()),
                        (route) => false);
                  },
                  context: context,
                  imagePath: "assets/phone.svg",
                  imageWidth: 25,
                  imageHeight: 25,
                  text: "Continue With Phone",
                  color: Colors.green),
              const SizedBox(
                height: 20,
              ),
              const Text("Or"),
              const SizedBox(
                height: 20,
              ),
              // textFormField(
              //     controller: emailController,
              //     textInputType: TextInputType.emailAddress,

              //     suffixIcon: const Icon(Icons.email),
              //     hint: "Email",
              //     isClosed: false),
              textFormField(
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  validator: (val) {
                    if (emailController.text.isEmpty) {
                      return "This Email Is Not Valid";
                    } else {
                      return null;
                    }
                  },
                  isClosed: false,
                  suffixIcon: const Icon(Icons.email),
                  hint: "Email"),
              const SizedBox(
                height: 20,
              ),
              textFormField(
                  controller: passwordController,
                  textInputType: TextInputType.visiblePassword,
                  validator: (val) {
                    if (passwordController.text.isEmpty ||
                        passwordController.text.length < 8) {
                      return "Password Must Be More Than 8 Letters";
                    } else {
                      return null;
                    }
                  },
                  hint: "Password",
                  suffixIcon: isHidden == false
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              isHidden = !isHidden;
                            });
                          },
                          icon: const Icon(Icons.remove_red_eye_outlined))
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              isHidden = !isHidden;
                            });
                          },
                          icon: const Icon(Icons.remove_red_eye)),
                  isClosed: isHidden),

              const SizedBox(
                height: 30,
              ),
              buttonContent(
                width: MediaQuery.of(context).size.width - 60,
                context: context,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    auth.signIn(
                        context: context,
                        email: emailController.text,
                        password: passwordController.text);
                  }
                },
                gradient: const LinearGradient(colors: [
                  Color(0xfffd746c),
                  Color(0xffff9068),
                  Color(0xfffd746c)
                ]),
                text: const Text("Sign In",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "create an account",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (_) => const SignInScreen()));
                      },
                      child: const Text(
                        "SignUp",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                            decoration: TextDecoration.underline),
                      ))
                ],
              )
            ],
          ),
        )),
      ),
    ));
  }
}
