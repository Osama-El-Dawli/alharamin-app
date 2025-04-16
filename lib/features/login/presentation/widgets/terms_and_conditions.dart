import 'package:alharamin_app/core/theme/styles.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          TextSpan(
            text: 'By logging, you agree to our ',
            style: Styles.font12W400Grey,
          ),
          TextSpan(
            text: 'Terms & Conditions',
            style: Styles.font12W400Grey.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          TextSpan(text: ' and ', style: Styles.font12W400Grey),
          TextSpan(
            text: 'Privacy Policy',
            style: Styles.font12W400Grey.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
