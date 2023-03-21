import 'package:dart_openai/openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/chat_message.dart';

class ChatApi {
  static const _model = 'gpt-3.5-turbo';

  ChatApi() {
    OpenAI.apiKey = "${dotenv.env['CHATGPT_APIKEY']}";
    // OpenAI.organization = openAiOrg;
  }

  Future<String> completeChat(List<ChatMessage> messages) async {
    final chatCompletion = await OpenAI.instance.chat.create(
      model: _model,
      messages: messages
        .map((e) => OpenAIChatCompletionChoiceMessageModel(
              role: e.isUserMessage ? 'user' : 'assistant',
              content: e.content,
            ))
        .toList(),
    );
    return chatCompletion.choices.first.message.content;
  }
}
