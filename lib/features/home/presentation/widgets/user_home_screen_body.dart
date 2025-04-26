import 'package:alharamin_app/features/home/presentation/widgets/chat_bot_widget.dart';
import 'package:alharamin_app/features/home/presentation/widgets/user_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserHomeScreenBody extends StatelessWidget {
  const UserHomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserName(userName: 'Osama'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: ChatBotWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
