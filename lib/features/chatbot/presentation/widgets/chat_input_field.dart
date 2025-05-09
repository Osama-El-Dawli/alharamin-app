import 'package:alharamin_app/core/theme/styles.dart';
import 'package:alharamin_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alharamin_app/core/theme/app_colors.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController textController;
  final Function(String) onSend;

  const ChatInputField({
    super.key,
    required this.textController,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              controller: textController,
              hintStyle: Styles.font14W500Grey,
              hintText: 'Describe your symptoms...',
              backgroundColor: Colors.grey[100],
              contentPadding: REdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),

              onFieldSubmitted: (text) {
                final trimmed = text.trim();
                if (trimmed.isNotEmpty) onSend(trimmed);
              },
            ),
          ),
          SizedBox(width: 8.w),
          FloatingActionButton(
            backgroundColor: AppColors.lightYellow,
            mini: true,
            onPressed: () {
              final text = textController.text.trim();
              if (text.isNotEmpty) onSend(text);
            },
            elevation: 0,
            child: const Icon(Icons.send, color: AppColors.darkPrimary),
          ),
        ],
      ),
    );
  }
}
