import 'package:alharamin_app/core/constants/assets.dart';
import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:alharamin_app/features/login/presentation/widgets/cusotm_choosing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginSelectionBody extends StatelessWidget {
  const LoginSelectionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Center(child: Image.asset(Assets.assetsImagesLogoBackground)),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.lightPrimary,
                  AppColors.lightPrimary.withAlpha(0),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.1, 0.8],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 1),
              Text('Who Are You?', style: Styles.font35W700Primary),
              Spacer(flex: 1),
              CustomChoosingWidget(),
              Spacer(flex: 1),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Tell us who you are by choosing a photo to start our appointment journey',
                  style: Styles.font12W400Grey.copyWith(fontSize: 16.sp),
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(flex: 1),
            ],
          ),
        ],
      ),
    );
  }
}
