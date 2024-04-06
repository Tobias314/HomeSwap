import 'package:dating_app/pages/confetti_page.dart';
import 'package:dating_app/pages/swipe_page.dart';
import 'package:flutter/material.dart';

// Define a data class for the image data
class ImageData {
  final String imagePath;
  final String name;
  final String description;

  ImageData({
    required this.imagePath,
    required this.name,
    required this.description,
  });
}

class OfferPage extends StatelessWidget {
  const OfferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define a list of ImageData objects
    List<ImageData> imageDataList = [
      ImageData(
        imagePath: "assets/images/tauschwohnung15.jpg",
        name: "Wohnung in Berlin Charlottenburg, 75 m²",
        description: "4 Zimmer, 647€ Kaltmiete",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Neues Match gefunden!'),
        backgroundColor: const Color(0xFFEFB20A),
        titleTextStyle: const TextStyle(  
              color: Colors.white,
              fontSize: 30,
              )
      ),
      body: ListView.separated(
        itemCount: imageDataList.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          final imageData = imageDataList[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                imageData.imagePath,
                fit: BoxFit.cover, // Ensure the image covers the entire area
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      imageData.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(imageData.description),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Add your logic for "Match akzeptieren" button press here
                    print('Match akzeptieren pressed for ${imageData.name}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ConfettiPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFEFB20A), // Set the button color to red
                  ),
                  child: const Text(
                    'Match akzeptieren',
                    style: TextStyle(color: Colors.white), // Set text color to black
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Add your logic for "Match akzeptieren" button press here
                    print('Match abgelehnt pressed for ${imageData.name}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SwipePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 204, 38, 27), // Set the button color to red
                  ),
                  child: Text(
                    'Match ablehnen',
                    style: TextStyle(color: Colors.white), // Set text color to black
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
