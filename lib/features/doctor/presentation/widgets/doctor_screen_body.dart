import 'package:alharamin_app/core/constants/assets.dart';
import 'package:alharamin_app/features/doctor/data/cubit/doctor_cubit/doctor_cubit.dart';
import 'package:alharamin_app/features/doctor/presentation/widgets/custom_search_widget.dart';
import 'package:alharamin_app/features/doctor/presentation/widgets/doctor_card.dart';
import 'package:alharamin_app/features/doctor/presentation/widgets/shimmer_doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DoctorScreenBody extends StatelessWidget {
  final String specialityName;

  const DoctorScreenBody({super.key, required this.specialityName});

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
      body: BlocBuilder<DoctorCubit, DoctorState>(
        builder: (context, state) {
          if (state is DoctorFailure) {
            return Center(child: Text(state.errMessage));
          }
          return Column(
            children: [
              SizedBox(height: 15.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: CustomSearchWidget(),
              ),
              SizedBox(height: 12.h),
              Expanded(child: _buildDoctorList(state)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDoctorList(DoctorState state) {
    if (state is DoctorLoading) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: ShimmerDoctorCard(),
            );
          },
        ),
      );
    }

    if (state is DoctorLoaded) {
      return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: state.doctors.length,
        itemBuilder: (context, index) {
          final doctor = state.doctors[index];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: DoctorCard(doctorModel: doctor),
          );
        },
      );
    } else if (state is DoctorEmpty) {
      return Center(child: Text(state.errMessage));
    } else {
      return Center(child: Text('Something went wrong'));
    }
  }
}
