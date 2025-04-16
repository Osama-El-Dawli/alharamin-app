import 'package:alharamin_app/core/constants/assets.dart';
import 'package:alharamin_app/core/routes/app_routes.dart';
import 'package:alharamin_app/features/login/presentation/widgets/custom_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomChoosingWidget extends StatelessWidget {
  const CustomChoosingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomCircleAvatar(
          onTap: () {
            context.push(AppRoutes.adminLogin);
          },
          image: AssetImage(Assets.assetsImagesAdminAvatar),
          name: 'Admin',
        ),
        SizedBox(width: 22.w),
        CustomCircleAvatar(
          onTap: () {
            context.push(AppRoutes.userLogin);
          },
          image: AssetImage(Assets.assetsImagesPatientAvatar),
          name: 'Patient',
        ),
      ],
    );
  }
}
