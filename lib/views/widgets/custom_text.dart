import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String data;
  final TextStyle style;
  final TextAlign? textAlign;
  final bool multiLine;
  const CustomText(
    this.data, {
    Key? key,
    this.textAlign,
    this.style = const TextStyle(),
    this.multiLine = true,
  }) : super(key: key);
  final textDirection = TextDirection.ltr;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        var indexBreak = 0;
        var lastIndexBreak = 0;
        print(constraint.maxWidth);
        for (var i = 0; i < data.length; i++) {
          if (constraint.maxWidth - 55 <=
              _textSize(data.substring(0, i), style).width) {
            indexBreak = i;
            break;
          }
        }
        for (var i = 0; i < data.length; i++) {
          print(_textSize(data.substring(i), style).width +
              _textSize(data.substring(0, indexBreak), style).width);
          if (constraint.maxWidth -
                  _textSize(data.substring(0, indexBreak), style).width <=
              _textSize(data.substring(i), style).width ) {
            lastIndexBreak = i;
          }
        }
        print("sasd");
        print(indexBreak);
        print(lastIndexBreak);


        if (constraint.maxWidth <= _textSize(data, style).width &&
            data.length > indexBreak) {
          String endPart = "";
          if (multiLine) {
            endPart = data.trim().substring(data.length - indexBreak);
          } else {
            endPart = data.trim().substring(data.length - lastIndexBreak);
          }
          var startPart = data.trim().substring(0, data.length - indexBreak);
          if (multiLine) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // reversed vertical direction and the child for adjusting the baseline to the bottom of column
              verticalDirection: VerticalDirection.up,
              children: [
                Text(
                  "... $endPart",
                  style: style,
                  textDirection: textDirection,
                  textAlign: textAlign,
                ),
                Text(
                  data.fixOverflowEllipsis,
                  style: style,
                  textAlign: textAlign,
                  overflow: TextOverflow.ellipsis,
                  textDirection: textDirection,
                ),
              ],
            );
          } else {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // reversed vertical direction and the child for adjusting the baseline to the bottom of column
              children: [
                Text(
                  startPart.fixOverflowEllipsis,
                  style: style,
                  textAlign: textAlign,
                  overflow: TextOverflow.ellipsis,
                  textDirection: textDirection,
                ),
                Text(
                  "...$endPart",
                  style: style,
                  textDirection: textDirection,
                  textAlign: textAlign,
                ),
              ],
            );
          }
        }
        return Text(
          "$data ",
          style: style,
          textAlign: textAlign,
          maxLines: 1,
          textDirection: textDirection,
        );
      },
    );
  }

  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: style,
      ),
      maxLines: 1,
      textDirection: textDirection,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}

extension AppStringExtension on String {
  String get fixOverflowEllipsis => Characters(this)
      .replaceAll(Characters(''), Characters('\u{200B}'))
      .toString();
}
