import 'package:flutter/material.dart';
import 'package:letterboxd_porto_3/style.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Function()? onTap;
  final Color? bgColor;
  final Widget child;
  const CustomButton(
      {super.key,
      this.width,
      this.height,
      this.onTap,
      this.bgColor,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: context.colors.primaryCr.withOpacity(0.4),
      splashFactory: InkRipple.splashFactory,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      onTap: onTap,
      child: Ink(
        width: width ?? double.infinity,
        height: height ?? 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: bgColor ?? context.colors.secondaryCr),
        child: Align(
          alignment: Alignment.center,
          child: child),
      ),
    );
  }
}
