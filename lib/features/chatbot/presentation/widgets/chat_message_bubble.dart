import 'package:alharamin_app/features/chatbot/data/models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alharamin_app/core/theme/app_colors.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: REdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: REdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: message.isUser ? AppColors.primary : AppColors.lighterGrey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(message.isUser ? 15.0 : 4.0),
            topRight: Radius.circular(message.isUser ? 0.0 : 15.0),
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isUser ? Colors.white : AppColors.darkPrimary,
          ),
        ),
      ),
    );
  }
}
