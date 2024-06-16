import 'package:flutter/material.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';

class CustomDrawerOption extends StatelessWidget {
  final Color? textColor;
  final bool isActive;
  final ImageProvider icon;
  final String text;
  final Function()? onTap;
  const CustomDrawerOption(
      {super.key,
      this.textColor,
      this.isActive = false,
      this.onTap,
      required this.icon,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
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
                        : textColor ?? context.colors.whiteCr.withOpacity(0.5)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
