import 'package:alharamin_app/core/constants/assets.dart';
import 'package:alharamin_app/features/auth/data/models/user_model.dart';
import 'package:alharamin_app/features/doctor/presentation/widgets/doctor_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key, required this.specialityName, required this.userModel});
  final String specialityName;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 100.h,
        title: Image.asset(Assets.assetsImagesLogo),
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
      ),
      body: DoctorScreenBody(
        specialityName: specialityName,
        userModel: userModel,
      ),
    );
  }
}
