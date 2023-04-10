import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MessageComposer extends StatelessWidget {
  MessageComposer({
    required this.onSubmitted,
    required this.awaitingResponse,
    super.key,
  });

  final void Function(String) onSubmitted;
  final bool awaitingResponse;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _messageController = TextEditingController();

    void _handleSubmit(GlobalKey<FormState> formKey, TextEditingController messageController) {
      if (formKey.currentState!.validate()) { // Validate the form before submitting.
        onSubmitted(messageController.text);
        messageController.clear();
      }
    }

    return Container(
      padding: EdgeInsets.all(3.w),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: !awaitingResponse
                ? Form(
                    key: _formKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'You need to input at least 1 character';
                        return null;
                      },
                      maxLines: null,
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Ask questions here...',
                        filled: true,
                        contentPadding: EdgeInsets.all(3.w),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () => _handleSubmit(_formKey, _messageController),
                        ),
                      ),
                    ) 
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      const SizedBox( child: CupertinoActivityIndicator() ),
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
