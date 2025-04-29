import 'package:alharamin_app/core/constants/app_strings.dart';
import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.lightYellow,
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Row(
          children: [
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. John Doe',
                  style: Styles.font16W700Primary.copyWith(
                    color: AppColors.darkPrimary,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text('Cardiologist', style: Styles.font12W500DarkGrey),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 0.5.w),
                      height: 12.h,
                      width: 1.5.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: AppColors.darkGrey,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '${AppStrings.appNameEn} Hospital',
                      style: Styles.font12W500DarkGrey,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
