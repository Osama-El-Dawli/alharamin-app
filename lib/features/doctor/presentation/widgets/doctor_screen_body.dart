import 'package:alharamin_app/core/constants/assets.dart';
import 'package:alharamin_app/features/doctor/presentation/widgets/custom_search_widget.dart';
import 'package:alharamin_app/features/doctor/presentation/widgets/doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorScreenBody extends StatelessWidget {
  const DoctorScreenBody({super.key});

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
      body: Column(
        children: [
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: CustomSearchWidget(),
          ),
          SizedBox(height: 12.h),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: DoctorCard(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
