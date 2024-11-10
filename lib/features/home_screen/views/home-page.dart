import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vasu/features/home_screen/utils/homepage-welcome-panel.dart';
import 'package:vasu/features/home_screen/utils/homepage_action_button.dart';
import 'package:vasu/features/text_to_speech/views/speechToSign.dart';
import 'package:vasu/shared/constants/app_proportions.dart';

import '../../ISL_to_text/screen.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
  Size get preferredSize => Size.fromHeight(120.0); // Set AppBar height
}

class _Home_pageState extends State<Home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        WelcomePanel(),
        SizedBox(height: AppProportions.verticalSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomepageButton(
              icon: Icons.text_fields,
              title: "Text".tr,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SpeechScreen()));
              },
            ),
            HomepageButton(
              title: "Voice".tr,
              icon: Icons.mic,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SpeechScreen()));
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomepageButton(
              title: "ISL Signs".tr,
              icon: Icons.camera_alt,
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>SocketApp()));},
            ),
            HomepageButton(
              title: "Upload".tr,
              icon: Icons.image,
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>SocketApp()));},
            ),
          ],
        ),
      ],
    ));
  }
}
