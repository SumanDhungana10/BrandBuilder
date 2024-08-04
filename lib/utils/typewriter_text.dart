import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/material.dart';
import 'package:krofile_ai/utils/text_parse.dart';

class CustomAnimatedText extends StatelessWidget {
  final String text;
  final double fontSize;

  const CustomAnimatedText({
    super.key,
    required this.text,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        CustomTypewriterAnimatedText(
          text,
          fontSize:
              fontSize, // Pass the font size to CustomTypewriterAnimatedText
          textStyle: const TextStyle(
            color: Color(0xFF151515),
            fontWeight: FontWeight.w400,
            // Apply font size here
          ),
          speed: const Duration(milliseconds: 10),
        ),
      ],
      totalRepeatCount: 1,
      isRepeatingAnimation: false,
    );
  }
}

class CustomTypewriterAnimatedText extends AnimatedText {
  final List<TextSpan> textSpans;
  @override
  final TextAlign textAlign;
  final TextDirection textDirection;
  final double fontSize;

  CustomTypewriterAnimatedText(
    String text, {
    TextStyle? textStyle,
    required this.fontSize,
    this.textAlign = TextAlign.start,
    this.textDirection = TextDirection.ltr,
    Duration speed = const Duration(milliseconds: 10),
    Duration pause = const Duration(milliseconds: 1000),
    bool cursor = true,
  })  : textSpans = convertToBoldText(text, fontSize: fontSize),
        super(
          text: text,
          textStyle:
              (textStyle ?? const TextStyle()).copyWith(fontSize: fontSize),
          duration: speed * text.characters.length + pause,
        );

  late Animation<double> _typewriterText;

  @override
  void initAnimation(AnimationController controller) {
    _typewriterText = Tween<double>(begin: 0, end: text.length.toDouble())
        .animate(controller);
  }

  @override
  Widget completeText(BuildContext context) => RichText(
        text: TextSpan(children: textSpans),
        textAlign: textAlign,
        textDirection: textDirection,
      );

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    final textLen = _typewriterText.value.toInt();
    var currentTextSpans = <TextSpan>[];
    var currentTextLength = 0;

    for (var span in textSpans) {
      if (currentTextLength + span.text!.length <= textLen) {
        currentTextSpans.add(span);
        currentTextLength += span.text!.length;
      } else {
        var remainingLength = textLen - currentTextLength;
        if (remainingLength > 0) {
          currentTextSpans.add(
            TextSpan(
              text: span.text!.substring(0, remainingLength),
              style: span.style,
            ),
          );
        }
        break;
      }
    }

    return RichText(
      text: TextSpan(children: currentTextSpans),
      textAlign: textAlign,
      textDirection: textDirection,
    );
  }
}
