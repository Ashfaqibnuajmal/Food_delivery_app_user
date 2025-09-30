import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:mera_app/features/home/bloc/ai_chat_event.dart';
import 'package:mera_app/features/home/bloc/ai_chat_state.dart';

class AiChatBloc extends Bloc<AiChatEvent, AiChatState> {
  final String apiKey = "AIzaSyBY5c6Xoy95ohk65AsuTNMIeLlfqcMe8SQ";
  late GenerativeModel model;

  final List<String> allowedKeywords = [
    "cook",
    "recipe",
    "boil",
    "bake",
    "grill",
    "fry",
    "meal",
    "food",
    "curry",
    "rice",
    "chicken",
    "egg",
    "vegetable",
    "cake",
    "snack"
  ];
  AiChatBloc() : super(const AiChatInitial()) {
    model = GenerativeModel(
      model: 'gemini-2.5-pro',
      apiKey: apiKey,
    );
    on<GenerateContentEvent>((event, emit) async {
      final updatedMessages = List<Map<String, dynamic>>.from(state.messages)
        ..add({'text': event.prompt, 'isUser': true});
      bool allowed = allowedKeywords.any((keyword) =>
          event.prompt.toLowerCase().contains(keyword.toLowerCase()));

      if (!allowed) {
        updatedMessages.add({
          'text':
              " Sorry, only food and cooking-related questions are allowed. Please try asking something about recipes, ingredients, or cooking methods.",
          'isUser': false
        });
        emit(AiChatLoaded(messages: updatedMessages));
        return; // Stop further processing
      }
      emit(AiChatLoading(
          messages: updatedMessages, loadingStage: "Thinking..."));
      await Future.delayed(const Duration(seconds: 3));
      emit(AiChatLoading(
          messages: updatedMessages, loadingStage: "Analyzing..."));
      await Future.delayed(const Duration(seconds: 3));
      emit(AiChatLoading(messages: updatedMessages, loadingStage: "Typing..."));
      await Future.delayed(const Duration(seconds: 3));
      try {
        final content = [Content.text(event.prompt)];
        final response = await model.generateContent(content);

        if (response.candidates.isNotEmpty) {
          updatedMessages.add({'text': response.text ?? "", 'isUser': false});
        } else {
          updatedMessages.add({'text': "No response found.", 'isUser': false});
        }

        emit(AiChatLoaded(messages: updatedMessages));
      } catch (error) {
        updatedMessages
            .add({'text': "Error: ${error.toString()}", 'isUser': false});
        emit(AiChatError(error: error.toString(), messages: updatedMessages));
      }
    });
  }
}
