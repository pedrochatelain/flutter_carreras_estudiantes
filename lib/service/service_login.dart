import 'dart:io';

import 'package:http/http.dart' as http;

class ServiceLogin {
  final String uriLogin = 'http://192.168.0.149:8080/login';

  Future<http.Response> login(String username, String password) async {
    Map<String, dynamic> formDataMap = <String, dynamic>{};

    formDataMap['username'] = username;
    formDataMap['password'] = password;

    return http
        .post(
      Uri.parse(uriLogin),
      body: formDataMap,
    )
        .timeout(
      const Duration(seconds: 1),
      onTimeout: () {
        return http.Response(
            'Timeout: The request took too long', HttpStatus.requestTimeout);
      },
    );
  }
}
