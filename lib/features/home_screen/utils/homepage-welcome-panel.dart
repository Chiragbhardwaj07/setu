import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:sanket/features/authentication/data/services/user_local_service.dart';
//import 'package:sanket/shared/constants/size_proportions.dart';
import 'package:vasu/shared/constants/app_proportions.dart';

class WelcomePanel extends StatefulWidget implements PreferredSizeWidget {
  @override
  _WelcomePanelState createState() => _WelcomePanelState();

  @override
  Size get preferredSize => Size.fromHeight(500.0); // Set AppBar height to 500
}

class _WelcomePanelState extends State<WelcomePanel> {
  //final UserLocalService _userLocalService = UserLocalService();
  String firstName = ''; // To store only the first name

  @override
  void initState() {
    super.initState();
    // loadUserName();
  }

  // Future<void> loadUserName() async {
  //   final user = await _userLocalService.getUserFromHive();
  //   setState(() {
  //     firstName = (user?.name ?? '').split(' ').first; // Extract the first name
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: AppProportions.screenWidth * 0.85,
          height: AppProportions.screenHeight * 0.42,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/icons/homepage_appbar.png'), // Background image
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: AppProportions.screenHeight * 0.04,
                left: AppProportions.screenWidth * 0.05,
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/icons/Hamburger.png",
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
              Positioned(
                top: AppProportions.screenHeight * 0.13,
                left: AppProportions.screenWidth * 0.08,
                child: Text.rich(
                  TextSpan(
                    text: 'Hello, '.tr,
                    style: GoogleFonts.mulish(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: firstName,
                        style: GoogleFonts.mulish(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            '\n\nWhat do you \nwant to \ntranslate \ntoday?'.tr,
                        style: GoogleFonts.mulish(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 18,
                child: Container(
                  width: 150,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/letters/space.png'), // Profile image
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
