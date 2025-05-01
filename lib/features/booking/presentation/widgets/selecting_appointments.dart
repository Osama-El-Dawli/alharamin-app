import 'package:alharamin_app/features/booking/data/cubit/booking_cubit.dart';
import 'package:alharamin_app/features/booking/presentation/widgets/appointments_grid_view.dart';
import 'package:alharamin_app/features/booking/presentation/widgets/date_selector_list_view.dart';
import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectingAppointments extends StatelessWidget {
  const SelectingAppointments({
    super.key,
    required this.doctorModel,
    required this.onDateSelected,
    required this.onTimeSelected,
  });

  final DoctorModel doctorModel;
  final Function(DateTime) onDateSelected;
  final Function(String) onTimeSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateSelectorListView(onDateSelected: onDateSelected),
        SizedBox(height: 24.h),
        BlocBuilder<BookingCubit, BookingState>(
          builder: (context, state) {
            if (state is DateSelectedState) {
              return AppointmentsGridView(
                appointments: state.availableAppointments,
                onTimeSelected: onTimeSelected,
                selectedTime: null,
              );
            }
            return const SizedBox(
              height: 200,
            ); // Better fallback with fixed height
          },
        ),
      ],
    );
  }
}
