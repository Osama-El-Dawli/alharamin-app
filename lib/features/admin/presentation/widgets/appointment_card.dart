import 'package:alharamin_app/core/constants/app_strings.dart';
import 'package:alharamin_app/core/constants/assets.dart';
import 'package:alharamin_app/core/functions/capitalize.dart';
import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:alharamin_app/features/admin/data/models/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key, required this.paymentModel});
  final PaymentModel paymentModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.lightYellow,
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Image.asset(
                      Assets.assetsImagesDoctorAvatar,
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
                ),
                SizedBox(width: 16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. ${paymentModel.doctorName.capitalizeEachWord()}',
                      style: Styles.font16W700Primary.copyWith(
                        color: AppColors.darkPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Text(
                          '${paymentModel.doctorSpeciality.capitalizeEachWord()}  |  ${AppStrings.appNameEn} Hospital',
                          style: Styles.font12W500DarkGrey,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '${paymentModel.price} EGP',
                      style: Styles.font12W500DarkGrey.copyWith(
                        color: AppColors.darkPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 8.w),
                VerticalDivider(
                  thickness: 1.w,
                  color: AppColors.lightPrimary,
                  width: 40.h,
                  endIndent: 8.w,
                  indent: 8.w,
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Patient. ${paymentModel.patientName.capitalizeEachWord()}',
                          style: Styles.font16W700Primary.copyWith(
                            color: AppColors.darkGrey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Text('Phone. ', style: Styles.font12W500DarkGrey),
                        Text(
                          paymentModel.patientPhone,
                          style: Styles.font12W500DarkGrey,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Text(
                          'Date. ${paymentModel.date}  |  ',
                          style: Styles.font12W500DarkGrey.copyWith(
                            color: AppColors.darkPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Time. ${paymentModel.time}',
                          style: Styles.font12W500DarkGrey.copyWith(
                            color: AppColors.darkPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(Colors.teal),
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 8.h),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(Colors.redAccent),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
