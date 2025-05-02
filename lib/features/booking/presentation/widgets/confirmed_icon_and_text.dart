import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConfirmedIconAndText extends StatelessWidget {
  const ConfirmedIconAndText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Icon(FontAwesomeIcons.check, color: Colors.white, size: 40),
          ),
        ),
        SizedBox(height: 20.h),
        Text('Booking Confirmed', style: Styles.font20W500Black),
      ],
    );
  }
}
