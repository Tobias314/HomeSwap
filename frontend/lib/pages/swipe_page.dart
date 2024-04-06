
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:dating_app/constants/colors.dart';
import 'package:dating_app/cubits/currentHomeCubit.dart';
import 'package:dating_app/pages/profile_page.dart';
import 'package:dating_app/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  List<String> images = [
    'assets/images/example1.jpg',
    'assets/images/example2.jpg',
    'assets/images/example3.jpg',
  ];

  int rating = 0;
  void setRating(String myID, String theirID, int score) {
    // Update the Cubit state
    sendPreferences(myID: myID, theirID: theirID, score:score);
  }
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Ensure this future is initialized outside build or in initState to avoid re-creating it on every build
    final Future<String> optionIDfuture = _loadCards();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFFEFB20A),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
        title: const Text('For You'),
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
      body: FutureBuilder<String>(
        future: optionIDfuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return Stack(
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
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: IconButton(
                              onPressed: () {
                                String myID = getMyID();
                                // Assuming optionID is now obtained differently, perhaps from profile
                                // Adjust this part to your logic of obtaining optionID after loading
                                String optionID = "someOptionID";
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
                                size: 50,
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
          );
        },
      ),
    );
  }


  Future<String> _loadCards() async{
    // TODO: make work
    String myID = getMyID();
    final data = await fetchMatchingOptions(ID: myID);
    // TODO: Make several images possible 
    String image = data['img_url'];
    String zimmern = data['offer_rooms']?.toString() ?? '2';
    String preis =  data['offer_prize']?.toString() ?? '400';
    String groesse =  data['offer_size']?.toString() ?? '15';
    profile.add(ProfileCard(image: images[0], displayText: "Wohnung mit $zimmern zimmern für $preis € $groesse Quadratmeter"));
    // for (String image in images) {
    //   profile.add(ProfileCard(image: image));
    // }
    return data['username'];
  }

  String getMyID(){
    final myCubitState = context.read<CurrentHomeCubit>().state;
    return myCubitState.id;
  }

}