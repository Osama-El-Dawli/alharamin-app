import 'package:alharamin_app/core/routes/app_routes.dart';
import 'package:alharamin_app/core/widgets/custom_app_bar.dart';
import 'package:alharamin_app/core/widgets/custom_button.dart';
import 'package:alharamin_app/features/booking/data/models/appointment_model.dart';
import 'package:alharamin_app/features/booking/presentation/widgets/booking_info.dart';
import 'package:alharamin_app/features/booking/presentation/widgets/confirmed_icon_and_text.dart';
import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BookingDetailsBody extends StatelessWidget {
  const BookingDetailsBody({
    super.key,
    required this.doctorModel,
    required this.appointmentModel,
  });
  final DoctorModel doctorModel;
  final AppointmentModel appointmentModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Details'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 1),
            const Align(
              alignment: Alignment.center,
              child: ConfirmedIconAndText(),
            ),
            SizedBox(height: 58.h),
            BookingInfo(
              doctorModel: doctorModel,
              appointmentModel: appointmentModel,
            ),
            const Spacer(flex: 2),
            CustomButton(
              text: 'Done',
              onPressed: () {
                context.go(AppRoutes.userHome,);
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
