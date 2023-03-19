import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../constants/error_handling.dart';
import '../../constants/utils.dart';
import '../../provider/user_provider.dart';

class threadService {
  void createNewThread({
    required BuildContext context,
    required String title,
    required String content
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
          Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/upload/createThread'),
          body: jsonEncode({
            'title': title,
            'content': content,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          });
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            showSnackBar(context, "Thread created.");
            Navigator.pushNamed(context, "/home");
          },
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
