import 'package:alharamin_app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserHeaderSection extends StatelessWidget {
  const UserHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60.h),
          Text('Sign In', style: Styles.font28W700Primary),
          SizedBox(height: 8.h),
          Text(
            'We\'re excited to have you back, can\'t wait to see what you\'ve been up to since you last logged in.',
            style: Styles.font14W400Grey.copyWith(height: 1.5),
          ),
          SizedBox(height: 36.h),
        ],
      ),
    );
  }
}
