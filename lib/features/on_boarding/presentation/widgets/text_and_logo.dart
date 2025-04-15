import 'package:alharamin_app/core/constants/app_strings.dart';
import 'package:alharamin_app/core/constants/assets.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextAndLogo extends StatelessWidget {
  const TextAndLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Image.asset(Assets.assetsImagesLogo),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Text(
            AppStrings.appNameAr,
            style: Styles.font28w600Primary.copyWith(fontFamily: 'ArefRuqaa'),
          ),
        ),
      ],
    );
  }
}
