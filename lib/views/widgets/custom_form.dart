import 'package:flutter/material.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';

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
  final bool? enabled;
  final bool? isObsecure;
  final bool? isMultiLine;
  final AssetImage? logo;
  final FocusNode? focusNode;
  final TextStyle? inputStyle;
  final TextAlign? textAlign;
  final BoxBorder? borders;
  final EdgeInsets? contentPadding;
  final void Function(String)? onChanged;
  final void Function()? onEdittingComplete;
  final Widget? endLogo;
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
    this.enabled,
    this.isObsecure,
    this.isMultiLine,
    this.logo,
    this.focusNode,
    this.inputStyle,
    this.textAlign,
    this.borders,
    this.contentPadding,
    this.onChanged,
    this.onEdittingComplete,
    this.endLogo
  });
  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  bool obscured = false;
  bool multiLine = false;
  @override
  void initState() {
    obscured = widget.isObsecure ?? false;
    multiLine = widget.isMultiLine?? !obscured;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 48,
      width: widget.width ?? double.maxFinite,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: widget.backgroundColor ?? const Color(0xffC4C4C4).withOpacity(0.35),
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
              cursorColor: context.colors.secondaryCr,
              textAlignVertical: widget.textAlignVertical ?? TextAlignVertical.center,
              expands: multiLine ? true : false,
              maxLines: multiLine ? null : 1,
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
              customBorder: const CircleBorder(),
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
          if (widget.isObsecure == true) const SizedBox(width: 15),
          if (widget.endLogo != null) SizedBox(height: 24, width: 24, child: widget.endLogo,),
          if (widget.endLogo != null) const SizedBox(width: 15),

        ],
      ),
    );
  }
}
