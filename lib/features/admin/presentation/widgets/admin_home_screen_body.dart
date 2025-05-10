import 'package:alharamin_app/core/functions/flutter_toast.dart';
import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:alharamin_app/features/admin/data/cubits/confirm_booking_cubit/confirm_booking_cubit.dart';
import 'package:alharamin_app/features/admin/presentation/widgets/appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminHomeScreenBody extends StatelessWidget {
  const AdminHomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConfirmBookingCubit, ConfirmBookingState>(
      listener: (context, state) {
        if (state is ConfirmBookingFailure) {
          flutterToast(state.message);
        } else if (state is ConfirmBookingDeleted) {
          flutterToast('Deleted Successfully');
        } else if (state is ConfirmBookingLoading) {
          showDialog(
            context: context,
            builder:
                (context) => const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                child:
                    (state is ConfirmBookingSuccess)
                        ? GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 8,
                                crossAxisCount: 2,
                                crossAxisSpacing: 18,
                                mainAxisSpacing: 10,
                              ),
                          itemCount: state.bookings.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: AppointmentCard(
                                paymentModel: state.bookings[index],
                              ),
                            );
                          },
                        )
                        : Center(
                          child: Text(
                            'No Appointments',
                            style: Styles.font16W700Primary,
                          ),
                        ),
              ),
            ),
          ],
        );
      },
    );
  }
}
