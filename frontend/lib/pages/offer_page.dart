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
        imagePath: "assets/images/example2.jpg",
        name: "Wohnung in Berlin Moabit, 55 m²",
        description: "3 Zimmer, 800€ Kaltmiete",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Wir haben ein paar ein Match für dich!'),
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
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
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
                  child: Text('Match akzeptieren'),
                ),
              ),
              SizedBox(height: 12),
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
                  // style: ElevatedButton.styleFrom(
                  //   primary: Colors.red, // Set the button color to red
                  // ),
                  child: Text('Match ablehnen'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
