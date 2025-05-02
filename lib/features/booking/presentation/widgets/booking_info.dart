import 'package:alharamin_app/core/constants/assets.dart';
import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:alharamin_app/features/booking/data/models/appointment_model.dart';
import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';
import 'package:alharamin_app/features/doctor/presentation/widgets/doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class BookingInfo extends StatelessWidget {
  const BookingInfo({
    super.key,
    required this.doctorModel,
    required this.appointmentModel,
  });
  final DoctorModel doctorModel;
  final AppointmentModel appointmentModel;

  String _formatBookingDate(DateTime date) {
    return '${DateFormat('EEEE').format(date)}, ${DateFormat('dd MMM yyyy').format(date)}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Booking Information',
          style: Styles.font16W600White.copyWith(color: Colors.black),
        ),
        SizedBox(height: 24.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: AppColors.lightYellow,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: SizedBox(
                  height: 34.h,
                  width: 34.w,
                  child: SvgPicture.asset(
                    fit: BoxFit.contain,
                    Assets.assetsImagesCalendarSvg,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date & Time',
                  style: Styles.font14W500DarkGrey.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  _formatBookingDate(appointmentModel.date),
                  style: Styles.font12W400Grey,
                ),
                Text(appointmentModel.time, style: Styles.font12W400Grey),
              ],
            ),
          ],
        ),
        SizedBox(height: 32.h),
        Text(
          'Booking Information',
          style: Styles.font16W600White.copyWith(color: Colors.black),
        ),
        SizedBox(height: 24.h),
        DoctorCard(doctorModel: doctorModel),
      ],
    );
  }
}
