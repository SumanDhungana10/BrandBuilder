// import 'package:animated_text_kit/animated_text_kit.dart';

// import 'package:flutter/material.dart';
// import 'package:krofile_ai/utils/text_parse.dart';

// class CustomAnimatedText extends StatelessWidget {
//   final String text;
//   final double fontSize;
//   final Color textColor;

//   const CustomAnimatedText({
//     super.key,
//     required this.text,
//     required this.fontSize,
//     required this.textColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedTextKit(
//       animatedTexts: [
//         CustomTypewriterAnimatedText(
//           text,
//           fontSize:
//               fontSize,
//           textColor: textColor,
//           textStyle: const TextStyle(
//             fontWeight: FontWeight.w400,
//           ),
//           speed: const Duration(milliseconds: 10),
//         ),
//       ],
//       totalRepeatCount: 1,
//       isRepeatingAnimation: false,
//     );
//   }
// }

// class CustomTypewriterAnimatedText extends AnimatedText {
//   final List<TextSpan> textSpans;
//   @override
//   final TextAlign textAlign;
//   final TextDirection textDirection;
//   final double fontSize;
//   final Color textColor;

//   CustomTypewriterAnimatedText(
//     String text, {
//     TextStyle? textStyle,
//     required this.fontSize,
//     required this.textColor,
//     this.textAlign = TextAlign.start,
//     this.textDirection = TextDirection.ltr,
//     Duration speed = const Duration(milliseconds: 10),
//     Duration pause = const Duration(milliseconds: 1000),
//     bool cursor = true,
//   })  : textSpans =
//             convertToBoldText(text, fontSize: fontSize, color: textColor),
//         super(
//           text: text,
//           textStyle: (textStyle ?? const TextStyle())
//               .copyWith(fontSize: fontSize, color: textColor),
//           duration: speed * text.characters.length + pause,
//         );

//   late Animation<double> _typewriterText;

//   @override
//   void initAnimation(AnimationController controller) {
//     _typewriterText = Tween<double>(begin: 0, end: text.length.toDouble())
//         .animate(controller);
//   }

//   @override
//   Widget completeText(BuildContext context) => RichText(
//         text: TextSpan(children: textSpans),
//         textAlign: textAlign,
//         textDirection: textDirection,
//       );

//   @override
//   Widget animatedBuilder(BuildContext context, Widget? child) {
//     final textLen = _typewriterText.value.toInt();
//     var currentTextSpans = <TextSpan>[];
//     var currentTextLength = 0;

//     for (var span in textSpans) {
//       if (currentTextLength + span.text!.length <= textLen) {
//         currentTextSpans.add(span);
//         currentTextLength += span.text!.length;
//       } else {
//         var remainingLength = textLen - currentTextLength;
//         if (remainingLength > 0) {
//           currentTextSpans.add(
//             TextSpan(
//               text: span.text!.substring(0, remainingLength),
//               style: span.style,
//             ),
//           );
//         }
//         break;
//       }
//     }

//     return RichText(
//       text: TextSpan(children: currentTextSpans),
//       textAlign: textAlign,
//       textDirection: textDirection,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/bloc/businessresponse/business_response_bloc.dart';
import 'package:krofile_ai/bloc/incognitoresponse/incognitoresponse_bloc.dart';
import 'package:krofile_ai/utils/text_parse.dart';

enum AnimationContext {
  businessResponse,
  incognitoChat,
}

class CustomAnimatedText extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final int index;
  final AnimationContext animationContext; // Add a parameter for context

  const CustomAnimatedText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.textColor,
    required this.index,
    required this.animationContext, // Initialize it
  });

  @override
  _CustomAnimatedTextState createState() => _CustomAnimatedTextState();
}

class _CustomAnimatedTextState extends State<CustomAnimatedText>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  bool isAnimationCompleted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
          milliseconds:
              widget.text.length * 10), // Adjust speed based on text length
    );

    _controller.forward();

    // Add a listener to set `isAnimationCompleted` to true when the animation ends
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Handle based on the provided context
        switch (widget.animationContext) {
          case AnimationContext.businessResponse:
            context
                .read<BusinessResponseBloc>()
                .add(AnimationCompleted(widget.index));
            break;
          case AnimationContext.incognitoChat:
            context
                .read<IncognitoResponseBloc>()
                .add(IncognitoAnimationCompleted(widget.index));

            break;
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Needed for AutomaticKeepAliveClientMixin to work
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomTypewriterAnimatedText(
          text: widget.text,
          fontSize: widget.fontSize,
          textColor: widget.textColor,
          controller: _controller,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CustomTypewriterAnimatedText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final AnimationController controller;

  const CustomTypewriterAnimatedText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.textColor,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final textSpans =
        convertToBoldText(text, fontSize: fontSize, color: textColor);
    final currentLength = (controller.value * text.length).round();
    var currentTextSpans = <TextSpan>[];
    var currentTextLength = 0;

    for (var span in textSpans) {
      if (currentTextLength + span.text!.length <= currentLength) {
        currentTextSpans.add(span);
        currentTextLength += span.text!.length;
      } else {
        var remainingLength = currentLength - currentTextLength;
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
    );
  }
}
