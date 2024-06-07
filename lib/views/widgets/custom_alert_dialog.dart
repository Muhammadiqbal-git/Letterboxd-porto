import 'package:flutter/material.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';

class CustomAlertDialog extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  const CustomAlertDialog({super.key, required this.text, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.colors.primaryCr,
      contentPadding: EdgeInsets.all(20),
      content: Text(
        text,
        textAlign: textAlign,
        style: semiBoldText.copyWith(fontSize: 16, color: context.colors.secondaryCr),
      ),
    );
  }
}
