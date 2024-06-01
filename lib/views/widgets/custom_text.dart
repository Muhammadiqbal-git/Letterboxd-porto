import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String data;
  final TextStyle style;
  final TextAlign? textAlign;
  const CustomText(
    this.data, {
    Key? key,
    this.textAlign,
    this.style = const TextStyle(),
  }) : super(key: key);
  final textDirection = TextDirection.ltr;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        var indexBreak = 0;
        for (var i = 0; i < data.length; i++) {
          if (constraint.maxWidth - 55 <=
              _textSize(data.substring(0, i), style).width) {
            indexBreak = i;
            break;
          }
        }
        if (constraint.maxWidth <= _textSize(data, style).width &&
            data.length > indexBreak) {
          var endPart = data.trim().substring(data.length - indexBreak);
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
