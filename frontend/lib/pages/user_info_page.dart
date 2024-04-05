import 'package:dating_app/constants/colors.dart';
import 'package:flutter/material.dart';

class UserInfoPage extends StatelessWidget {
  UserInfoPage({ Key? key, required this.image,x}) : super(key: key);
  final String image;

  List<String> images = [
    'assets/images/example1.jpg',
    'assets/images/example2.jpg',
    'assets/images/example3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: ColorConstants.primaryColor,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: IconButton(
              icon: Icon(Icons.more_vert, color: ColorConstants.primaryColor,),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  margin: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(50)),
                    image: DecorationImage(
                      image: AssetImage(image),
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
                        Text('Wohnung in Berlin Neukölln, 55 m²', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: ColorConstants.secondary)),
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
                    const SizedBox(height: 26,),
                    Text('Zimmer: 2', style: TextStyle(color: ColorConstants.secondary, fontSize: 16)),
                    const SizedBox(height: 8,),
                    Text('Kaltmiete: 413€', style: TextStyle(color: ColorConstants.secondary, fontSize: 16)),
                    const SizedBox(height: 8,),
                    Text('Nebenkosten: 175€', style: TextStyle(color: ColorConstants.secondary, fontSize: 16)),
                    const SizedBox(height: 8,),
                    Text('Stockwerk: 1', style: TextStyle(color: ColorConstants.secondary, fontSize: 16)),
                    const SizedBox(height: 8,),
                  ],
                ),
              ),
              ),
            ]
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
                  InkWell(
                    onTap: () { },
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(Icons.close, color: ColorConstants.close, size: 32,),
                    ),
                  ),
                  InkWell(
                    onTap: () { },
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(Icons.star, color: ColorConstants.star, size: 32,),
                    ),
                  ),
                  InkWell(
                    onTap: () { },
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(Icons.favorite, color: ColorConstants.favorite, size: 32,),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _chip({required Color background, required Color color, required String title}) {
    return Chip(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      label: Text(title, style: TextStyle(color: color)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      backgroundColor: background,
    );
  }
}