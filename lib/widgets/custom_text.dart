
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  const CustomText({
    super.key,
    required this.title,
  });



  @override
  Widget build(BuildContext context) {
    return Text(
    title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}