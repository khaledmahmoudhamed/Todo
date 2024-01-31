import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget signUp(
    {required BuildContext context,
    required String imagePath,
    required double imageHeight,
    required double imageWidth,
    required String text,
    void Function()? onTap,
    Color? color}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width - 60,
    height: 60,
    child: InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colors.grey)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              imagePath,
              height: imageHeight,
              width: imageWidth,
              color: color,
            ),
            const SizedBox(
              width: 25,
            ),
            Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    ),
  );
}
