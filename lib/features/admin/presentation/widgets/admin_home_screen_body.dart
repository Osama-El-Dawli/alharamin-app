import 'package:alharamin_app/core/functions/flutter_toast.dart';
import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:alharamin_app/features/admin/data/cubits/confirm_booking_cubit/confirm_booking_cubit.dart';
import 'package:alharamin_app/features/admin/presentation/widgets/admin_appointment_grid.dart';
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
          flutterToast('Deleted Successfully', color: Colors.white);
        } else if (state is ConfirmBookingConfirmed) {
          flutterToast('Confirmed Successfully', color: Colors.white);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          child: Builder(
            builder: (_) {
              if (state is ConfirmBookingLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              } else if (state is ConfirmBookingSuccess) {
                return AdminAppointmentGrid(bookings: state.bookings);
              } else {
                return Center(
                  child: Text(
                    'No Appointmnts',
                    style: Styles.font16W700Primary,
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
