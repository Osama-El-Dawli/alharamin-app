import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alharamin_app/features/booking/data/cubit/booking_cubit.dart';
import 'appointments_grid_view.dart';
import 'date_selector_list_view.dart';
import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';

class SelectingAppointments extends StatefulWidget {
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
  State<SelectingAppointments> createState() => _SelectingAppointmentsState();
}

class _SelectingAppointmentsState extends State<SelectingAppointments> {
  List<String> _availableAppointments = [];
  DateTime? _selectedDate;
  String? _selectedTime;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is DateSelectedState) {
          setState(() {
            _availableAppointments = state.availableAppointments;
            _selectedDate = state.date;
            _selectedTime = state.selectedTime;
            _isLoading = false;
          });
        } else if (state is BookingLoading) {
          setState(() {
            _isLoading = true;
          });
        } else if (state is BookingSuccess ||
            state is BookingOperationFailure ||
            state is BookingFailure) {
          setState(() {
            _isLoading = false;
          });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Select Date',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          DateSelectorListView(onDateSelected: widget.onDateSelected),
          const SizedBox(height: 16),
          if (_selectedDate != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Available Times on ${DateFormat.yMMMd().format(_selectedDate!)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          const SizedBox(height: 8),
          AppointmentsGridView(
            appointments: _availableAppointments,
            selectedTime: _selectedTime,
            onTimeSelected: (time) {
              widget.onTimeSelected(time);
              setState(() {
                _selectedTime = time;
              });
            },
            isLoading: _isLoading,
          ),
        ],
      ),
    );
  }
}
