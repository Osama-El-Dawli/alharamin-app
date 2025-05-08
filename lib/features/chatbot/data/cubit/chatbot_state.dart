part of 'chatbot_cubit.dart';

@immutable
abstract class ChatbotState extends Equatable {
  final List<ChatMessage> messages;
  const ChatbotState({this.messages = const []});

  @override
  List<Object?> get props => [messages];
}

class ChatbotInitial extends ChatbotState {
  const ChatbotInitial()
    : super(
        messages: const [
          ChatMessage(
            isUser: false,
            text: 'Hello! How can I help you describe your symptoms today?',
          ),
        ],
      );
}

class ChatbotLoading extends ChatbotState {
  const ChatbotLoading({required super.messages});
}

class ChatbotError extends ChatbotState {
  final String error;
  const ChatbotError({required super.messages, required this.error});

  @override
  List<Object?> get props => [messages, error];
}


