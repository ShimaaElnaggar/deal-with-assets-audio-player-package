
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final FontWeight? fontWeight;
  const CustomText({
    super.key,
    required this.title,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
    title,
      style:  TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight:fontWeight ,
      ),
    );
  }
}