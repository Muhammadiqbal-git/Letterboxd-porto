import 'package:flutter/material.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';

class CustomLoadingDialog extends StatelessWidget {
  const CustomLoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: context.colors.secondaryCr,),
    );
  }
}