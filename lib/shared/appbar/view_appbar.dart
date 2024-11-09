import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vasu/shared/constants/app_proportions.dart';

class appbar extends StatefulWidget implements PreferredSizeWidget {
  final IconData initialFloatingIcon;
  final VoidCallback onFloatingButtonPressed;
  final String Title;

  appbar({
    Key? key,
    required this.initialFloatingIcon,
    required this.onFloatingButtonPressed,
    required this.Title,
  }) : super(key: key);

  @override
  _appbarState createState() => _appbarState();

  @override
  Size get preferredSize => Size.fromHeight(75); // Set app bar height
}

class _appbarState extends State<appbar> {
  late IconData floatingIcon;

  @override
  void initState() {
    super.initState();
    floatingIcon = widget.initialFloatingIcon; // Set the initial icon
  }

  // Method to change the floating icon dynamically
  void updateIcon(IconData newIcon) {
    setState(() {
      floatingIcon = newIcon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: AppProportions.screenWidth * 0.85,
              height: AppProportions.screenHeight * 0.11,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/icons/curved-appbar.png'), // Background image
                  fit: BoxFit.fill,
                ),
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(12)),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            "assets/icons/Hamburger.png",
                            height: 40,
                            width: 40,
                          )),
                      Text(
                        widget.Title,
                        style: GoogleFonts.mulish(
                            color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * (1 / 6) - 27,
            top: 20,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(
                    10,
                  )),
              onPressed: widget.onFloatingButtonPressed,
              child: Icon(floatingIcon),
              mini: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
