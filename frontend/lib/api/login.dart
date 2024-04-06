import 'package:http/http.dart' as http;
import 'dart:convert';

// Not tested yet
Future<String> login({
  required String username,
  required String password,
}) async {
  print('Logging in with username: $username and password: $password');
  final response = await http.post(
    Uri.parse('https://d2ed-2001-638-807-23a-bfba-ff45-f08c-ffad.ngrok-free.app/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'ngrok-skip-browser-warning': '1'
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'pw': password,
    })
  );

  if (response.statusCode == 200) {
    // Parse the JSON response
    String userid = String.fromCharCodes(response.bodyBytes);
    print('got back userid: $userid');
    return userid;
  } else {
    // Handle errors
    print('Failed to login. Status Code: ${response.statusCode}');
    throw Exception('Failed to login.');
  }
}
