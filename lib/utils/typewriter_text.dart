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
  final AnimationContext animationContext;

  const CustomAnimatedText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.textColor,
    required this.index,
    required this.animationContext,
  });

  @override
  State<CustomAnimatedText> createState() => CustomAnimatedTextState();
}

class CustomAnimatedTextState extends State<CustomAnimatedText>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  bool isAnimationCompleted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.text.length * 10),
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
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
    super.build(context);
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
