import 'package:alharamin_app/core/constants/assets.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:alharamin_app/features/admin/logic/cubits/admin_login_cubit/admin_login_cubit.dart';
import 'package:alharamin_app/features/admin/presentation/widgets/admin_form_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminLoginBody extends StatelessWidget {
  const AdminLoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(Assets.assetsImagesLogoBackground),
            ),
            SizedBox.expand(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                  Assets.assetsImagesAdminAvatar,
                                ),
                                radius: 28.r,
                              ),
                              SizedBox(width: 16.w),
                              Text(
                                'Hello Admin !',
                                style: Styles.font18W700Primary,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Image.asset(Assets.assetsImagesStaff),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Center(
                        child: BlocProvider(
                          create: (context) => AdminLoginCubit(),
                          child: AdminFormSection(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
