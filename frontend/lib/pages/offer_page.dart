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
        imagePath: "assets/images/example1.jpg",
        name: "Angebot 1",
        description: "Zimmer in 2er WG in Berlin Neukölln, 20 m²",
      ),
      ImageData(
        imagePath: "assets/images/example2.jpg",
        name: "Angebot 2",
        description: "Wohnung in Berlin Moabit, 55 m²",
      ),
      ImageData(
        imagePath: "assets/images/example3.jpg",
        name: "Angebot 3",
        description: "Appartment in Berlin Friedrichshain, 45 m²",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Wir haben ein paar ein paar Matches für dich!'),
      ),
      body: ListView.separated(
        itemCount: imageDataList.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          final imageData = imageDataList[index];
          return ListTile(
            leading: Image.asset(imageData.imagePath),
            title: Text(imageData.name),
            subtitle: Text(imageData.description),
            trailing: ElevatedButton(
              onPressed: () {
                // Add your logic for "Match akzeptieren" button press here
                print('Match akzeptieren pressed for ${imageData.name}');
              },
              child: Text('Match akzeptieren'),
            ),
          );
        },
      ),
    );
  }
}

