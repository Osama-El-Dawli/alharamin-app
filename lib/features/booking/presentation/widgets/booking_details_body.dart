import 'package:alharamin_app/core/functions/flutter_toast.dart';
import 'package:alharamin_app/core/routes/app_routes.dart';
import 'package:alharamin_app/core/widgets/custom_app_bar.dart';
import 'package:alharamin_app/core/widgets/custom_button.dart';
import 'package:alharamin_app/features/auth/models/user_model.dart';
import 'package:alharamin_app/features/booking/data/cubit/booking_cubit.dart';
import 'package:alharamin_app/features/booking/data/models/appointment_model.dart';
import 'package:alharamin_app/features/booking/presentation/widgets/booking_info.dart';
import 'package:alharamin_app/features/booking/presentation/widgets/confirmed_icon_and_text.dart';
import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BookingDetailsBody extends StatelessWidget {
  const BookingDetailsBody({
    super.key,
    required this.doctorModel,
    required this.appointmentModel,
    required this.userModel,
  });
  final DoctorModel doctorModel;
  final AppointmentModel appointmentModel;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is AppointmentCanceledLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder:
                (context) => const Center(
                  child: CircularProgressIndicator(color: Colors.red),
                ),
          );
        } else if (state is AppointmentCanceledSuccess) {
          Navigator.pop(context);
          flutterToast('Appointment Canceled');
          context.go(AppRoutes.userHome, extra: userModel);
        } else if (state is AppointmentCanceledFailure) {
          Navigator.pop(context);
          flutterToast(state.errMessage);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Details',
          rightPadding: 0,
          leftPadding: 20.w,
          leading: SizedBox.shrink(),
          actions: [
            TextButton(
              onPressed: () {
                context.read<BookingCubit>().cancelAppointment(
                  appointmentId: appointmentModel.id,
                );
              },
              child: Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
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
                  context.go(AppRoutes.userHome, extra: userModel);
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
