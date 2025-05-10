import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:alharamin_app/features/admin/presentation/widgets/admin_home_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onPressed: () {},
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
    );
  }
}
