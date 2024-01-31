import 'package:flutter/material.dart';

Widget newButtonContent(
    {required BuildContext context,
    Color? color,
    required Widget text,
    required double width,
    void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 50,
      width: width,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      alignment: Alignment.center,
      child: text,
    ),
  );
}

// Widget chipData(Color color, String text) {
//   return Chip(
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//     label: Text(
//       text,
//       style: const TextStyle(
//           fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
//     ),
//     backgroundColor: color,
//     labelPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 3),
//   );
// }
