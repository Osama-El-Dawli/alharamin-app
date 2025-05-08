import 'package:flutter/material.dart';
import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class AppointmentsGridView extends StatelessWidget {
  final List<String> appointments;
  final Function(String) onTimeSelected;
  final String? selectedTime;
  final bool isLoading;

  const AppointmentsGridView({
    super.key,
    required this.appointments,
    required this.onTimeSelected,
    this.selectedTime,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildShimmerGrid();
    }

    if (appointments.isEmpty) {
      return const Center(child: Text('No available appointments'));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 3,
      ),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final time = appointments[index];
        final isSelected = time == selectedTime;

        return GestureDetector(
          onTap: () => onTimeSelected(time),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.lighterGrey,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppColors.primary : Colors.transparent,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                time,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildShimmerGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 3,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.transparent, width: 2),
            ),
            child: Center(
              child: Container(
                width: 60,
                height: 10,
                color: Colors.grey.shade200,
              ),
            ),
          ),
        );
      },
    );
  }
}
