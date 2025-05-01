import 'package:alharamin_app/core/functions/flutter_toast.dart';
import 'package:alharamin_app/core/widgets/custom_app_bar.dart';
import 'package:alharamin_app/core/widgets/custom_button.dart';
import 'package:alharamin_app/features/auth/models/user_model.dart';
import 'package:alharamin_app/features/booking/data/cubit/booking_cubit.dart';
import 'package:alharamin_app/features/booking/presentation/widgets/selecting_appointments.dart';
import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';
import 'package:alharamin_app/features/doctor/presentation/widgets/doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingScreenBody extends StatelessWidget {
  const BookingScreenBody({
    super.key,
    required this.doctorModel,
    required this.userModel,
  });

  final DoctorModel doctorModel;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              BookingCubit(doctor: doctorModel, patientId: userModel.uid),
      child: Scaffold(
        appBar: CustomAppBar(title: 'Book Appointment'),
        body: BlocConsumer<BookingCubit, BookingState>(
          listener: (context, state) {
            if (state is BookingSuccess) {
              flutterToast('Appointment Booked Successfully');
              Navigator.pop(context); // Close screen after success
            } else if (state is BookingError) {
              flutterToast(state.message);
            }
          },
          builder: (context, state) {
            final cubit = context.read<BookingCubit>();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 24.h,
                  ),
                  child: DoctorCard(doctorModel: doctorModel),
                ),
                SelectingAppointments(
                  doctorModel: doctorModel,
                  onDateSelected: (date) => cubit.selectDate(date),
                  onTimeSelected: (time) {
                    // cubit.selectTime(time);
                    // Optional: Auto-trigger booking when time is selected
                    cubit.bookAppointment(time);
                  },
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: CustomButton(
                    text: 'Book',
                    onPressed: () {
                      if (cubit.selectedTime != null) {
                        cubit.bookAppointment(cubit.selectedTime!);
                      } else {
                        flutterToast('Please select a time slot');
                      }
                    },
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            );
          },
        ),
      ),
    );
  }
}
