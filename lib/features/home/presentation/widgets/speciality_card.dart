import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:alharamin_app/features/home/data/models/speciality_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecialityCard extends StatelessWidget {
  const SpecialityCard({super.key, required this.specialityModel});
  final SpecialityModel specialityModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.lightYellow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 3),
                      blurRadius: 2,
                      color: Color(0x40000000),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(100),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0x66AD9F2D), Color(0xE39E7575)],
                  ),
                ),
                height: 95,
                width: 100,
                child: Center(
                  child: Image.asset(specialityModel.specialityImage),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              specialityModel.speacialityName,
              style: Styles.font20w600Primary,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
