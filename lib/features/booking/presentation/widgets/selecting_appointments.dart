import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alharamin_app/features/booking/data/cubit/booking_cubit.dart';
import 'appointments_grid_view.dart';
import 'date_selector_list_view.dart';
import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';

class SelectingAppointments extends StatelessWidget {
  final DoctorModel doctorModel;
  final Function(DateTime) onDateSelected;
  final Function(String) onTimeSelected;

  const SelectingAppointments({
    super.key,
    required this.doctorModel,
    required this.onDateSelected,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        List<String> availableAppointments = [];
        DateTime? selectedDate;
        String? selectedTime;

        if (state is DateSelectedState) {
          availableAppointments = state.availableAppointments;
          selectedDate = state.date;
          selectedTime = state.selectedTime;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Select Date',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            DateSelectorListView(onDateSelected: onDateSelected),
            const SizedBox(height: 16),
            if (selectedDate != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Available Times on ${DateFormat.yMMMd().format(selectedDate)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            const SizedBox(height: 8),
            AppointmentsGridView(
              appointments: availableAppointments,
              selectedTime: selectedTime,
              onTimeSelected: onTimeSelected,
              isLoading: state is BookingLoading,
            ),
          ],
        );
      },
    );
  }
}
