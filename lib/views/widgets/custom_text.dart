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
        double maxWidth = 0;
        double spaceDot = _textSize("...", style).width / 2;
        double space = _textSize(data, style).width / 2;
        if (multiLine) {
          maxWidth = constraint.maxWidth / 2 - spaceDot - 10;
        } else {
          maxWidth = constraint.maxWidth / 2  - 25;
        }
        for (var i = 0; i < data.length; i++) {
          if (maxWidth <= _textSize(data.substring(0, i), style).width) {
            indexBreak = i - 1;
            break;
          }
        }
        print("aaaa");
        for (var i = data.length; i > indexBreak; i--) {
          print(_textSize(data.substring(i), style).width);
          if (maxWidth <=
              _textSize(data.substring(i), style).width) {
            lastIndexBreak = i - 1;
            break;
          }
        }
        print("indexxx");
        print(maxWidth);
        print(data.substring(indexBreak));
        print(indexBreak);
        print(lastIndexBreak);
        if (constraint.maxWidth <= _textSize(data, style).width &&
            data.length > indexBreak) {
          String endPart = "";
          if (multiLine) {
            endPart = data.trim().substring(lastIndexBreak);
          } else {
            endPart = data.trim().substring(lastIndexBreak);
          }
          var startPart = data.trim().substring(0, indexBreak);
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
            print("else");
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
                  "... $endPart",
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
