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
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.primary),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned.fill(
              top: -10.h,
              child: Image.asset(
                Assets.assetsImagesOverlayChatbot,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 20.h),
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
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        const Color(0xC2FFFFFF),
                      ),
                      overlayColor: WidgetStatePropertyAll<Color>(
                        AppColors.lighterGrey,
                      ),
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
