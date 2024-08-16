import 'package:flutter/material.dart';

// Method to extract plain text from List<TextSpan>

List<TextSpan> convertToBoldText(String text,
    {required double fontSize, required Color color}) {
  List<TextSpan> spans = [];
  RegExp exp = RegExp(r'\*\*(.*?)\*\*');
  int lastIndex = 0;

  for (Match match in exp.allMatches(text)) {
    if (match.start > lastIndex) {
      spans.add(TextSpan(
        text: text.substring(lastIndex, match.start),
        style: TextStyle(fontSize: fontSize, color: color, fontFamily: 'inter',fontWeight: FontWeight.w400),
      ));
    }
    spans.add(TextSpan(
      text: match.group(1),
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          color: color,
          fontFamily: 'inter',
         ),
    ));
    lastIndex = match.end;
  }

  if (lastIndex < text.length) {
    spans.add(TextSpan(
      text: text.substring(lastIndex),
      style: TextStyle(fontSize: fontSize, color: color, fontFamily: 'inter',
          fontWeight: FontWeight.w400),
    ));
  }

  return spans;
}
