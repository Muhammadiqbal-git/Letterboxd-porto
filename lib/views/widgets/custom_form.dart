import 'package:flutter/material.dart';
import 'package:letterboxd_porto_3/style.dart';

class CustomForm extends StatefulWidget {
  final TextEditingController textEditingController;
  final TextInputAction? textInputAction;
  final TextAlignVertical? textAlignVertical;
  final double? width;
  final double? height;
  final String? hintText;
  final TextStyle? hintStyle;
  final Color? backgroundColor;
  final double? borderRadius;
  final bool? isObsecure;
  final AssetImage? logo;
  final FocusNode? focusNode;
  final TextStyle? inputStyle;
  final TextAlign? textAlign;
  final BoxBorder? borders;
  final EdgeInsets? contentPadding;
  final bool? enabled;
  final void Function(String)? onChanged;
  final void Function()? onEdittingComplete;
  const CustomForm({
    super.key,
    required this.textEditingController,
    this.textAlignVertical,
    this.textInputAction,
    this.width,
    this.height,
    this.hintText,
    this.hintStyle,
    this.backgroundColor,
    this.borderRadius,
    this.isObsecure,
    this.logo,
    this.focusNode,
    this.inputStyle,
    this.textAlign,
    this.borders,
    this.contentPadding,
    this.enabled,
    this.onChanged,
    this.onEdittingComplete,
  });
  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  bool obscured = false;
  @override
  void initState() {
    obscured = widget.isObsecure ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 48,
      width: widget.width ?? double.maxFinite,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: widget.backgroundColor ?? Color(0xffC4C4C4).withOpacity(0.35),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 30),
          border: widget.borders),
      child: Row(
        children: [
          const SizedBox(width: 15),
          widget.logo != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: ImageIcon(widget.logo, color: context.colors.whiteCr),
                )
              : const SizedBox(),
          Expanded(
            child: TextFormField(
              textAlignVertical: widget.textAlignVertical ?? TextAlignVertical.center,
              expands: obscured ? false : true,
              maxLines: obscured ? 1 : null,
              minLines: null,
              enabled: widget.enabled,
              onChanged: widget.onChanged,
              onEditingComplete: widget.onEdittingComplete,
              focusNode: widget.focusNode,
              controller: widget.textEditingController,
              obscureText: obscured,
              textInputAction: widget.textInputAction,
              style: widget.inputStyle ?? normalText,
              textAlign: widget.textAlign ?? TextAlign.start,
              decoration: InputDecoration(
                  // contentPadding: EdgeInsets.zero,
                  contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(vertical: 10),
                  hintText: widget.hintText,
                  hintStyle: widget.hintStyle ??
                      normalText.copyWith(fontSize: 13, color: Colors.black45),
                  isCollapsed: true,
                  border: InputBorder.none),
            ),
          ),
          const SizedBox(width: 15),
          if (widget.isObsecure == true)
            InkWell(
              customBorder: CircleBorder(),
              onTap: () {
                obscured = !obscured;
                setState(() {});
              },
              child: obscured
                  ? Icon(
                      Icons.visibility_off_rounded,
                      color: context.colors.whiteCr.withOpacity(0.5),
                    )
                  : Icon(
                      Icons.visibility_rounded,
                      color: context.colors.whiteCr.withOpacity(0.5),
                    ),
            ),
          if (widget.isObsecure == true) const SizedBox(width: 15)
        ],
      ),
    );
  }
}
