import 'package:http/http.dart' as http;
import 'dart:convert';

// Not tested yet
Future<void> setUserPreferences({
  required String userid,
  required String max_price,
  required String min_size,
  required String min_rooms,
}) async {

  print('set pref');
  final response = await http.post(
    Uri.parse('https://d2ed-2001-638-807-23a-bfba-ff45-f08c-ffad.ngrok-free.app/user/$userid/set_preferences'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'ngrok-skip-browser-warning': '1'
    },
    body: jsonEncode(<String, String>{
      'max_price': max_price,
      'min_size': min_size,
      'min_rooms': min_rooms,
    })
  );
    print('set pref');

  if (response.statusCode == 200) {
    print('Preferences were set!');
  } else {
    // Handle errors
    print('Failed to fetch matching options. Status Code: ${response.statusCode}');
  }
}
