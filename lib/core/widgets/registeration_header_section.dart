import 'package:alharamin_app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterationHeaderSection extends StatelessWidget {
  const RegisterationHeaderSection({super.key, required this.headerTitle, required this.headerSubTitle});
  final String headerTitle;
  final String headerSubTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60.h),
          Text(headerTitle, style: Styles.font28W700Primary),
          SizedBox(height: 8.h),
          Text(
            headerSubTitle,
            style: Styles.font14W400Grey.copyWith(height: 1.5),
          ),
          SizedBox(height: 36.h),
        ],
      ),
    );
  }
}
