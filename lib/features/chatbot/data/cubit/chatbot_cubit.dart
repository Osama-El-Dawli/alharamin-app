import 'package:alharamin_app/features/chatbot/data/models/chat_message.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

part 'chatbot_state.dart';

class ChatbotCubit extends Cubit<ChatbotState> {
  late final GenerativeModel _model;
  late final ChatSession _chat;

  ChatbotCubit() : super(const ChatbotInitial()) {
    _initializeChat();
  }

  void _initializeChat() {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null) {
      if (kDebugMode) {
        print('Error: GEMINI_API_KEY not found in .env file');
      }
      emit(
        ChatbotError(
          messages: state.messages,
          error: 'Gemini API Key not configured.',
        ),
      );
      return;
    }
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
      systemInstruction: Content.system(
        'You are a helpful assistant for a clinic app. Your goal is to suggest potential medical specialities based on the symptoms described by the user. '
        'You MUST ALWAYS start your response with the following disclaimer: "Disclaimer: I am an AI assistant and cannot provide medical advice. This suggestion is for informational purposes only. Please consult a qualified healthcare professional for diagnosis and treatment."'
        'After the disclaimer, analyze the symptoms and suggest ONE or TWO most likely relevant medical specialities. Keep your explanation brief.'
        'Respond in the language of the user\'s input.',
      ),
      generationConfig: GenerationConfig(temperature: 0.3),
    );

    _chat = _model.startChat(
      history:
          state.messages.map((msg) {
            return Content(msg.isUser ? 'user' : 'model', [TextPart(msg.text)]);
          }).toList(),
    );
  }

  Future<void> sendMessage(String text) async {
    final userMessage = ChatMessage(isUser: true, text: text);
    final currentMessages = List<ChatMessage>.from(state.messages)
      ..add(userMessage);

    emit(ChatbotLoading(messages: currentMessages));

    try {
      final response = await _chat.sendMessage(Content.text(text));
      final botResponseText = response.text;

      if (botResponseText == null || botResponseText.isEmpty) {
        emit(
          ChatbotError(
            messages: currentMessages,
            error: 'Received no response from AI.',
          ),
        );
      } else {
        final botMessage = ChatMessage(isUser: false, text: botResponseText);
        final updatedMessages = List<ChatMessage>.from(currentMessages)
          ..add(botMessage);
        emit(ChatbotLoading(messages: updatedMessages));
      }
    } catch (e) {
      emit(
        ChatbotError(
          messages: currentMessages,
          error: 'Failed to send message: ${e.toString()}',
        ),
      );
    }
  }
}
