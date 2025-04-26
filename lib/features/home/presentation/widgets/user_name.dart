import 'package:alharamin_app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserName extends StatelessWidget {
  const UserName({super.key, required this.userName});
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 18.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hello, $userName!', style: Styles.font16W700Primary),
          Text('How Are you Today?', style: Styles.font14W400Grey),
        ],
      ),
    );
  }
}
