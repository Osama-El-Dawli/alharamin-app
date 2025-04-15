import 'package:alharamin_app/core/constants/assets.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorImageAndText extends StatelessWidget {
  const DoctorImageAndText({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(Assets.assetsImagesLogoBackground),
        Positioned(
          right: 12.w,
          left: 0,
          child: Container(
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.white.withAlpha(0)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.15, 0.4],
              ),
            ),
            child: Image.asset(Assets.assetsImagesDoctor),
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          bottom: -5.h,
          child: Text(
            'Doctor\nAppointment App',
            textAlign: TextAlign.center,
            style: Styles.font35W700Primary,
          ),
        ),
      ],
    );
  }
}
