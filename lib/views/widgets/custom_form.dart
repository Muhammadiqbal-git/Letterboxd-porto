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
  const CustomForm(
      {super.key,
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
      this.endLogo});
  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  bool obscured = false;
  bool multiLine = false;
  @override
  void initState() {
    obscured = widget.isObsecure ?? false;
    multiLine = widget.isMultiLine ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 48,
      width: widget.width ?? double.maxFinite,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: widget.backgroundColor ??
              const Color(0xffC4C4C4).withOpacity(0.35),
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
              scrollPhysics: const ClampingScrollPhysics(),
              cursorColor: context.colors.secondaryCr,
              textAlignVertical:
                  widget.textAlignVertical ?? TextAlignVertical.center,
              expands: multiLine ? true : false,
              maxLines: multiLine ? null : 1,
              minLines: null,
              enabled: widget.enabled,
              onChanged: (value) {
                if (value.length <= 1) {
                  setState(() {});
                }
                widget.onChanged?.call(value);
              },
              onEditingComplete: widget.onEdittingComplete,
              focusNode: widget.focusNode,
              controller: widget.textEditingController,
              obscureText: obscured,
              textInputAction: widget.textInputAction,
              style: widget.inputStyle ?? normalText,
              textAlign: widget.textAlign ?? TextAlign.start,
              decoration: InputDecoration(
                  contentPadding: widget.contentPadding ??
                      const EdgeInsets.symmetric(vertical: 10),
                  hintText: widget.hintText,
                  hintStyle: widget.hintStyle ??
                      normalText.copyWith(fontSize: 13, color: Colors.black45),
                  isCollapsed: true,
                  border: InputBorder.none,
                  suffixIcon: _endLogo(),
                  suffixIconConstraints:
                      const BoxConstraints(maxHeight: 24, maxWidth: 24)),
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
        ],
      ),
    );
  }

  Widget? _endLogo() {
    if (widget.endLogo == null) {
      return null;
    } else if (widget.textEditingController.text.isEmpty) {
      return InkWell(
          onTap: () {
            setState(() {});
          },
          child: widget.endLogo);
    } else if (widget.textEditingController.text.isNotEmpty) {
      return InkWell(
        onTap: () {
          widget.textEditingController.clear();
          setState(() {});
        },
        child: Image.asset(
          "assets/icons/x_mark.png",
          height: 18,
          color: context.colors.secondaryCr,
        ),
      );
    } else {
      return null;
    }
  }
}
