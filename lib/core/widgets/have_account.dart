import 'package:alharamin_app/core/theme/styles.dart';
import 'package:flutter/material.dart';

class HaveAccount extends StatelessWidget {
  const HaveAccount({
    super.key,
    required this.questionText,
    required this.buttonText,
  });

  final String questionText;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(questionText, style: Styles.font14W400Grey),
        TextButton(
          style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
          ),
          child: Text(buttonText, style: Styles.font14W500Primary),
          onPressed: () {},
        ),
      ],
    );
  }
}
