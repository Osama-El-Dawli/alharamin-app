import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    super.key,
    required this.image,
    required this.name,
    required this.onTap,
  });
  final ImageProvider<Object> image;
  final String name;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 73.r,
          backgroundColor: AppColors.primary,
          child: InkWell(
            onTap: onTap,
            child: Center(
              child: CircleAvatar(radius: 70.r, backgroundImage: image),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Text(name, style: Styles.font24W600Primary),
      ],
    );
  }
}
