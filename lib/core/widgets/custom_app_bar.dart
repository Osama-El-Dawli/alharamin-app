import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      title: Center(
        child: Padding(
          padding: EdgeInsets.only(right: 40.w),
          child: Text(title, style: Styles.font18W600Black),
        ),
      ),
      leading: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 6.h),
          child: Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.lighterGrey),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Align(
              alignment: Alignment.center,
              child: InkWell(
                borderRadius: BorderRadius.circular(10.r),
                child: Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                onTap: () {
                  context.pop();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
