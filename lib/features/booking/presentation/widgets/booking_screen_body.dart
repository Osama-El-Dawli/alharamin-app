import 'package:alharamin_app/core/widgets/custom_app_bar.dart';
import 'package:alharamin_app/core/widgets/custom_button.dart';
import 'package:alharamin_app/features/booking/presentation/widgets/selecting_appointments.dart';
import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';
import 'package:alharamin_app/features/doctor/presentation/widgets/doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingScreenBody extends StatelessWidget {
  const BookingScreenBody({super.key, required this.doctorModel});
  final DoctorModel doctorModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Book Appointment'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 24.h),
            child: DoctorCard(doctorModel: doctorModel),
          ),
          SelectingAppointments(doctorModel: doctorModel),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: CustomButton(text: 'Book', onPressed: () {}),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
