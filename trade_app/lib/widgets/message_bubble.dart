import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../provider/user_provider.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    required this.content,
    required this.isUserMessage,
    super.key,
  });

  final String content;
  final bool isUserMessage;
  
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    String profilePicture = context.watch<UserProvider>().user.profilePicture;

    if (!isUserMessage) {
      return Row(
        children: <Widget>[
          Container(
            width: 10.w,
            height: 10.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/chatgpt.jpg'), 
                fit: BoxFit.scaleDown
              )
            ),
          ),
          Expanded(
            child: BubbleSpecialThree(
              text: content,
              color: themeData.colorScheme.primary.withOpacity(0.4),
              tail: false,
              textStyle: TextStyle(
                color: themeData.brightness == Brightness.dark
                  ? Colors.white 
                  : Colors.black
              ),
              isSender: false,
            )
          )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: BubbleSpecialThree(
              text: content,
              color: themeData.colorScheme.primary.withOpacity(0.4),
              tail: false,
              textStyle: TextStyle(
                color: themeData.brightness == Brightness.dark
                  ? Colors.white 
                  : Colors.black
              ),
              isSender: true,
            )
          ),
          Container(
            width: 10.w,
            height: 10.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(profilePicture), //dummy image
                fit: BoxFit.scaleDown
              )
            ),
          ),
        ],
      );
    }
  }
}
