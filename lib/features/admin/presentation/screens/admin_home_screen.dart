import 'package:alharamin_app/core/functions/flutter_toast.dart';
import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:alharamin_app/features/admin/data/cubits/download_payment/download_payment_cubit.dart';
import 'package:alharamin_app/features/admin/presentation/widgets/admin_home_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DownloadPaymentCubit, DownloadPaymentState>(
      listener: (context, state) {
        if (state is DownloadPaymentLoading) {
          flutterToast('Downloading Payments...', color: Colors.white);
        } else if (state is DownloadPaymentSuccess) {
          flutterToast('Downloaded Successfully', color: Colors.white);
        } else if (state is DownloadPaymentFailure) {
          flutterToast(state.message, color: Colors.white);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: Text(
            'Booked Appointments',
            style: Styles.font18W600Black.copyWith(color: Color(0xffA25D5D)),
          ),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {
                context.read<DownloadPaymentCubit>().exportAndClearPayments();
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.primary),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: const Text(
                  'Download Payments',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(width: 12.w),
          ],
        ),
        body: AdminHomeScreenBody(),
      ),
    );
  }
}
