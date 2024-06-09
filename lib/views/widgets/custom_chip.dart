import 'package:flutter/material.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';

class CustomChip extends StatelessWidget {
  final String text;
  final AssetImage iconAsset;
  final Color? iconColor;
  final TextStyle? textStyle;
  final EdgeInsets? margin;
  const CustomChip({super.key, required this.text, required this.iconAsset, this.iconColor, this.textStyle, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      margin: margin,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: normalText.copyWith(
                fontSize: 10, color: context.colors.secondaryCr),
          ),
          const SizedBox(
            width: 4,
          ),
          ImageIcon(
            iconAsset,
            size: 10,
            color: context.colors.accentCr,
          )
        ],
      ),
    );
  }
}