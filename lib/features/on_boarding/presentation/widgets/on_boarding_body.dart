import 'package:alharamin_app/features/on_boarding/presentation/widgets/text_and_logo.dart';
import 'package:flutter/material.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [TextAndLogo()],
    );
  }
}
