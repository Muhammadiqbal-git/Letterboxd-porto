import 'package:flutter/material.dart';
import 'package:letterboxd_porto_3/style.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Function()? onTap;
  final Color? bgColor;
  final Widget child;
  final EdgeInsets? padding;
  const CustomButton(
      {super.key,
      this.width,
      this.height,
      this.onTap,
      this.bgColor,
      this.padding,
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
        height: height ?? 35,
        padding: padding,
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
