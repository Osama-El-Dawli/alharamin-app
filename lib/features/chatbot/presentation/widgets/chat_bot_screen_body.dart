import 'package:alharamin_app/features/chatbot/presentation/widgets/chat_input_field.dart';
import 'package:alharamin_app/features/chatbot/presentation/widgets/chat_message_bubble.dart';
import 'package:alharamin_app/features/chatbot/presentation/widgets/typing_indicator_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alharamin_app/core/functions/flutter_toast.dart';
import 'package:alharamin_app/features/chatbot/data/cubit/chatbot_cubit.dart';

class ChatBotScreenBody extends StatefulWidget {
  const ChatBotScreenBody({super.key});

  @override
  State<ChatBotScreenBody> createState() => _ChatBotScreenBodyState();
}

class _ChatBotScreenBodyState extends State<ChatBotScreenBody> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatbotCubit, ChatbotState>(
        listener: (context, state) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => _scrollToBottom(),
          );
          if (state is ChatbotError) {
            flutterToast('Error: ${state.error}');
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: REdgeInsets.all(8.0),
                  itemCount:
                      (state is ChatbotLoading &&
                              state.messages.isNotEmpty &&
                              state.messages.last.isUser)
                          ? state.messages.length + 1
                          : state.messages.length,
                  itemBuilder: (context, index) {
                    if (index < state.messages.length) {
                      return ChatMessageBubble(message: state.messages[index]);
                    } else {
                      return const TypingIndicatorBubble();
                    }
                  },
                ),
              ),
              ChatInputField(
                textController: _textController,
                onSend: (text) {
                  context.read<ChatbotCubit>().sendMessage(text);
                  _textController.clear();
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) => _scrollToBottom(),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
