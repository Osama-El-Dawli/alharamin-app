import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Styles {
  static final TextStyle font28w600Primary = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static final TextStyle font35W700Primary = TextStyle(
    fontSize: 35.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  static final TextStyle font12W400Grey = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );

  static final TextStyle font16W600White = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static final TextStyle font24W600Primary = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );
}
