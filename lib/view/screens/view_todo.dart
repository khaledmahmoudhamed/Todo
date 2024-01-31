import 'package:flutter/material.dart';

import '../../controller/class_functions.dart';
import '../reusable_component/button_content.dart';
import '../reusable_component/newButtonContent.dart';
import '../reusable_component/text.dart';
import '../reusable_component/textFormFailed.dart';
import 'home_page.dart';

class ViewTodo extends StatefulWidget {
  const ViewTodo(
      {super.key,
      required this.docId,
      required this.taskType,
      required this.description,
      required this.category,
      required this.taskTitle});

  final String docId;
  final String taskTitle;
  final String taskType;
  final String category;
  final String description;
  @override
  State<ViewTodo> createState() => _ViewTodoState();
}

class _ViewTodoState extends State<ViewTodo> {
  var taskController = TextEditingController();
  var descController = TextEditingController();
  String taskType = "";
  String categoryType = "";
  var formKey = GlobalKey<FormState>();
  MyFunctions myFunctions = MyFunctions();

  bool edit = false;

  @override
  void initState() {
    taskController.text = widget.taskTitle;
    taskType = widget.taskType;
    categoryType = widget.category;
    descController.text = widget.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFF1d1e26), Color(0xFF252041)])),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (_) => const HomePage()),
                              (route) => false);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 30,
                        ),
                        color: Colors.white,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            edit = !edit;
                          });
                          // Navigator.of(context).pushAndRemoveUntil(
                          //     MaterialPageRoute(
                          //         builder: (_) => const HomePage()),
                          //     (route) => false);
                        },
                        icon: const Icon(
                          Icons.edit,
                          size: 30,
                        ),
                        color: edit == true ? Colors.green : Colors.white,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25,
                    right: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reusableText(
                          text: edit == true
                              ? "Editing your Todo"
                              : "View your Todo",
                          fontSize: 23,
                          color: Colors.white),
                      const SizedBox(
                        height: 15,
                      ),
                      reusableText(
                          text: "Task Title",
                          fontSize: 14,
                          color: Colors.white),
                      const SizedBox(
                        height: 7,
                      ),
                      textFormField(
                          enabled: edit,
                          fillColor: const Color(0xFF2a2e3d),
                          controller: taskController,
                          textInputType: TextInputType.text,
                          validator: (val) {
                            if (taskController.text.isEmpty) {
                              return 'this field must not be empty';
                            } else {
                              return null;
                            }
                          },
                          isClosed: false,
                          hint: "Task Title"),
                      const SizedBox(
                        height: 30,
                      ),
                      reusableText(
                          text: "Task Type", fontSize: 20, color: Colors.white),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            newButtonContent(
                              width: MediaQuery.of(context).size.width / 3,
                              onTap: edit
                                  ? () {
                                      setState(() {
                                        taskType = "Important";
                                      });
                                    }
                                  : null,
                              color: taskType == "Important"
                                  ? Colors.white
                                  : Colors.blue,
                              context: context,
                              text: reusableText(
                                  text: "Important",
                                  fontSize: 17,
                                  color: taskType == "Important"
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            newButtonContent(
                              width: MediaQuery.of(context).size.width / 3,
                              onTap: edit
                                  ? () {
                                      setState(() {
                                        taskType = "Planned";
                                      });
                                    }
                                  : null,
                              color: taskType == "Planned"
                                  ? Colors.white
                                  : Colors.cyan,
                              context: context,
                              text: reusableText(
                                  text: "Planned",
                                  fontSize: 17,
                                  color: taskType == "Planned"
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      reusableText(
                          text: "Description",
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      const SizedBox(
                        height: 8,
                      ),
                      newTextFormField(
                          enabled: edit,
                          controller: descController,
                          textInputType: TextInputType.text,
                          validator: (val) {
                            if (descController.text.isEmpty) {
                              return 'this field must not be empty';
                            } else {
                              return null;
                            }
                          },
                          maxLines: 4,
                          isClosed: false,
                          hint: "Description"),
                      const SizedBox(
                        height: 30,
                      ),
                      reusableText(
                          text: "Category", fontSize: 23, color: Colors.white),
                      const SizedBox(
                        height: 7,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                newButtonContent(
                                  onTap: edit
                                      ? () {
                                          setState(() {
                                            categoryType = "Food";
                                          });
                                        }
                                      : null,
                                  width: MediaQuery.of(context).size.width / 4,
                                  context: context,
                                  color: categoryType == "Food"
                                      ? Colors.white
                                      : Colors.deepOrange,
                                  text: reusableText(
                                      text: "Food",
                                      fontSize: 17,
                                      color: categoryType == "Food"
                                          ? Colors.black
                                          : Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                newButtonContent(
                                  onTap: edit
                                      ? () {
                                          setState(() {
                                            categoryType = "WorkOut";
                                          });
                                        }
                                      : null,
                                  width:
                                      MediaQuery.of(context).size.width / 3.6,
                                  context: context,
                                  color: categoryType == "WorkOut"
                                      ? Colors.white
                                      : Colors.orange,
                                  text: reusableText(
                                      text: "WorkOut",
                                      fontSize: 17,
                                      color: categoryType == "WorkOut"
                                          ? Colors.black
                                          : Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                newButtonContent(
                                  onTap: edit
                                      ? () {
                                          setState(() {
                                            categoryType = "Work";
                                          });
                                        }
                                      : null,
                                  width: MediaQuery.of(context).size.width / 4,
                                  context: context,
                                  color: categoryType == "Work"
                                      ? Colors.white
                                      : Colors.blueAccent,
                                  text: reusableText(
                                      text: "Work",
                                      fontSize: 17,
                                      color: categoryType == "Work"
                                          ? Colors.black
                                          : Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                newButtonContent(
                                    onTap: edit
                                        ? () {
                                            setState(() {
                                              categoryType = "Design";
                                            });
                                          }
                                        : null,
                                    context: context,
                                    color: categoryType == "Design"
                                        ? Colors.white
                                        : Colors.indigo,
                                    text: reusableText(
                                        text: "Design",
                                        fontSize: 17,
                                        color: categoryType == "Design"
                                            ? Colors.black
                                            : Colors.white,
                                        fontWeight: FontWeight.bold),
                                    width:
                                        MediaQuery.of(context).size.width / 4),
                                const SizedBox(
                                  width: 10,
                                ),
                                newButtonContent(
                                    onTap: edit
                                        ? () {
                                            setState(() {
                                              categoryType = "Run";
                                            });
                                          }
                                        : null,
                                    context: context,
                                    color: categoryType == "Run"
                                        ? Colors.white
                                        : Colors.cyan,
                                    text: reusableText(
                                        text: "Run",
                                        fontSize: 17,
                                        color: categoryType == "Run"
                                            ? Colors.black
                                            : Colors.white,
                                        fontWeight: FontWeight.bold),
                                    width:
                                        MediaQuery.of(context).size.width / 4),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      edit
                          ? buttonContent(
                              context: context,
                              width: MediaQuery.of(context).size.width - 60,
                              color: Colors.deepPurple,
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  myFunctions.updateTodo(
                                      taskController.text,
                                      taskType,
                                      categoryType,
                                      descController.text,
                                      context,
                                      widget.docId);
                                }
                              },
                              text: const Text(
                                "Update Todo",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ))
                          : const SizedBox(),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
