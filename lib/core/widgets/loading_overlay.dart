import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: ModalBarrier(dismissible: false, color: AppColors.lighterGrey),
        ),
        const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      ],
    );
  }
}
