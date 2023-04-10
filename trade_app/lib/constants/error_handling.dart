import 'dart:convert';

import '/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
  VoidCallback? onDuplicates
}) {
  switch (response.statusCode) {
    // OK
    case 200: onSuccess();
      break;
    // created
    case 201: onSuccess();
      break;
    // Bad request
    case 400: showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    // forbidden
    case 403: showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    // duplicated request
    case 409: onDuplicates!();
      break;
    // internal server error
    case 500: showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default: showSnackBar(context, response.body);
  }
}