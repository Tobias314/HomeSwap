import 'package:http/http.dart' as http;
import 'dart:convert';

// Not tested yet
Future<void> sendPreferences({
  required String myID,
  required String theirID,
  required int score
}) async {
  final response = await http.post(
    Uri.parse('https://d2ed-2001-638-807-23a-bfba-ff45-f08c-ffad.ngrok-free.app/preferences/$myID/$theirID'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'ngrok-skip-browser-warning': '1'
    },
    body: <int>{
      score
    }
  );

  if (response.statusCode == 200) {
    // Parse the JSON response
    String body = String.fromCharCodes(response.bodyBytes);
    final data = jsonDecode(body);
    print('Matching options: ${data[0]}');
    return data[0];
  } else {
    // Handle errors
    print('Failed to fetch matching options. Status Code: ${response.statusCode}');
  }
}

Future<void> test_sendPreferences() async {
  // Mock data for testing
  return await sendPreferences(theirID: "a", myID: "a", score: 7);
}
