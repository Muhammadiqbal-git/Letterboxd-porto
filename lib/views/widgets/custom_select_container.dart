import 'package:flutter/material.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';

class CustomSelectContainer extends StatefulWidget {
  final String text;
  final bool? selected;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? bgColor;
  final Color? selectedColor;
  final TextStyle? style;
  final TextStyle? selectedStyle;
  final Function(bool selected)? onTap;
  const CustomSelectContainer({
    super.key,
    required this.text,
    this.selected,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.bgColor,
    this.selectedColor,
    this.style,
    this.selectedStyle,
    this.onTap,
  });

  @override
  State<CustomSelectContainer> createState() => _CustomSelectContainerState();
}

class _CustomSelectContainerState extends State<CustomSelectContainer> {
  late bool selected;
  late Color bgsColor;
  late Color selectedBgColor;
  late TextStyle textStyle;
  late TextStyle selectedTextStyle;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    bgsColor = widget.bgColor ?? Colors.transparent;
    selectedBgColor = widget.selectedColor ?? context.colors.accentCr;
    textStyle = widget.style ??
        normalText.copyWith(fontSize: 10, color: context.colors.secondaryCr);
    selectedTextStyle = widget.selectedStyle ??
        normalText.copyWith(fontSize: 10, color: context.colors.whiteCr);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    selected = widget.selected ?? false;
    // print("built ${widget.text}");
    return Padding(
      padding: widget.margin ?? const EdgeInsets.symmetric(horizontal: 2),
      child: InkWell(
        onTap: () {
            widget.onTap?.call(selected);
        },
        child: Ink(
          width: widget.width,
          height: widget.height ?? 22,
          padding: widget.padding ?? const EdgeInsets.all(3),
          decoration: BoxDecoration(
              color: selected ? selectedBgColor : bgsColor,
              borderRadius: BorderRadius.circular(7)),
          child: Text(
            widget.text,
            style: selected ? selectedTextStyle : textStyle,
          ),
        ),
      ),
    );
  }
}
