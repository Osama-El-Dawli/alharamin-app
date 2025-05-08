import 'package:alharamin_app/core/widgets/custom_app_bar.dart';
import 'package:alharamin_app/features/chatbot/presentation/widgets/chat_bot_screen_body.dart';
import 'package:flutter/material.dart';

class ChatBotScreen extends StatelessWidget {
  const ChatBotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'ChatBot'),
      body: ChatBotScreenBody(),
    );
  }
}
