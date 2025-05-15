import 'package:alharamin_app/core/routes/app_routes.dart';
import 'package:alharamin_app/core/routes/extra_params.dart';
import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alharamin_app/features/booking/data/cubit/booking_cubit.dart';
import 'package:alharamin_app/features/booking/presentation/widgets/selecting_appointments.dart';
import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';
import 'package:alharamin_app/features/auth/data/models/user_model.dart';
import 'package:alharamin_app/core/widgets/custom_button.dart';
import 'package:alharamin_app/core/functions/flutter_toast.dart';
import 'package:alharamin_app/features/doctor/presentation/widgets/doctor_card.dart';
import 'package:go_router/go_router.dart';

class BookingScreenBody extends StatelessWidget {
  final DoctorModel doctorModel;
  final UserModel userModel;

  const BookingScreenBody({
    super.key,
    required this.doctorModel,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is BookingSuccess) {
          flutterToast('Appointment Booked Successfully');
          context.go(
            AppRoutes.bookingDetails,
            extra: BookingDetailsParams(
              userModel: userModel,
              doctorModel: doctorModel,
              appointmentModel: state.appointmentModel,
            ),
          );
        } else if (state is BookingFailure) {
          flutterToast(state.errMessage);
        } else if (state is BookingOperationFailure) {
          flutterToast(state.errMessage);
        }
      },
      builder: (context, state) {
        final cubit = context.read<BookingCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 24.h),
              child: DoctorCard(doctorModel: doctorModel),
            ),
            SelectingAppointments(
              onTimeSelected: cubit.selectTime,
              doctorModel: doctorModel,
              onDateSelected: cubit.selectDate,
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: BlocBuilder<BookingCubit, BookingState>(
                builder: (context, state) {
                  if (state is BookingOperationLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }
                  
                  return CustomButton(
                    text: 'Book',
                    onPressed: () {
                      if (cubit.selectedDate == null) {
                        flutterToast('Please select a date first');
                        return;
                      }
                      if (cubit.selectedTime == null) {
                        flutterToast('Please select a time slot');
                        return;
                      }
                      cubit.bookAppointment();
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 24.h),
          ],
        );
      },
    );
  }
}
