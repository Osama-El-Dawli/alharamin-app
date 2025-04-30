import 'package:alharamin_app/core/constants/app_strings.dart';
import 'package:alharamin_app/core/functions/capitalize.dart';
import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key, required this.doctorModel});
  final DoctorModel doctorModel;

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
              clipBehavior: Clip.hardEdge,
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Image.network(
                doctorModel.image,
                errorBuilder:
                    (context, error, stackTrace) => Center(
                      child: Icon(
                        Icons.person,
                        size: 40.r,
                        color: AppColors.darkPrimary,
                      ),
                    ),
              ),
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. ${doctorModel.nameEn.capitalizeEachWord()}',
                  style: Styles.font16W700Primary.copyWith(
                    color: AppColors.darkPrimary,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      doctorModel.speciality.capitalizeEachWord(),
                      style: Styles.font12W500DarkGrey,
                    ),
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
