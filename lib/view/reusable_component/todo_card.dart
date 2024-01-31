import 'package:flutter/material.dart';

Widget todoCard(
    {required BuildContext context,
    required String title,
    required String time,
    required IconData iconData,
    required bool check,
    required Color iconColor,
    void Function()? onLongPress,
    void Function()? onTap,
    required void Function(bool?)? onChanged,
    Color? iconBGColor}) {
  return Row(
    children: [
      Theme(
          data: ThemeData(
              primarySwatch: Colors.blue,
              unselectedWidgetColor: const Color(0xFF5e616a)),
          child: Transform.scale(
            scale: 1.5,
            child: Checkbox(
              value: check,
              onChanged: onChanged,
              activeColor: const Color(0xFF6cf8a9),
              checkColor: const Color(0xFF0e3e26),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
          )),
      Expanded(
        child: SizedBox(
          height: 75,
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            child: Card(
              color: const Color(0xFF2a2e3d),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        color: iconBGColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      iconData,
                      color: iconColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    time,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  const SizedBox(
                    width: 6,
                  )
                ],
              ),
            ),
          ),
        ),
      )
    ],
  );
}
