import 'package:alharamin_app/features/admin/data/models/payment_model.dart';
import 'package:alharamin_app/features/admin/presentation/widgets/appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminAppointmentGrid extends StatelessWidget {
  const AdminAppointmentGrid({super.key, required this.bookings});

  final List<PaymentModel> bookings;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 6,
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 10,
      ),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: AppointmentCard(paymentModel: bookings[index]),
        );
      },
    );
  }
}
