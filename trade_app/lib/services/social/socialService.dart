import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:trade_app/constants/error_handling.dart';

class socialService {
  Future<String> loadUserProfilePictureFromUserId({
    required BuildContext context, 
    required int userId
  }) async {
    try {
      http.Response res = await http.get(Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/social/user/$userId/profilePicture'));
      if (context.mounted) {
        String userProfilePic = '';
        httpErrorHandle(
          response: res, 
          context: context, 
          onSuccess: () {
            userProfilePic = jsonDecode(res.body)['result']['profilePicture'];
          }
        );
        return userProfilePic;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return 'failed to retrieve picture';
  }
}