import 'package:alharamin_app/core/constants/app_strings.dart';
import 'package:alharamin_app/core/constants/assets.dart';
import 'package:alharamin_app/core/functions/capitalize.dart';
import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:alharamin_app/features/admin/data/cubits/confirm_booking_cubit/confirm_booking_cubit.dart';
import 'package:alharamin_app/features/admin/data/models/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          'Date. ${DateFormat('dd MMMM yyyy').format(paymentModel.date)}  |  ',
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
                  onPressed: () {
                    context.read<ConfirmBookingCubit>().confirmBooking(
                      id: paymentModel.id,
                    );
                  },
                  style: ButtonStyle(
                    fixedSize: WidgetStatePropertyAll(Size.fromWidth(80.w)),
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
                  onPressed: () {
                    context.read<ConfirmBookingCubit>().deleteBooking(
                      id: paymentModel.id,
                    );
                  },
                  style: ButtonStyle(
                    fixedSize: WidgetStatePropertyAll(Size.fromWidth(80.w)),
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
