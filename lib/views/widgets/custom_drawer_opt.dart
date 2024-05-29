import 'package:flutter/material.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';

class CustomDrawerOption extends StatelessWidget {
  final Color? textColor;
  final bool isActive;
  final ImageProvider icon;
  final String text;
  const CustomDrawerOption(
      {super.key,
      this.textColor,
      this.isActive = false,
      required this.icon,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:
              isActive ? context.colors.secondaryCr : context.colors.primaryCr),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageIcon(
            icon,
            color: isActive ? context.colors.primaryCr : context.colors.whiteCr,
            size: 20,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            text,
            style: semiBoldText.copyWith(
              fontSize: 11,
                color: isActive
                    ? context.colors.primaryCr
                    : textColor?? context.colors.whiteCr.withOpacity(0.5)),
          )
        ],
      ),
    );
  }
}
