import 'package:alharamin_app/core/functions/flutter_toast.dart';
import 'package:alharamin_app/core/helpers/service_locator.dart';
import 'package:alharamin_app/core/routes/app_routes.dart';
import 'package:alharamin_app/core/routes/extra_params.dart';
import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/features/auth/data/models/user_model.dart';
import 'package:alharamin_app/features/booking/data/cubit/booking_cubit.dart';
import 'package:alharamin_app/features/booking/data/repositories/booking_repository.dart';
import 'package:alharamin_app/features/doctor/data/cubit/doctor_cubit/doctor_cubit.dart';
import 'package:alharamin_app/features/doctor/data/model/doctor_model.dart';
import 'package:alharamin_app/features/doctor/presentation/widgets/custom_search_widget.dart';
import 'package:alharamin_app/features/doctor/presentation/widgets/doctor_card.dart';
import 'package:alharamin_app/features/doctor/presentation/widgets/shimmer_doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class DoctorScreenBody extends StatefulWidget {
  final String specialityName;
  final UserModel userModel;

  const DoctorScreenBody({
    super.key,
    required this.specialityName,
    required this.userModel,
  });

  @override
  State<DoctorScreenBody> createState() => _DoctorScreenBodyState();
}

class _DoctorScreenBodyState extends State<DoctorScreenBody> {
  bool _isCheckingBooking = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<DoctorCubit, DoctorState>(
          builder: (context, state) {
            if (state is DoctorFailure) {
              return Center(child: Text(state.errMessage));
            }
            return Column(
              children: [
                SizedBox(height: 15.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: CustomSearchWidget(
                    onSearch: (query) {
                      if (query.isNotEmpty) {
                        context.read<DoctorCubit>().fetchDoctorsByName(
                          nameEn: query,
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 12.h),
                Expanded(child: _buildDoctorList(state)),
              ],
            );
          },
        ),
        if (_isCheckingBooking)
          const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
      ],
    );
  }

  Widget _buildDoctorList(DoctorState state) {
    if (state is DoctorLoading) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: ShimmerDoctorCard(),
            );
          },
        ),
      );
    }

    if (state is DoctorLoaded) {
      return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: state.doctors.length,
        itemBuilder: (context, index) {
          final doctor = state.doctors[index];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: InkWell(
              onTap: () => _handleDoctorTap(doctor),
              child: DoctorCard(doctorModel: doctor),
            ),
          );
        },
      );
    } else if (state is DoctorEmpty) {
      return Center(child: Text(state.errMessage));
    } else {
      return Center(child: Text('Something went wrong'));
    }
  }

  Future<void> _handleDoctorTap(DoctorModel doctor) async {
    if (_isCheckingBooking) return;

    setState(() => _isCheckingBooking = true);

    try {
      final cubit = BookingCubit(
        doctor: doctor,
        patientId: widget.userModel.uid,
        bookingRepository: getIt<IBookingRepository>(),
      );

      final checkResult = await cubit.checkIsAlreadyBooked();

      if (!mounted) return;

      checkResult.fold(
        (failure) {
          flutterToast('Error checking booking: ${failure.message}');
        },
        (existingAppointment) {
          if (existingAppointment != null) {
            context.push(
              AppRoutes.bookingDetails,
              extra: BookingDetailsParams(
                doctorModel: doctor,
                appointmentModel: existingAppointment,
                userModel: widget.userModel,
              ),
            );
          } else {
            context.push(
              AppRoutes.booking,
              extra: BookingScreenParams(
                doctorModel: doctor,
                userModel: widget.userModel,
              ),
            );
          }
        },
      );
    } catch (e) {
      flutterToast('Error checking booking: ${e.toString()}');
    } finally {
      if (mounted) setState(() => _isCheckingBooking = false);
    }
  }
}
