import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:dating_app/constants/colors.dart';
import 'package:dating_app/pages/profile_page.dart';
import 'package:dating_app/widgets/profile_card.dart';
import 'package:dating_app/widgets/profile_card_4.dart';
import 'package:flutter/material.dart';
import 'offer_page.dart'; 


class SwipePage4 extends StatefulWidget {
  const SwipePage4({Key? key}) : super(key: key);

  @override
  State<SwipePage4> createState() => _SwipePage4State();
}

class _SwipePage4State extends State<SwipePage4> {
  List<ProfileCard4> profile = [];

  List<String> images = [
    'assets/images/tauschwohnung15.jpg',
  ];

  int rating = 0;
  void setRating(int value) {
    setState(() {
      rating = value;
    });
  }
  
  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFFEFB20A),
        titleTextStyle: const TextStyle(  
              color: Colors.white,
              fontSize: 30,
              ),
        title: const Text('For You',),
        leading: IconButton(
          icon: Icon(
            Icons.person,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.message,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          AppinioSwiper(
            padding: const EdgeInsets.only(bottom: 130, top: 16),
            cards: profile,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.only(bottom: 50),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.white.withOpacity(0.6),
                    Colors.white.withOpacity(0),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0), // Adjust spacing between stars
                        child: IconButton(
                          onPressed: () {
                            setRating(index + 1);
                            // Navigate to OfferPage after setting the rating
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const OfferPage()),
                            );
                          },
                          icon: Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: index < rating
                                ? const Color(0xFFEFB20A)
                                : const Color.fromARGB(255, 211, 211, 211),
                            size: 50, // Adjust size of the stars
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _loadCards() {
    for (String image in images) {
      profile.add(ProfileCard4(image: image));
    }
  }
}