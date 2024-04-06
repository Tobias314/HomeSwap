import 'package:dating_app/constants/colors.dart';
import 'package:dating_app/pages/user_info_page_4.dart';
import 'package:flutter/material.dart';


class ProfileCard4 extends StatelessWidget {
  const ProfileCard4({Key? key, required this.image}) : super(key: key);
  final String image;

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
              Navigator.push(
                context,
                MaterialPageRoute(builder:  (context) => UserInfoPage4(image: image))
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(image.toString()),
                  fit: BoxFit.cover,
                ),
                )
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
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Wohnung in Berlin Charlottenburg, 75 m²', style: TextStyle(color: ColorConstants.secondary, fontSize: 25, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}