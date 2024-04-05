import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> fetchMatchingOffers({
  required int ID,
  required String offerPrice,
  required String offerSize,
  required int offerRooms,
  required String prefMaxPrice,
  required String prefMinSize,
  required int prefMinRooms,
}) async {
  final response = await http.post(
    Uri.parse('https://your-api-domain.com/api/offers/match'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "ID": ID,
      "offer_price": offerPrice,
      "offer_size": offerSize,
      "offer_rooms": offerRooms,
      "pref_max_price": prefMaxPrice,
      "pref_min_size": prefMinSize,
      "pref_min_rooms": prefMinRooms,
    }),
  );

  if (response.statusCode == 200) {
    // Parse the JSON response
    final data = jsonDecode(response.body);
    print('Matching offers: ${data['matches']}');
  } else {
    // Handle errors
    print('Failed to fetch matching offers. Status Code: ${response.statusCode}');
  }
}
