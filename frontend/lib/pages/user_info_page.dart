import 'package:flutter/material.dart';
import 'package:dating_app/constants/colors.dart';
import 'offer_page.dart'; 

class UserInfoPage extends StatefulWidget {
  UserInfoPage({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  List<String> images = [
    'assets/images/example1.jpg',
  ];

  int rating = 0;
  void setRating(int value) {
    setState(() {
      rating = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, right: 8,),
            child: IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                margin: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.only(bottomLeft: Radius.circular(50)),
                  image: DecorationImage(
                    image: AssetImage(widget.image),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                    scale: 1.1,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Wohnung in Berlin Neukölln, 55 m²',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: ColorConstants.secondary)),
                        const SizedBox(width: 10),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: ColorConstants.active,
                            shape: BoxShape.circle,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    Text('Zimmer: 2',
                        style: TextStyle(
                            color: ColorConstants.secondary, fontSize: 20)),
                    const SizedBox(
                      height: 8,
                    ),
                    Text('Kaltmiete: 413€',
                        style: TextStyle(
                            color: ColorConstants.secondary, fontSize: 20)),
                    const SizedBox(
                      height: 8,
                    ),
                    Text('Nebenkosten: 175€',
                        style: TextStyle(
                            color: ColorConstants.secondary, fontSize: 20)),
                    const SizedBox(
                      height: 8,
                    ),
                    Text('Stockwerk: 1',
                        style: TextStyle(
                            color: ColorConstants.secondary, fontSize: 20)),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          ]),
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
                            setRating(index + 1);
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
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
