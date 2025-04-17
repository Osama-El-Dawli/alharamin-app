import 'package:alharamin_app/core/constants/assets.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:alharamin_app/features/login/admin_login/logic/cubits/admin_login_cubit/admin_login_cubit.dart';
import 'package:alharamin_app/features/login/admin_login/presentation/widgets/admin_form_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminLoginBody extends StatelessWidget {
  const AdminLoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(Assets.assetsImagesLogoBackground),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 32.h),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28.r,
                          backgroundImage: AssetImage(
                            Assets.assetsImagesAdminAvatar,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text('Hello Admin !', style: Styles.font18W700Primary),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Image.asset(Assets.assetsImagesStaff),
                    SizedBox(height: 24.h),
                    BlocProvider(
                      create: (context) => AdminLoginCubit(),
                      child: AdminFormSection(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
