import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled2/view/screens/view_todo.dart';

import '../reusable_component/todo_card.dart';

class SharedScreen extends StatefulWidget {
  const SharedScreen({super.key});

  @override
  State<SharedScreen> createState() => _SharedScreenState();
}

class _SharedScreenState extends State<SharedScreen> {
  List<Select> selected = [];

  bool myVal = false;
  Select select = Select();

  changeState(index) {
    myVal = select.checkVal;
    setState(() {
      selected[index].checkVal = !selected[index].checkVal;
      saveValue(index);
    });
  }

  saveValue(index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("checked", selected[index].checkVal);
    getValue();
  }

  getValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    myVal = preferences.getBool(
      "checked",
    )!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValue();
  }

  final Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection("Todo").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
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
                        checkVal: false, id: snapshot.data!.docs[index].id));

                    print("#################### ${selected.length}");
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: todoCard(
                          onChanged: (val) {
                            changeState(index);
                            print("check button id = ${selected[index].id}");
                            print("card id = ${snapshot.data!.docs[index].id}");
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
                          time: '10 Am',
                          title: snapshot.data!.docs[index]['taskTitle']),
                    );
                  });
            }));
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
