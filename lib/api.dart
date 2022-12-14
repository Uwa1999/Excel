import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/token.dart';

import 'model.dart';

class Api {
  Future<http.Response> getFunction() async {
    http.Response getResponse = await http.post(
      Uri.parse(
          'http://10.21.0.43:8070/api/private/v1/pendings/generateReport'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Thetoken.GetToken()}',
      },
      body: jsonEncode(
        <String, String>{"startDate": "2022-11-22", "endDate": "2022-11-23"},
      ),
    );
    // print('Token');
    // print(getResponse);
    return getResponse;
  }
}

class HttpParse {
  Future<Report> profile() async {
    Api httpPush = Api();
    http.Response res = await httpPush.getFunction();
    print(res.body);
    var inqq = Report.fromJson(jsonDecode(res.body));
    return inqq;
  }
}
