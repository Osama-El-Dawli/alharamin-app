import 'package:alharamin_app/core/routes/app_routes.dart';
import 'package:alharamin_app/core/routes/extra_params.dart';
import 'package:alharamin_app/features/auth/models/user_model.dart';
import 'package:alharamin_app/features/home/data/models/speciality_model.dart';
import 'package:alharamin_app/features/home/presentation/widgets/chat_bot_widget.dart';
import 'package:alharamin_app/features/home/presentation/widgets/speciality_card.dart';
import 'package:alharamin_app/features/home/presentation/widgets/user_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UserHomeScreenBody extends StatelessWidget {
  const UserHomeScreenBody({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: UserName(userName: user.fullName)),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: ChatBotWidget(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.h),
              sliver: SliverGrid.builder(
                itemCount: specialityNames.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context.push(
                        AppRoutes.doctor,
                        extra: DoctorScreeenParams(
                          specialityName:
                              specialities[index].speacialityName
                                  .toLowerCase()
                                  .trim(),
                          userModel: user,
                        ),
                      );
                    },
                    child: SpecialityCard(specialityModel: specialities[index]),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 185 / 220,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
