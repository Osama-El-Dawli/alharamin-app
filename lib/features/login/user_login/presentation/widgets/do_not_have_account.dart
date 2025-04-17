import 'package:alharamin_app/core/theme/styles.dart';
import 'package:flutter/material.dart';

class DoNotHaveAccount extends StatelessWidget {
  const DoNotHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Don\'t have an account?', style: Styles.font14W400Grey),
        TextButton(
          style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
          ),
          child: Text('Sign Up', style: Styles.font14W500Primary),
          onPressed: () {},
        ),
      ],
    );
  }
}
