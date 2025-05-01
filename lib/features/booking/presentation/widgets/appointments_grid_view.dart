import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentsGrideView extends StatelessWidget {
  const AppointmentsGrideView({super.key, required this.doctorModel});

  final DoctorModel doctorModel;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 160 / 55,
        crossAxisCount: 2,
      ),
      itemCount: doctorModel.appointments.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.lighterGrey,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Center(
            child: Text(
              doctorModel.appointments[index],
              style: Styles.font16W500LightGrey.copyWith(fontSize: 18.sp),
            ),
          ),
        );
      },
    );
  }
}
