import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../api/chat_api.dart';
import '../constants/utils.dart';
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
    final scollBarController = ScrollController(initialScrollOffset: 50.0);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: ReusableWidgets.persistentAppBar('ChatGPT'),
        body: Column(
          children: [
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                controller: scollBarController,
                child: ListView(
                  shrinkWrap: true,
                  controller: scollBarController,
                  padding: EdgeInsets.only(left: 4.0.w, right: 4.0.w),
                  children: [
                    ..._messages.map(
                      (msg) => MessageBubble(
                        content: msg.content,
                        isUserMessage: msg.isUserMessage,
                      ),
                    ),
                  ],
                ),
              )
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
      showSnackBar( context, 'An error occurred. Please try again.');
      setState(() {
        _awaitingResponse = false;
      });
    }
  }
}
