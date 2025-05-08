import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typing_indicator/flutter_typing_indicator.dart';

class TypingIndicatorBubble extends StatelessWidget {
  const TypingIndicatorBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: REdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: REdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: TypingIndicator(dotColor: Colors.grey.shade700),
      ),
    );
  }
}
