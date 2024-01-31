import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled2/view/screens/profile.dart';
import 'package:untitled2/view/screens/signup.dart';
import 'package:untitled2/view/screens/view_todo.dart';

import '../../controller/class_functions.dart';
import '../reusable_component/todo_card.dart';
import 'add_todo_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIcon = 0;
  MyFunctions myFunctions = MyFunctions();
  bool isLoading = false;
  int dateTime = DateTime.now().hour;

  List<Select> selected = [];

  final Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection("Todo").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: const Text(
            "Today's Schedule",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
          ),
        ),
        drawer: Drawer(
            child: Consumer<MyFunctions>(builder: (context, model, widget) {
          return ListView(children: [
            DrawerHeader(
                child: model.myFile != null
                    ? Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Image.file(
                          File(model.myFile!.path),
                          height: 40,
                          width: 40,
                          fit: BoxFit.contain,
                        ),
                      )
                    : Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Image.asset(
                          "assets/person.png",
                          height: 40,
                          width: 40,
                          fit: BoxFit.contain,
                        ),
                      )),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const ProfileImage()),
                    (route) => false);
              },
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.1),
                      borderRadius: BorderRadius.circular(20)),
                  child: const ListTile(
                    leading: Text(
                      "Person",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.person),
                  )),
            ),
            InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const SignUpScreen()),
                    (route) => false);
              },
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.1),
                      borderRadius: BorderRadius.circular(20)),
                  child: const ListTile(
                    leading: Text(
                      "Exit",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.exit_to_app),
                  )),
            ),
          ]);
        })),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIcon,
            elevation: 0,
            onTap: (val) {
              setState(() {
                currentIcon = val;
              });
              print("####################### current Icon $currentIcon");
            },
            backgroundColor: Colors.black,
            items: [
              BottomNavigationBarItem(
                  icon: InkWell(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (_) => const AddTodoScreen()),
                          (route) => false);
                    },
                    child: Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                              colors: [Colors.purple, Colors.indigoAccent])),
                      child: const Icon(Icons.add),
                    ),
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: InkWell(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (_) => const ProfileImage()),
                          (route) => false);
                    },
                    child: Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                              colors: [Colors.purple, Colors.indigoAccent])),
                      child: const Icon(Icons.person),
                    ),
                  ),
                  label: ""),
            ]),
        body: StreamBuilder(
            stream: stream,
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    IconData iconData;
                    Color iconColor;
                    Color iconBGColor;
                    String result = snapshot.data!.docs[index]['category'];
                    switch (result) {
                      case "Food":
                        iconBGColor = Colors.white;
                        iconColor = Colors.red;
                        iconData = Icons.restaurant;
                        break;
                      case "Work":
                        iconBGColor = Colors.white;
                        iconColor = Colors.red;
                        iconData = Icons.run_circle_outlined;
                        break;
                      case "WorkOut":
                        iconBGColor = Colors.white;
                        iconColor = Colors.red;
                        iconData = Icons.alarm;
                        break;
                      case "Run":
                        iconBGColor = Colors.white;
                        iconColor = Colors.red;
                        iconData = Icons.category;
                        break;
                      case "Design":
                        iconBGColor = Colors.white;
                        iconColor = Colors.red;
                        iconData = Icons.design_services;
                        break;
                      default:
                        iconBGColor = Colors.white;
                        iconColor = Colors.red;
                        iconData = Icons.run_circle_outlined;
                    }
                    selected.add(Select(
                      checkVal: false,
                      id: snapshot.data!.docs[index].id,
                    ));
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: todoCard(
                          onChanged: (val) {
                            changeCheckState(index);
                          },
                          onLongPress: () {
                            if (context.mounted) {
                              AwesomeDialog(
                                  context: context,
                                  title: "Choose What You Need",
                                  btnOkText: "Edit",
                                  btnOkOnPress: () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (_) => ViewTodo(
                                                  docId: snapshot
                                                      .data!.docs[index].id,
                                                  category: snapshot.data!
                                                      .docs[index]['category'],
                                                  description:
                                                      snapshot.data!.docs[index]
                                                          ["description"],
                                                  taskTitle: snapshot.data!
                                                      .docs[index]['taskTitle'],
                                                  taskType: snapshot.data!
                                                      .docs[index]["taskType"],
                                                )),
                                        (route) => false);
                                  },
                                  btnCancelText: "Delete",
                                  btnCancelOnPress: () async {
                                    var instance = FirebaseFirestore.instance
                                        .collection("Todo");
                                    for (int i = 0; i < selected.length; i++) {
                                      if (selected[index].id ==
                                              snapshot.data!.docs[index].id &&
                                          selected[index].checkVal == true) {
                                        instance
                                            .doc(snapshot.data!.docs[index].id)
                                            .delete();
                                        selected.remove(selected[index]);
                                        selected.length--;
                                        selected[index].checkVal = false;
                                        print(
                                            "###########@@@@@@@@@@@@@@@@@ selected.length=${selected.length}");
                                      }
                                    }
                                  }).show();
                            }
                          },
                          context: context,
                          iconBGColor: iconBGColor,
                          check: selected[index].checkVal,
                          iconData: iconData,
                          iconColor: iconColor,
                          time: "$dateTime",
                          title: snapshot.data!.docs[index]['taskTitle']),
                    );
                  });
            }));
  }

  // bool checked=false;

  changeCheckState(index) {
    print("##############  selected.length = ${selected.length}");
    setState(() {
      // checked=!checked;
      selected[index].checkVal = !selected[index].checkVal;
    });
  }
}

class Select {
  String? id;
  bool checkVal;

  Select({
    this.id,
    this.checkVal = false,
  });
}
