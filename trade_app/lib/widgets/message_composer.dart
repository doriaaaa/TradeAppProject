import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MessageComposer extends StatelessWidget {
  MessageComposer({
    required this.onSubmitted,
    required this.awaitingResponse,
    super.key,
  });

  final TextEditingController _messageController = TextEditingController();

  final void Function(String) onSubmitted;
  final bool awaitingResponse;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.w),
      // color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.05),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: !awaitingResponse
                ? TextFormField(
                    maxLines: null,
                    controller: _messageController,
                    // onSubmitted: onSubmitted,
                    decoration: InputDecoration(
                      hintText: 'Ask questions here...',
                      filled: true,
                      contentPadding: EdgeInsets.all(3.w),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: !awaitingResponse
                          ? () => onSubmitted(_messageController.text)
                          : null,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      const SizedBox( child: CircularProgressIndicator() ),
                      SizedBox(width: 2.w),
                      const Text('Fetching response...'),
                    ],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
