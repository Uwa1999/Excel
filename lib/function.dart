import 'package:http/http.dart' as http;
import 'login_api.dart';

class LoginScreenFunctions {
  static Future<http.Response> loginApiFunction({
    String username = "",
    String password = '',
  }) async {
    loginApi api = loginApi();
    http.Response getParamReturn = await api.LoginApi(username, password);
    return getParamReturn;
  }
}
