import 'package:flutter/material.dart';
import '../api/chat_api.dart';
import '../models/chat_message.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_composer.dart';
import '../widgets/reusableWidget.dart';

class chatPage extends StatefulWidget {
  const chatPage({super.key});

  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  final ChatApi chatApi = ChatApi();
  final _messages = <ChatMessage>[
    ChatMessage('Hello, how can I help?', false),
  ];
  var _awaitingResponse = false;

  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusScope.of(context).requestFocus(FocusNode());
        // FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: ReusableWidgets.persistentAppBar('ChatGPT'),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ..._messages.map(
                    (msg) => MessageBubble(
                      content: msg.content,
                      isUserMessage: msg.isUserMessage,
                    ),
                  ),
                ],
              ),
            ),
            MessageComposer(
              onSubmitted: _onSubmitted,
              awaitingResponse: _awaitingResponse,
            ),
          ],
        ),
      )
    );
  }

  Future<void> _onSubmitted(String message) async {
    setState(() {
      _messages.add(ChatMessage(message, true));
      _awaitingResponse = true;
    });
    try {
      final response = await chatApi.completeChat(_messages);
      setState(() {
        _messages.add(ChatMessage(response, false));
        _awaitingResponse = false;
      });
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again.')),
      );
      setState(() {
        _awaitingResponse = false;
      });
    }
  }
}
