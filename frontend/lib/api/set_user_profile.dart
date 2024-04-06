import 'package:http/http.dart' as http;
import 'dart:convert';

// Not tested yet
Future<void> setUserProfile({
  required String userid,
  required String price,
  required String size,
  required String rooms,
}) async {
  final response = await http.post(
    Uri.parse('https://d2ed-2001-638-807-23a-bfba-ff45-f08c-ffad.ngrok-free.app/user/$userid/set_profile'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'ngrok-skip-browser-warning': '1'
    },
    body: jsonEncode(<String, String>{
      'price': price,
      'size': size,
      'rooms': rooms,
    })
  );

  if (response.statusCode == 200) {
  } else {
    // Handle errors
    print('Failed to set profile ${response.statusCode}');
  }
}
