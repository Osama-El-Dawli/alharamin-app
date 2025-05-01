import 'package:flutter/material.dart';

class AppointmentsGridView extends StatelessWidget {
  final List<String> appointments;
  final Function(String) onTimeSelected;
  final String? selectedTime;

  const AppointmentsGridView({
    super.key,
    required this.appointments,
    required this.onTimeSelected,
    this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 2,
      ),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final time = appointments[index];
        final isSelected = time == selectedTime;

        return GestureDetector(
          onTap: () => onTimeSelected(time),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                time,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
