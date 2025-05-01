import 'package:alharamin_app/features/booking/presentation/widgets/appointments_grid_view.dart';
import 'package:alharamin_app/features/booking/presentation/widgets/date_selector_list_view.dart';
import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alharamin_app/core/theme/styles.dart';

class SelectingAppointments extends StatelessWidget {
  const SelectingAppointments({super.key, required this.doctorModel});
  final DoctorModel doctorModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Date',
            style: Styles.font16W600White.copyWith(color: Colors.black),
          ),
          SizedBox(height: 12.h),
          DateSelectorListView(),
          SizedBox(height: 20.h),
          Text(
            'Available Time',
            style: Styles.font16W600White.copyWith(color: Colors.black),
          ),
          SizedBox(height: 16.h),
          AppointmentsGrideView(doctorModel: doctorModel),
        ],
      ),
    );
  }
}
