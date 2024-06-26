import 'package:dating_app/constants/colors.dart';
import 'package:dating_app/pages/user_info_page.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key, 
    required this.image, 
    required this.displayText, // Add a new parameter for the text
  }) : super(key: key);

  final String image;
  final String displayText; // New field to store the passed text

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => UserInfoPage(image: image))
              // );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(image.toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 0,
            child: Container(
              height: 104,
              width: MediaQuery.of(context).size.width / 1.2,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16), 
                  bottomLeft: Radius.circular(16)
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Use the `displayText` to show the text dynamically
                  Text(
                    displayText, 
                    style: TextStyle(
                      color: ColorConstants.secondary, 
                      fontSize: 25, 
                      fontWeight: FontWeight.w500
                    )
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
