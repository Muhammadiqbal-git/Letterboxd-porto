import 'package:flutter/material.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';

class CustomAlertDialog extends StatelessWidget {
  final String text;
  const CustomAlertDialog({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.colors.primaryCr,
      contentPadding: EdgeInsets.all(20),
      content: Text(
        text,
        style: semiBoldText.copyWith(fontSize: 16, color: context.colors.secondaryCr),
      ),
    );
  }
}
