import 'dart:convert';
import 'package:http/http.dart' as http;

class loginApi {
  Future<http.Response> LoginApi(String username, password) async {
    http.Response getResponse = await http.post(
      Uri.parse('http://10.21.0.43:8070/api/public/v1/auth/signIn'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'username': username,
          'password': password,
        },
      ),
    );
    return getResponse;
  }
}
