import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:task_manager/data/models/response_object.dart';
import 'package:task_manager/presentation/controller/auth_controller.dart';

class NetworkCaller {
  static Future<ResponseObject> getRequest(String url) async {
    try {
      log(url);
      log(AuthController.accessToken.toString());
      final Response response = await get(Uri.parse(url),
          headers: {'token': AuthController.accessToken ?? ''});

      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return ResponseObject(
            isSuccess: true, statusCode: 200, responseBody: decodedResponse);
      } else {
        return ResponseObject(
            isSuccess: false,
            statusCode: response.statusCode,
            responseBody: '');
      }
    } catch (e) {
      log(e.toString());
      return ResponseObject(
          isSuccess: false,
          statusCode: -1,
          responseBody: '',
          errorMessage: e.toString());
    }
  }

  static Future<ResponseObject> postRequest(
      String url, Map<String, dynamic> body) async {
    try {
      log(url);
      log(body.toString());
      final Response response = await post(Uri.parse(url),
          body: jsonEncode(body),
          headers: {
            'content-type': 'application/json',
            'token': AuthController.accessToken ?? ''
          });

      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return ResponseObject(
            isSuccess: true, statusCode: 200, responseBody: decodedResponse);
      } else if (response.statusCode == 401) {
        return ResponseObject(
          isSuccess: false,
          statusCode: response.statusCode,
          responseBody: '',
          errorMessage: 'Email/Password incorrect try again',
        );
      } else {
        return ResponseObject(
          isSuccess: false,
          statusCode: response.statusCode,
          responseBody: '',
        );
      }
    } catch (e) {
      log(e.toString());
      return ResponseObject(
          isSuccess: false,
          statusCode: -1,
          responseBody: '',
          errorMessage: e.toString());
    }
  }
}
