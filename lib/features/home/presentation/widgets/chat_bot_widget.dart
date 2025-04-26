import 'package:alharamin_app/core/constants/assets.dart';
import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBotWidget extends StatelessWidget {
  const ChatBotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        decoration: BoxDecoration(color: AppColors.primary),
        height: 195.h,
        width: double.infinity,
        child: Stack(
          clipBehavior: Clip.hardEdge, // Hides overflow content
          children: [
            Positioned.fill(
              top: -10.h,
              child: Image.asset(
                Assets.assetsImagesOverlayChatbot,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 16.h,
              left: 16.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose Doctor\nSpeciality with',
                    style: Styles.font24W700White.copyWith(height: 1.5.h),
                  ),
                  Text(
                    'Our ChatBot',
                    style: Styles.font24W700White.copyWith(
                      height: 1.5.h,
                      color: const Color(0xffD6F9B1),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      padding: EdgeInsets.all(10.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color(0xC2FFFFFF),
                      ),
                      child: Text(
                        'Go to ChatBot',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xffA25D5D),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -35.h,
              right: -25.w,
              child: Image.asset(Assets.assetsImagesChatbotHomeScreen),
            ),
          ],
        ),
      ),
    );
  }
}
