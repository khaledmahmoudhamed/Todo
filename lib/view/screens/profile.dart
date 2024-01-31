import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../controller/class_functions.dart';
import '../reusable_component/button_content.dart';
import 'home_page.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({
    super.key,
  });

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const HomePage()),
                  (route) => false);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SafeArea(child: Consumer(builder: (context, model, widget) {
        return Consumer<MyFunctions>(builder: (context, model, widget) {
          return Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                model.myFile != null
                    ? ClipOval(
                        child: Image.file(
                          File(model
                              .myFile!.path), // Replace with your image URL
                          width: 150, // Adjust width as needed
                          height: 150, // Adjust height as needed
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipOval(
                        child: Image.asset(
                          "assets/person.png", // Replace with your image URL
                          width: 150, // Adjust width as needed
                          height: 150, // Adjust height as needed
                          fit: BoxFit.cover,
                        ),
                      ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buttonContent(
                        width: MediaQuery.of(context).size.width / 2.7,
                        context: context,
                        color: Colors.grey,
                        onTap: () {
                          model.pickImage(ImageSource.gallery);
                        },
                        text: const Text("From Gallery")),
                    buttonContent(
                        context: context,
                        width: MediaQuery.of(context).size.width / 2.7,
                        color: Colors.grey,
                        onTap: () {
                          model.pickImage(ImageSource.camera);
                        },
                        text: const Text("From Camera")),
                  ],
                ),
              ],
            ),
          );
        });
      })),
    );
  }
}
