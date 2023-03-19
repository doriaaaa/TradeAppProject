import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';

class getUserInfo {
  Future<String> getUploadedBookInfo({
    required BuildContext context
  }) async {
    // send get request to retrieve the info of user
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.get(
        Uri.parse('http://${dotenv.env['IP_ADDRESS']}:3000/api/user/bookList'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        }
      );
      // debugPrint(res.body);
      return res.body;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Failed to load user data");
    }
  }
}
