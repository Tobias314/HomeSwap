import 'package:http/http.dart' as http;
import 'dart:convert';

Future<dynamic> fetchMatchingOptions({
  required String ID
}) async {
  final response = await http.get(
    Uri.parse('https://d2ed-2001-638-807-23a-bfba-ff45-f08c-ffad.ngrok-free.app/users/$ID/fetch_options'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'ngrok-skip-browser-warning': '1'
    },
  );

  if (response.statusCode == 200) {
    // Parse the JSON response
    String body = String.fromCharCodes(response.bodyBytes);
    final data = jsonDecode(body);
    print('Matching options: ${data[0]}');
    if (data.isEmpty()) {
      print('No matches found:(');
      return "";
    }else{
      return data[0];
    }
    
  } else {
    // Handle errors
    print('Failed to fetch matching options. Status Code: ${response.statusCode}');
  }
}

Future<void> test_fetch_options() async {
  // Mock data for testing
  return await fetchMatchingOptions(ID: "a");
}
