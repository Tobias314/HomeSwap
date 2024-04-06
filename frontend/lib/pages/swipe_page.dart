import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:dating_app/constants/colors.dart';
import 'package:dating_app/pages/profile_page.dart';
import 'package:dating_app/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../api/fetch_options.dart';
import '../api/send_preference.dart';
import 'offer_page.dart'; 


class SwipePage extends StatefulWidget {
  const SwipePage({Key? key}) : super(key: key);

  @override
  State<SwipePage> createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  List<ProfileCard> profile = [];
  var optionID;

  // List<String> images = [
  //   'assets/images/example1.jpg',
  //   'assets/images/example2.jpg',
  //   'assets/images/example3.jpg',
  // ];

  int rating = 0;
  void setRating(String myID, String theirID, int score) {
    // Update the Cubit state
    sendPreferences(myID: myID, theirID: theirID, score:score);
  }
  
  @override
  void initState() {
    super.initState();
    optionID = _loadCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('For You',
            style: TextStyle(
                color: ColorConstants.primaryColor,
                fontSize: 28,
                fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(
            Icons.person,
            color: ColorConstants.primaryColor,
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
            icon: Icon(
              Icons.message,
              color: ColorConstants.primaryColor,
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
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0), // Adjust spacing between stars
                        child: IconButton(
                          onPressed: () {
                            String myID = getMyID();
                            setRating(myID, optionID, index + 1);
                            // Navigate to OfferPage after setting the rating
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => OfferPage()),
                            );
                          },
                          icon: Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: index < rating
                                ? Color.fromARGB(255, 230, 173, 17)
                                : Colors.grey,
                            size: 50, // Adjust size of the stars
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _loadCards() async{
    // TODO: make work
    String myID = getMyID();
    final data = await fetchMatchingOptions(ID: myID); 
    List<String> images = data['images'];
    for (String image in images) {
      profile.add(ProfileCard(image: image));
    }
    return data['ID'];
  }

  String getMyID(){
    // TODO implement as Cubit
    return "a";
  }

}
